@ECHO OFF

set /P c=Its time to make a backup, may I[Y/N]?
if /I "%c%" EQU "N" EXIT /b


SET backupfolder=%~dp0backup

CALL :createfolder %backupfolder%

FOR /F %%i IN (%~dp0folders.txt) DO CALL :backupit %%i

pause

:backupit
IF %~1=="" EXIT /b

ECHO Backing up folder: %~1
FOR %%f IN (%~1) DO SET folder= %backupfolder%\%%~nxf
CALL :createfolder %folder%

robocopy /E /MIR /ETA %~1 %folder%
EXIT /b

:createfolder
IF NOT EXIST %~1 mkdir %~1
EXIT /b