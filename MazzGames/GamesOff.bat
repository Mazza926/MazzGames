@echo off
title Mode Gaming - OFF
:: 1) Auto-élévation
if "%~1" neq "/elev" (
  net session >nul 2>&1 || (
    powershell -NoProfile -Command "Start-Process '%~f0' -ArgumentList '/elev' -Verb RunAs"
    exit /b
  )
)

:: 2) Couleur rouge
color 4

echo ================================
echo    MODE GAMING DÉSACTIVÉ
echo ================================

:: 3) Réactivation services
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
  echo [Service] Activation et démarrage de %%~S...
  sc config "%%~S" start= demand
  sc start "%%~S"
  echo.
)

:: 4) Fin
echo ================================
echo Mode gaming DÉSACTIVÉ avec succès !
echo ================================

pause
exit /b
