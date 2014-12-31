Add-Type -AssemblyName System.Windows.Forms
$tb = New-Object System.Windows.Forms.TextBox
#$tb.Multiline = $true
$tb.Paste()
$Clipboard = $tb.Text


# The '|' is used as an OR operator for the regex matching
$LONG_FORMAT = "HKEY_LOCAL_MACHINE|HKEY_CURRENT_CONFIG|HKEY_CLASSES_ROOT|HKEY_CURRENT_USER|HKEY_USERS"


# Reg Editor is only able to read the long format of registry keys.
# So we need to convert the short to the long one.
switch -Wildcard ($Clipboard)
    {
    "HKLM*" { $Clipboard = $Clipboard.Replace("HKLM", "HKEY_LOCAL_MACHINE") }

    "HKCC*" {$Clipboard = $Clipboard.Replace("HKCC", "HKEY_CURRENT_CONFIG") }

    "HKCR*" { $Clipboard = $Clipboard.Replace("HKCR", "HKEY_CLASSES_ROOT") }

    "HKCU*" { $Clipboard = $Clipboard.Replace("HKCU", "HKEY_CURRENT_USER") }

    "HKU*" {$Clipboard = $Clipboard.Replace("HKU", "HKEY_USERS") }

    default {

        # The clipboard doesn't contain the short format, we need to make sure it's not the long format
        # else abort

        if ( $Clipboard -notmatch $LONG_FORMAT)
        {
            # It's an invalid key
            "Couldn't read the key: $Clipboard"
            return
        }
    }
}


"Opening key: $Clipboard"

# The registry key that regedit reads to determine the last key location

$RegEditor_LastKey ="HKCU:Software\Microsoft\Windows\CurrentVersion\Applets\Regedit"

#Get-ItemProperty -Path $RegEditor_LastKey -Name LastKey

Set-ItemProperty -Path $RegEditor_LastKey -Name LastKey -Value  "Computer\$Clipboard"

Get-ItemProperty -Path $RegEditor_LastKey -Name LastKey

Start-Process "$env:windir\regedit.exe"
