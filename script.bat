REM @echo off

REM Get the directory of the batch script
set "script_dir=%~dp0"

REM timeout /t 60 /nobreak &::>nul

REM Get the first two arguments (arg1 and arg2)
set "arg1=%~1"
set "arg2=%~2"

REM Run the Python script and capture its exit code
python3 "%script_dir%verify-cams-on.py" %arg1% %arg2%

REM Set the name of the program to check
set "program_name=otdau222.exe"

set "python_exit_code=%errorlevel%"

REM Check if the program is running using tasklist
tasklist | find /i "%program_name%" >nul

set "program_exit_code=%errorlevel%"
    
REM Check the Python exit code to determine whether to continue or exit
if %python_exit_code% equ 0 (
    echo The Python script was successful.

    REM Check the error level to determine if the program is running
    if %program_exit_code% equ 0 (
        echo The program %program_name% is already running.
    ) else (
        echo The program %program_name% is not running. Starting it now.
        REM Start your application
        start "" "%script_dir%OTDAU 2.22.lnk"
        pause
    )
) else (
    echo The Python script did not succeed. Exiting.
    exit /b
)