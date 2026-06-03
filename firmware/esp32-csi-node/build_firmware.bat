@echo off
setlocal enabledelayedexpansion

set "LOG_FILE=idf_test.txt"
set "SCRIPT_DIR=%~dp0"
set "PROJECT_DIR=%SCRIPT_DIR%"
set "ESP_IDF_ROOT=C:\Users\Jaret\Documents\Projects\esp-idf-v6.0.1"
set "IDF_PY=%ESP_IDF_ROOT%\tools\idf.py"

echo [INFO] Starting ESP-IDF firmware build > "%LOG_FILE%"
echo [INFO] Script directory: %SCRIPT_DIR% >> "%LOG_FILE%"
echo [INFO] Project directory: %PROJECT_DIR% >> "%LOG_FILE%"
echo [INFO] ESP-IDF root: %ESP_IDF_ROOT% >> "%LOG_FILE%"

where python >nul 2>&1
if errorlevel 1 (
	echo [ERROR] Python was not found in PATH.
	echo [ERROR] Python was not found in PATH. >> "%LOG_FILE%"
	echo [HINT] Install Python 3 and ensure the python command is available.
	echo [HINT] Install Python 3 and ensure the python command is available. >> "%LOG_FILE%"
	exit /b 10
)

if not exist "%IDF_PY%" (
	echo [ERROR] Could not find idf.py at: %IDF_PY%
	echo [ERROR] Could not find idf.py at: %IDF_PY% >> "%LOG_FILE%"
	echo [HINT] Verify ESP-IDF is installed and update ESP_IDF_ROOT in this script.
	echo [HINT] Verify ESP-IDF is installed and update ESP_IDF_ROOT in this script. >> "%LOG_FILE%"
	exit /b 11
)

cd /d "%PROJECT_DIR%"
if errorlevel 1 (
	echo [ERROR] Failed to change directory to: %PROJECT_DIR%
	echo [ERROR] Failed to change directory to: %PROJECT_DIR% >> "%LOG_FILE%"
	echo [HINT] Confirm the firmware folder exists and you have access permissions.
	echo [HINT] Confirm the firmware folder exists and you have access permissions. >> "%LOG_FILE%"
	exit /b 12
)

echo [INFO] Running: python "%IDF_PY%" build
echo [INFO] Running: python "%IDF_PY%" build >> "%LOG_FILE%"
python "%IDF_PY%" build >> "%LOG_FILE%" 2>&1
set "BUILD_RC=%ERRORLEVEL%"

if not "%BUILD_RC%"=="0" (
	echo [ERROR] Build failed with exit code %BUILD_RC%.
	echo [ERROR] Build failed with exit code %BUILD_RC%. >> "%LOG_FILE%"
	echo [HINT] Open %LOG_FILE% for full output and fix the first reported error.
	echo [HINT] Open %LOG_FILE% for full output and fix the first reported error. >> "%LOG_FILE%"
	exit /b %BUILD_RC%
)

echo [OK] Build completed successfully.
echo [OK] Build completed successfully. >> "%LOG_FILE%"
exit /b 0
