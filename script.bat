REM @echo off

REM Get the directory of the batch script
set "script_dir=%~dp0"

REM Start your application
start "" "%script_dir%OTDAU 2.17.lnk"

timeout /t 20 /nobreak &::>nul

REM Run the Python script
python "%script_dir%auto.py"

pause