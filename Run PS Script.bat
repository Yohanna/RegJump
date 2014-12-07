@ECHO OFF

SET ThisScriptDirectory=%~dp0
SET PowerShellScriptPath=%ThisScriptDirectory%RegJump.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%PowerShellScriptPath%'";


