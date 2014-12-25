@ECHO OFF

SET ThisScriptDirectory=%~dp0
SET PowerShellScriptPath=%ThisScriptDirectory%RegJump.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%PowerShellScriptPath%'";

tasklist /FI "IMAGENAME eq regedit.exe" 2>NUL | find /I /N "regedit.exe">NUL

:: PAUSE if registry editor didn't start; i.e. there was an error with the key
if "%ERRORLEVEL%"=="1" PAUSE

