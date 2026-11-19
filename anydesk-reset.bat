@echo off
setlocal enabledelayedexpansion

:: ==================================================
:: AnyDesk Reset Utility
:: Author: MR Umair Aziz
:: GitHub: https://github.com/mrumaraziz0
:: Purpose: Reset AnyDesk configuration to factory state
:: ==================================================

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] This script requires Administrator privileges.
    echo     Please run as Administrator.
    pause
    exit /b 1
)

title AnyDesk Reset Utility By Umar Aziz
echo [*] Stopping AnyDesk services and processes...

:: Stop service and kill process
sc stop AnyDesk >nul 2>&1
timeout /t 2 /nobreak >nul
taskkill /f /im AnyDesk.exe >nul 2>&1

:: Define paths
set "sysConf=%ProgramData%\AnyDesk"
set "userConf=%APPDATA%\AnyDesk"
set "backup=%TEMP%\AnyDesk_Reset_Backup_%date:~-4%%date:~4,2%%date:~7,2%"

:: Backup (optional but recommended for forensics)
if exist "%userConf%" (
    echo [*] Backing up user config...
    mkdir "%backup%" >nul 2>&1
    xcopy "%userConf%" "%backup%\" /E /H /C /I /Y >nul
)

:: Wipe configs
echo [*] Clearing AnyDesk configuration...
del /f /q "%sysConf%\*.*" >nul 2>&1
del /f /q "%userConf%\*.*" >nul 2>&1
rd /s /q "%sysConf%" >nul 2>&1
rd /s /q "%userConf%" >nul 2>&1

:: Reinstall default config by launching AnyDesk once
echo [*] Reinitializing AnyDesk...
if exist "%ProgramFiles%\AnyDesk\AnyDesk.exe" (
    start "" /min "%ProgramFiles%\AnyDesk\AnyDesk.exe" --silent
) else if exist "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe" (
    start "" /min "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe" --silent
)

timeout /t 5 /nobreak >nul

:: Stop again to leave clean
taskkill /f /im AnyDesk.exe >nul 2>&1
sc stop AnyDesk >nul 2>&1

echo [*] AnyDesk has been reset successfully.
echo     Previous config backed up to: %backup%
echo.
echo [!] Note: A new AnyDesk ID will be generated on next launch.
pause
