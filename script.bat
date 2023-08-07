@echo off

REM Get the directory of the batch script
set "script_dir=%~dp0"

REM timeout /t 60 /nobreak &::>nul

REM Get the first two arguments (arg1 and arg2)
set "arg1=%~1"
set "arg2=%~2"

REM Run the Python script
python3 "%script_dir%verify-cams-on.py" %arg1% %arg2%

REM Set the name of the program to check
set "program_name=otdau220.exe"

REM Check if the program is running using tasklist
tasklist | find /i "%program_name%" >nul

REM Check the error level to determine if the program is running
if %errorlevel% equ 0 (
    echo The program %program_name% is already running.
) else (
    echo The program %program_name% is not running. Starting it now.
    REM Start your application
	start "" "%script_dir%OTDAU 2.20.lnk"
	pause
)
