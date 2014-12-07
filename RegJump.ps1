Add-Type -AssemblyName System.Windows.Forms
$tb = New-Object System.Windows.Forms.TextBox
#$tb.Multiline = $true
$tb.Paste()
$Clipboard = $tb.Text

switch -Wildcard ($Clipboard) 
    { 
    "HKLM*" { $Clipboard = $Clipboard.Replace("HKLM", "HKEY_LOCAL_MACHINE") }

    "HKCC*" {$Clipboard = $Clipboard.Replace("HKCC", "HKEY_CURRENT_CONFIG") }

    "HKCR*" { $Clipboard = $Clipboard.Replace("HKCR", "HKEY_CLASSES_ROOT") }

    "HKCU*" { $Clipboard = $Clipboard.Replace("HKCU", "HKEY_CURRENT_USER") }

    "HKU*" {$Clipboard = $Clipboard.Replace("HKU", "HKEY_USERS") }

    default {
        "Couldn't read the key"
        return
    }
}


$Registry_Key ="HKCU:Software\Microsoft\Windows\CurrentVersion\Applets\Regedit"

#Get-ItemProperty -Path $Registry_Key -Name LastKey

Set-ItemProperty -Path $Registry_Key -Name LastKey -Value  "Computer\$Clipboard"

Get-ItemProperty -Path $Registry_Key -Name LastKey

Start-Process "$env:windir\regedit.exe"