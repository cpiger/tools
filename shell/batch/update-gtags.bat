@echo off
rem create gtags
echo Creating GTAGS...

if exist "%TOOLS%\bin\gtags.exe" (
    set GTAGS_CMD="%TOOLS%\bin\gtags.exe"
)

rem choose ctags path first
if exist "%DEST%\files" (
    set FILES="%DEST%\files"
    set GTAGS="%DEST%\GTAGS"
    set GPATH="%DEST%\GPATH"
    set GRTAGS="%DEST%\GRTAGS"
)

rem process tags by langugage
echo   ^|- generate %TMP%
%GTAGS_CMD% -f %FILES% "%DEST%"

rem replace old file
if exist "%TMP%" (
    echo   ^|- move %TMP% to %TARGET%
    move /Y "%GTAGS%" "GTAGS" > nul
    move /Y "%GPATH%" "GPATH" > nul
    move /Y "%GRTAGS%" "GRTAGS" > nul
    REM  echo   ^|- replace %TMP% to %TARGET%
    REM  replace  "%TMP%" "%TARGET%" > nul
)
echo   ^|- done!
