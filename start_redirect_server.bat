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
set "PROFILE=redirector"
set "TXROOT=%BASE%txData"
set "TXDATA=%TXROOT%\%PROFILE%"
set "PROFILE_CFG=%TXDATA%\cfg"
set "PROFILE_CONFIG_JSON=%TXDATA%\config.json"
set "SOURCE_CFG=%LEGACY_DATA%\server-redirect.cfg"
set "LICENSE_FILE=%BASE%licence_key_for_redirect_server.txt"

set "TXADMIN_PORT=40130"

if not defined ARTIFACTS (
  echo [ERROR] Could not find any artifacts_* folder in "%BASE%"
  pause
  exit /b 1
)

set "COMPONENTS_JSON=%ARTIFACTS%\components.json"
if exist "%COMPONENTS_JSON%" (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='%COMPONENTS_JSON%'; $j=Get-Content -Raw -LiteralPath $p | ConvertFrom-Json; $out=@(); $has=$false; foreach($c in $j){ if($c -eq 'svadhesive'){ $has=$true }; $out += $c }; if(-not $has){ $out += 'svadhesive' }; $out | ConvertTo-Json | Set-Content -LiteralPath $p -Encoding UTF8"
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

if not exist "%SOURCE_CFG%" (
  echo [ERROR] Could not find "%SOURCE_CFG%"
  pause
  exit /b 1
)

if not exist "%LICENSE_FILE%" (
  echo [ERROR] Could not find "%LICENSE_FILE%"
  pause
  exit /b 1
)

set "SV_LICENSE_KEY="
for /f "usebackq delims=" %%L in ("%LICENSE_FILE%") do (
  if not defined SV_LICENSE_KEY set "SV_LICENSE_KEY=%%L"
)
if not defined SV_LICENSE_KEY (
  echo [ERROR] "%LICENSE_FILE%" is empty.
  pause
  exit /b 1
)

if not exist "%TXDATA%" mkdir "%TXDATA%" >nul 2>&1
if not exist "%PROFILE_CFG%" mkdir "%PROFILE_CFG%" >nul 2>&1

if not exist "%PROFILE_CONFIG_JSON%" (
  > "%PROFILE_CONFIG_JSON%" echo {"version":2}
)

echo Starting redirector server...
echo Artifacts:    %ARTIFACTS%
echo txData:       %TXDATA%
echo Config used:  %SOURCE_CFG%
echo txAdmin port: %TXADMIN_PORT%
echo.

pushd "%LEGACY_DATA%"
set "TXHOST_DATA_PATH=%TXDATA%"
set "TXHOST_IGNORE_DEPRECATED_CONFIGS=true"

"%ARTIFACTS%\FXServer.exe" ^
  +set txAdminPort %TXADMIN_PORT% ^
  +set sv_licenseKey "%SV_LICENSE_KEY%" ^
  +set resourcesPath "%LEGACY_DATA:\=/%/resources" ^
  +set citizen_dir "%ARTIFACTS%\citizen" ^
  +set svfx_dir "%ARTIFACTS%" ^
  +exec server-redirect.cfg

popd

echo.
echo Redirector FXServer/txAdmin stopped.
pause
endlocal
