@echo off
setlocal enabledelayedexpansion

set "BASE=%~dp0"
set "ARTIFACTS="
for /f "delims=" %%D in ('dir /b /ad /o-d "%BASE%artifacts_*" 2^>nul') do (
  set "ARTIFACTS=%BASE%%%D"
  goto :foundArtifacts
)
:foundArtifacts
set "LEGACY_DATA=%BASE%server-data"
set "PROFILE=default"
set "TXROOT=%BASE%txData"
set "TXDATA=%TXROOT%\%PROFILE%"
set "PROFILE_CFG=%TXDATA%\cfg"
set "SERVER_CFG=%PROFILE_CFG%\server.cfg"
set "PROFILE_CONFIG_JSON=%TXDATA%\config.json"

if not defined ARTIFACTS (
  echo [ERROR] Could not find any artifacts_* folder in "%BASE%"
  pause
  exit /b 1
)

if not exist "%ARTIFACTS%\FXServer.exe" (
  echo [ERROR] Could not find "%ARTIFACTS%\FXServer.exe"
  pause
  exit /b 1
)

if not exist "%ARTIFACTS%\citizen" (
  echo [ERROR] Could not find "%ARTIFACTS%\citizen"
  pause
  exit /b 1
)

if not exist "%LEGACY_DATA%\resources" (
  echo [ERROR] Could not find "%LEGACY_DATA%\resources"
  pause
  exit /b 1
)

if not exist "%PROFILE_CFG%" (
  mkdir "%PROFILE_CFG%" >nul 2>&1
)

if not exist "%TXDATA%" (
  mkdir "%TXDATA%" >nul 2>&1
)

if not exist "%SERVER_CFG%" (
  if exist "%LEGACY_DATA%\server.cfg" (
    echo [INFO] Creating txAdmin profile config from "%LEGACY_DATA%\server.cfg"
    copy /Y "%LEGACY_DATA%\server.cfg" "%SERVER_CFG%" >nul
  ) else (
    echo [ERROR] Could not find "%SERVER_CFG%" and no legacy "%LEGACY_DATA%\server.cfg" to copy from.
    pause
    exit /b 1
  )
)

if not exist "%PROFILE_CONFIG_JSON%" (
  echo [INFO] Creating "%PROFILE_CONFIG_JSON%" with schema version 2
  > "%PROFILE_CONFIG_JSON%" echo {"version":2}
) else (
  findstr /I /C:"\"version\"" "%PROFILE_CONFIG_JSON%" >nul
  if errorlevel 1 (
    echo [WARN] "%PROFILE_CONFIG_JSON%" has no version field. Rewriting to schema version 2.
    copy /Y "%PROFILE_CONFIG_JSON%" "%PROFILE_CONFIG_JSON%.bak" >nul
    > "%PROFILE_CONFIG_JSON%" echo {"version":2}
  )
)

echo Starting FiveM FXServer with txAdmin profile "%PROFILE%"...
echo Artifacts: %ARTIFACTS%
echo txData:    %TXDATA%
echo Config:    %SERVER_CFG%
echo.

pushd "%BASE%"
set "TXHOST_DATA_PATH=%TXDATA%"
set "TXHOST_IGNORE_DEPRECATED_CONFIGS=true"

"%ARTIFACTS%\FXServer.exe" ^
  +set citizen_dir "%ARTIFACTS%\citizen" ^
  +set svfx_dir "%ARTIFACTS%" ^
  +set resourcesPath "%LEGACY_DATA%\resources"

popd

echo.
echo FXServer/txAdmin stopped.
pause
endlocal
