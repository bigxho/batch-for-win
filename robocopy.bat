echo off
title " Robocopy \dir1 to \dir2 "
cls
:DEST1
set /P DEST0NE=Insert \source\: 
if "%DEST0NE%"=="" goto Error_0
rem
:DEST2
set /P DESTW0=Insert \destination\: 
if "%DESTW0%"=="" goto Error_1
rem
title "CopyF %DEST0NE% -> %DESTW0%"
rem if %PROCESSOR_ARCHITECTURE% EQU "AMD64" (%systemroot%\SysWOW64\Robocopy.exe /S "%DEST0NE%" "%DESTW0%") else (%systemroot%\System32\Robocopy.exe /S "%DEST0NE%" "%DESTW0%")
%systemroot%\SysWOW64\Robocopy.exe /S "%DEST0NE%" "%DESTW0%"

rem
goto EXIt
rem
:Error_0
echo Insert \source\
rem
goto DEST1
rem
rem
:Error_1
echo Insert \destination\
rem
goto DEST2
rem
:EXIt
echo **** Finished ****
start Explorer %DESTW0%
echo Press Enter to Exit....
rem
