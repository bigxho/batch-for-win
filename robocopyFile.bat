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
set /P fType="choice Option /S ->DirAll or leave blank for all files:" 
rem 
title "CopyF - %DEST0NE% -> %DESTW0%"
rem if %PROCESSOR_ARCHITECTURE% EQU AMD64 (%systemroot%\SysWOW64\Robocopy.exe "%DEST0NE%" "%DESTW0%" /S /ETA) else (%systemroot%\System32\Robocopy.exe "%DEST0NE%" "%DESTW0%" /S /ETA)
if %PROCESSOR_ARCHITECTURE% EQU AMD64 (%systemroot%\SysWOW64\Robocopy.exe "%DEST0NE%" "%DESTW0%" %fType% /ETA) else (%systemroot%\System32\Robocopy.exe "%DEST0NE%" "%DESTW0%" %fType% /ETA)
rem %systemroot%\SysWOW64\Robocopy.exe "%DEST0NE%" "%DESTW0%" /S /ETA
rem %systemroot%\System32\Robocopy.exe "%DEST0NE%" "%DESTW0%" /S /ETA
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
rem start Explorer %DESTW0%
echo Press Enter to Exit....
rem
