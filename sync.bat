@echo off
setlocal

:: Set the source and destination directories here!
set "source=%cd%\src\workspace"
set "destination=DIRECTORY"

xcopy "%source%\*" "%destination%\nexus\" /s /e /h /y /i

endlocal