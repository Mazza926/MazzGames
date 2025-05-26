@echo off
title Mode Gaming - ON
:: 1) Auto-élévation
if "%~1" neq "/elev" (
  net session >nul 2>&1 || (
    powershell -NoProfile -Command "Start-Process '%~f0' -ArgumentList '/elev' -Verb RunAs"
    exit /b
  )
)

:: 2) Couleur verte
color 2

echo ================================
echo      MODE GAMING ACTIVÉ
echo ================================

:: 3) Désactivation services non-essentiels
for %%S in (
  DiagTrack
  dmwappushservice
  WerSvc
  WSearch
  SysMain
  OneSyncSvc
  XblAuthManager
  XblGameSave
  XboxGipSvc
  XboxNetApiSvc
  MapsBroker
  PrintSpooler
  TabletInputService
  Fax
  "Bonjour Service"
) do (
  echo [Service] Arrêt et désactivation de %%~S...
  sc stop "%%~S"
  sc config "%%~S" start= disabled
  echo.
)

:: 4) Fermeture processus UWP et apps en arrière-plan
for %%P in (
  OneDrive.exe
  SearchUI.exe
  GameBar.exe
  GameBarFTServer.exe
  XboxAppServices.exe
  YourPhone.exe
  Teams.exe
  Cortana.exe
) do (
  echo [Processus] Fermeture de %%P...
  taskkill /F /IM %%P
  echo.
)

echo =================================
echo Mode gaming ACTIVÉ avec succès !
echo =================================

pause
exit /b
