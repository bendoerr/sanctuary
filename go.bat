@ECHO OFF

REM -- Default to keeping the console window open.
SET REMAIN_SWITCH=/K

REM -- If we get a command line paramater, then start minimized and close console after running dev-setup.bat.
IF NOT "%1" == "" SET REMAIN_SWITCH=/C && SET WINDOW_START=/MIN

REM -- Pull go.bat out of parameter list so we can preserve up to 10 parameters.
SHIFT

REM -- Put it all together.
start "Development Shell" /HIGH %WINDOW_START% cmd %REMAIN_SWITCH% dev-setup.bat %0 %1 %2 %3 %4 %5 %6 %7 %8 %9