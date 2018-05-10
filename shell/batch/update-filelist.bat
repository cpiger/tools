@echo off
rem Create fileslist
echo Creating Filelist...

set SED_CMD="%TOOLS%\bin\sed.exe"
if not exist %SED_CMD% (
    set SED_CMD=sed
)

set GAWK_CMD="%TOOLS%\bin\gawk.exe"
if not exist %GAWK_CMD% (
    set GAWK_CMD=gawk
)

set GREP_CMD="%TOOLS%\bin\grep.exe"
if not exist %GREP_CMD% (
    set GREP_CMD=grep
)

set FILE_CMD="%TOOLS%\bin\file.exe"
if not exist %GREP_CMD% (
    set FILE_CMD=file
)

rem create cwd pattern for sed
set CWD_PATTERN=%cd%
for /f "delims=" %%a in ('echo %cd%^|%SED_CMD% "s,\\,\\\\,g"') do (
    set CWD_PATTERN=%%a
)

rem process
echo   ^|- generate %TMP%
REM  absolute path
REM  dir /s /b %FILE_SUFFIXS%|%SED_CMD% "s,\(%CWD_PATTERN%\)\(.*\),.\2,gI" > "%TMP%"
REM  relative path
dir /s /b %FILE_SUFFIXS% > "%TMP%"
dir /s /b |%GREP_CMD% -v "\.\w*$" |%SED_CMD% "s,\(%CWD_PATTERN%\)\(.*\),.\2,gI" > "%TMP2%"
%FILE_CMD% -f "%TMP2%" |%GREP_CMD% "ASCII.*text"|%SED_CMD%  "s/;.*$//g" >> "%TMP%"
del "%TMP2%" > nul

echo   ^|- apply filter
rem NOTE: dir /s /b *.cpp will list xxx.cpp~, too. So use gawk here to filter out thoes things.
%GAWK_CMD% -v filter_pattern=%FILE_FILTER_PATTERN% -v folder_filter=%FOLDER_FILTER_PATTERN% -f "%TOOLS%\gawk\file-filter-%GAWK_SUFFIX%.awk" "%TMP%">"%TMP2%"
del "%TMP%" > nul
if exist "%TMP2%" (
    echo   ^|- move %TMP2% to %TARGET%
    move /Y "%TMP2%" "%TARGET%" > nul
)

rem process id-utils files
if exist "%TARGET%" (
    echo   ^|- generate %ID_TARGET%
    %GAWK_CMD% -f "%TOOLS%/gawk/null-terminal-files.awk" "%TARGET%">"%ID_TARGET%"
    rem create filenametags
    echo   ^|- generate %FTAG_TARGET%
    %GAWK_CMD% -f "%TOOLS%/gawk/prg_FilenameTagWin.awk" "%TARGET%">"%FTAG_TARGET%"
)

echo   ^|- done!
