@echo off
setlocal enabledelayedexpansion

set adbPath=C:\platform-tools\adb.exe

REM Check if any devices are connected
for /f %%i in ('%adbPath% devices ^| find /c /v ""') do set deviceCount=%%i

if !deviceCount! lss 3 (
  echo No devices found. Exiting...
  exit /b 1
)

REM Check USB tethering
for /f "tokens=2 delims= " %%a in ('%adbPath% shell dumpsys tethering ^| findstr /c:"ncm0 - TetheredState"') do set usbTethering=%%a

REM Check Wi-Fi hotspot tethering
for /f "tokens=2 delims= " %%b in ('%adbPath% shell dumpsys tethering ^| findstr /c:"ap_br_wlan2 - TetheredState"') do set wifiTethering=%%b

if "!usbTethering!"=="" (
  REM Either USB tethering or Wi-Fi hotspot tethering is not on, run the necessary commands
  echo Enabling tethering...

  %adbPath% shell input keyevent 82
  %adbPath% shell input keyevent 82
  %adbPath% shell input text 0214
  %adbPath% shell input keyevent 66
  timeout /t 5 > nul
  if "!wifiTethering!"=="" (
    REM Wi-Fi hotspot tethering is not on, run the commands to enable it
    echo Enabling Wi-Fi hotspot tethering...

    %adbPath% shell am start -S com.android.settings/.TetherSettings
    %adbPath% shell input keyevent 66
    %adbPath% shell input keyevent 66
  )
  %adbPath% shell input keyevent 26
) else if "!wifiTethering!"=="" (
  echo Enabling tethering...

  %adbPath% shell input keyevent 82
  %adbPath% shell input keyevent 82
  %adbPath% shell input text 0214
  %adbPath% shell input keyevent 66
  timeout /t 5 > nul
  if "!wifiTethering!"=="" (
    REM Wi-Fi hotspot tethering is not on, run the commands to enable it
    echo Enabling Wi-Fi hotspot tethering...

    %adbPath% shell am start -S com.android.settings/.TetherSettings
    %adbPath% shell input keyevent 66
    %adbPath% shell input keyevent 66
  )
  %adbPath% shell input keyevent 26
) else (
  echo Both USB tethering and Wi-Fi hotspot tethering are already active.
)
endlocal