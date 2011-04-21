@echo off

REM Work around the fact that IntelliJ Idea writes some
REM startup settings to the Idea installation directory.

REM -- Make sure we have the proper environment.
if not defined IDEA_JDK goto USAGE
if not defined IDEA_HOME goto USAGE
goto OK

:USAGE

echo.
echo NOTE: idea.bat requires that the environement variables
echo IDEA_JDK and IDEA_HOME be defined prior to executing.
echo.
if not defined IDEA_JDK echo IDEA_JDK is not set!
if not defined IDEA_HOME echo IDEA_HOME is not set!
echo.
echo Exiting.
echo.
pause
goto :EOF

:OK

REM == NOTE ==
REM The following batch script was adapted from the Jetbrains provided
REM   idea.bat file in %IDEA_HOME%/bin. It may need to be udpdated from time
REM   to time as Idea is updated. -jjv

SET JAVA_EXE=%IDEA_JDK%\jre\bin\javaw.exe
SET IDEA_MAIN_CLASS_NAME=com.intellij.idea.Main
IF NOT "%IDEA_PROPERTIES%" == "" set IDEA_PROPERTIES_PROPERTY=-Didea.properties.file=%IDEA_PROPERTIES%
SET REQUIRED_IDEA_JVM_ARGS=-Xbootclasspath/a:%IDEA_HOME%/lib/boot.jar %IDEA_PROPERTIES_PROPERTY% %REQUIRED_IDEA_JVM_ARGS%
SET JVM_ARGS=%IDEA_JVM_ARGS% %REQUIRED_IDEA_JVM_ARGS%

SET CLASS_PATH=%IDEA_HOME%\lib\bootstrap.jar
SET CLASS_PATH=%CLASS_PATH%;%IDEA_HOME%\lib\util.jar
SET CLASS_PATH=%CLASS_PATH%;%IDEA_HOME%\lib\jdom.jar
SET CLASS_PATH=%CLASS_PATH%;%IDEA_HOME%\lib\log4j.jar
SET CLASS_PATH=%CLASS_PATH%;%IDEA_HOME%\lib\extensions.jar
SET CLASS_PATH=%CLASS_PATH%;%IDEA_HOME%\lib\trove4j.jar
SET CLASS_PATH=%CLASS_PATH%;%IDEA_JDK%\lib\tools.jar

IF NOT "%IDEA_CLASS_PATH%" == "" SET CLASS_PATH=%CLASS_PATH%;%IDEA_CLASS_PATH%

START /D "%IDEA_HOME%\bin" "Idea" "%JAVA_EXE%" %JVM_ARGS% -cp "%CLASS_PATH%" %IDEA_MAIN_CLASS_NAME% %*