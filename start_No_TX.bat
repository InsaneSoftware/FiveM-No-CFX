@echo off
setlocal enabledelayedexpansion

set "BASE=%~dp0"
set "ARTIFACTS=%BASE%artifacts"
set "DATA=%BASE%server-data"

if not exist "%ARTIFACTS%\FXServer.exe" (
  echo [ERROR] Could not find "%ARTIFACTS%\FXServer.exe"
  pause
  exit /b 1
)

if not exist "%DATA%\server.cfg" (
  echo [ERROR] Could not find "%DATA%\server.cfg"
  pause
  exit /b 1
)

if not exist "%ARTIFACTS%\citizen" (
  echo [ERROR] Could not find "%ARTIFACTS%\citizen"
  pause
  exit /b 1
)

if not exist "%DATA%\resources" (
  echo [ERROR] Could not find "%DATA%\resources"
  pause
  exit /b 1
)

echo Starting FiveM FXServer (portable, no txAdmin)...
echo Artifacts: %ARTIFACTS%
echo Data:      %DATA%
echo.

pushd "%DATA%"

"%ARTIFACTS%\FXServer.exe" ^
  +set citizen_dir "%ARTIFACTS%\citizen" ^
  +set svfx_dir "%ARTIFACTS%" ^
  +set resourcesPath "%DATA%\resources" ^
  +exec server.cfg

popd

echo.
echo FXServer stopped.
pause
endlocal
