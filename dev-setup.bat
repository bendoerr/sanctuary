@ECHO OFF 

SET _JAVA_VERSION=1.6.0_13
SET _GROOVY_VERSION=1.7.10
SET _ANT_VERSION=1.8.2
SET _CONSOLE_VERSION=2
SET _CYGWIN_VERSION=1.7
SET _GANT_VERSION=1.9.3
SET _GRADLE_VERSION=1.0-milestone-2
SET _GRAILS_VERSION=1.3.7
SET _IDEA_VERSION=10.0.3
SET _JMETER_VERSION=2.4
SET _LIFT_VERSION=2.3
SET _MAVEN_VERSION=2.2.1
SET _MONGODB_VERSION=1.8.1
SET _NPP_VERSION=5.9
SET _PUTTY_VERSION=0.60
SET _SCALA_VERSION=2.8.1.final
 
REM -- Capture full path to the current script.
REM -- The macros used below are somewhat obscure. They are available
REM -- as part of the "for" command, but work even if there is not for
REM -- command in play, as the 0th element is the running batch script.
SET SCRIPT_FILENAME=%~nx0
SET SCRIPT_FILEPATH=%~dp0
SET SCRIPT_FULLPATH=%~f0

REM -- Output some info to the user.
ECHO.
ECHO      ___               _                                  _   
ECHO     /   \_____   _____^| ^| ___  _ __  _ __ ___   ___ _ __ ^| ^|_ 
ECHO    / /\ / _ \ \ / / _ \ ^|/ _ \^| '_ \^| '_ ` _ \ / _ \ '_ \^| __^|
ECHO   / /_//  __/\ V /  __/ ^| (_) ^| ^|_) ^| ^| ^| ^| ^| ^|  __/ ^| ^| ^| ^|_ 
ECHO  /___,' \___^| \_/ \___^|_^|\___/^| .__/^|_^| ^|_^| ^|_^|\___^|_^| ^|_^|\__^|
ECHO                               ^|_^|                             
ECHO   __                  _                          
ECHO  / _\ __ _ _ __   ___^| ^|_ _   _  __ _ _ __ _   _ 
ECHO  \ \ / _` ^| '_ \ / __^| __^| ^| ^| ^|/ _` ^| '__^| ^| ^| ^|
ECHO  _\ \ (_^| ^| ^| ^| ^| (__^| ^|_^| ^|_^| ^| (_^| ^| ^|  ^| ^|_^| ^|
ECHO  \__/\__,_^|_^| ^|_^|\___^|\__^|\__,_^|\__,_^|_^|   \__, ^|
ECHO                                            ^|___/ 
ECHO.
ECHO  ^>^> Sanctuary Home   : %SCRIPT_FILEPATH%
ECHO  ^>^> Sanctuary Script : %SCRIPT_FILENAME%
ECHO.

REM -- Path is tricky for development. Clear it out and only add
REM -- what we need. Start with basic windows directories.
PATH %SystemRoot%\system32;%SystemRoot%;

REM -- Customize prompt for development.
PROMPT $_%computername%$s$b$s%username%$s$b$s$d$s$b$s$t$_$p$_$_$+$g$s

REM -- Development environment directories.
SET DEV_HOME=%SCRIPT_FILEPATH%
SET USR_HOME=%DEV_HOME%home\%USERNAME%
SET DEV_PROJS=%DEV_HOME%projects
SET DEV_REPOS=%DEV_HOME%repos
SET DEV_SRVRS=%DEV_HOME%servers
SET DEV_STTGS=%DEV_HOME%settings
SET DEV_TOOLS=%DEV_HOME%tools
SET DEV_UTILS=%DEV_HOME%utils

REM -- Windows user environment overrides.
SET USERPROFILE=%USR_HOME%
SET user.home=%USR_HOME%
SET HOMEDRIVE=%~d0
SET HOME=%USERPROFILE%
REM -- (Doesn't work) SETX HOME %HOME%
SET HOMEPATH=%HOME%
REM -- Put appdata, localappdata under the WinDEP user/home directory.
SET APPDATA=%USERPROFILE%\AppData\Roaming
SET LOCALAPPDATA=%USERPROFILE%\AppData\Local
REM -- Create temp directory if it doesn't exist.
SET TEMP=%LOCALAPPDATA%\temp
SET TMP=%TEMP%
IF NOT EXIST %TEMP% mkdir %TEMP%
REM -- Set up shell folders
IF NOT EXIST "%USERPROFILE%\AppData\Roaming" mkdir "%USERPROFILE%\AppData\Roaming"
IF NOT EXIST "%USERPROFILE%\AppData\Local\Microsoft\Windows\Temporary Internet Files" mkdir "%USERPROFILE%\AppData\Local\Microsoft\Windows\Temporary Internet Files"
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Cookies" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Cookies"
IF NOT EXIST "%USERPROFILE%\Desktop" mkdir "%USERPROFILE%\Desktop"
IF NOT EXIST "%USERPROFILE%\Favorites" mkdir "%USERPROFILE%\Favorites"
IF NOT EXIST "%USERPROFILE%\AppData\Local\Microsoft\Windows\History" mkdir "%USERPROFILE%\AppData\Local\Microsoft\Windows\History"
IF NOT EXIST "%USERPROFILE%\AppData\Local" mkdir "%USERPROFILE%\AppData\Local"
IF NOT EXIST "%USERPROFILE%\Music" mkdir "%USERPROFILE%\Music"
IF NOT EXIST "%USERPROFILE%\Pictures" mkdir "%USERPROFILE%\Pictures"
IF NOT EXIST "%USERPROFILE%\Videos" mkdir "%USERPROFILE%\Videos"
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Network Shortcuts" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Network Shortcuts"
IF NOT EXIST "%USERPROFILE%\Documents" mkdir "%USERPROFILE%\Documents"
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Printer Shortcuts" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Printer Shortcuts"
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent"
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo"
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu"
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
IF NOT EXIST "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Templates" mkdir "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Templates"

REM -- Add utils to path.
PATH %DEV_UTILS%;%PATH%

REM --
REM -- Development environment base directories not under Subversion control.
REM --

REM -- Create tools directory if it doesn't exisit.
IF NOT EXIST %DEV_TOOLS% mkdir %DEV_TOOLS%
REM -- Create utils directory if it doesn't exsist.
IF NOT EXIST %DEV_UTILS% mkdir %DEV_UTILS%
REM -- Create home directory if it doesn't exist.
IF NOT EXIST %USERPROFILE% mkdir %USERPROFILE%
REM -- Create projects directory if it doesn't exist.
IF NOT EXIST %DEV_PROJS% mkdir %DEV_PROJS%
REM -- Create repos directory if it doesn't exist.
IF NOT EXIST %DEV_REPOS% mkdir %DEV_REPOS%
REM -- Create repos/mvn directory if it doesn't exist.
IF NOT EXIST %DEV_REPOS%\mvn mkdir %DEV_REPOS%\mvn
REM -- Create servers directory if it doesn't exist.
IF NOT EXIST %DEV_SRVRS% mkdir %DEV_SRVRS%

ECHO  Tool                    Set Version
ECHO  ======================================

REM -- Java (Needs to be set up first to support the other tools!)
SET JAVA_HOME=%DEV_TOOLS%\jdk-%_JAVA_VERSION%
IF NOT EXIST %JAVA_HOME% (SET /P _continue=Install JDK to [%JAVA_HOME%]. Java is required. Then continue.) ELSE (ECHO  Java .................. [X] %_JAVA_VERSION%)
SET JDK_HOME=%JAVA_HOME%
SET JAVA_OPTS=-server -Xms256m -Xmx1g -Xmn128m -XX:PermSize=64m -XX:MaxPermSize=128m -Duser.home=%USERPROFILE%
PATH %JAVA_HOME%\bin;%PATH%

REM -- Groovy (Used early, so set up early...)
SET GROOVY_HOME=%DEV_TOOLS%\groovy-%_GROOVY_VERSION%
IF NOT EXIST %GROOVY_HOME% (SET /P _continue=Install Groovy to [%GROOVY_HOME%]. Groovy is required. Then continue.) ELSE (ECHO  Groovy ................ [X] %_GROOVY_VERSION%)
SET PATH=%GROOVY_HOME%\bin;%PATH%

REM -- Copy the sample Maven settings file into place. (On first run.)
IF NOT EXIST %DEV_STTGS%\mvn\settings.xml COPY %DEV_STTGS%\mvn\settings.sample.xml %DEV_STTGS%\mvn\settings.xml >NUL
REM -- Keep the maven default location settings.xml in sync.
IF NOT EXIST "%USERPROFILE%\.m2" MKDIR "%USERPROFILE%\.m2"
REM -- Back up the settings.xml file just once.
IF EXIST "%USERPROFILE%\.m2\settings.xml" IF NOT EXIST "%USERPROFILE%\.m2\settings.original.xml" COPY "%USERPROFILE%\.m2\settings.xml" "%USERPROFILE%\.m2\settings.original.xml" >NUL

REM -- Parse settings.xml to have correct repository locations.
FINDSTR /i "%DEV_REPOS%" %DEV_STTGS%\mvn\settings.xml >NUL
IF ERRORLEVEL 1 CALL groovy %DEV_STTGS%\mvn\SettingsParser.groovy >NUL
REM -- Copy settings.xml to maven default location.
COPY /Y %DEV_STTGS%\mvn\settings.xml "%USERPROFILE%\.m2\settings.xml" >NUL

REM -- Copy the sample Console settings file into place. (On first run)
IF NOT EXIST %DEV_STTGS%\console\console.xml COPY %DEV_STTGS%\console\console.sample.xml %DEV_STTGS%\console\console.xml >NUL
REM -- Parse console.xml to have correct repository locations.
FINDSTR /i "%DEV_HOME%dev-setup" %DEV_STTGS%\console\console.xml >NUL
IF ERRORLEVEL 1 CALL groovy %DEV_STTGS%\console\ConsoleParser.groovy >NUL

REM -- Ant
SET ANT_HOME=%DEV_TOOLS%\ant-%_ANT_VERSION%
IF EXIST %ANT_HOME% (ECHO  Ant ................... [X] %_ANT_VERSION%) ELSE (ECHO  Ant ................... [ ] %_ANT_VERSION%)
SET ANT_OPTS=-Xms128m -Xmx512m -Duser.home=%USERPROFILE%
PATH %ANT_HOME%\bin;%PATH%

REM -- Console
SET CONSOLE_HOME=%DEV_TOOLS%\console-%_CONSOLE_VERSION%
IF EXIST %CONSOLE_HOME% (ECHO  Console ............... [X] %_CONSOLE_VERSION%) ELSE (ECHO  Console ............... [ ] %_CONSOLE_VERSION%)
DOSKEY console=start %CONSOLE_HOME%\console.exe -c %DEV_STTGS%\console\console.xml

SET CYGWIN_HOME=%DEV_TOOLS%\cygwin-%_CYGWIN_VERSION%
IF EXIST %CYGWIN_HOME% (ECHO  Cygwin ................ [X] %_CYGWIN_VERSION%) ELSE (ECHO  Cygwin ................ [ ] %_CYGWIN_VERSION%)
PATH %CYGWIN_HOME%\bin;%PATH%

REM -- Cygwin might override the windows find command. So set up a refernce so that we can use it.
SET WINFIND=C:\windows\system32\find.exe

REM -- Gant
SET GANT_HOME=%DEV_TOOLS%\gant-%_GANT_VERSION%
IF EXIST %GANT_HOME% (ECHO  Gant .................. [X] %_GANT_VERSION%) ELSE (ECHO  Gant .................. [ ] %_GANT_VERSION%)
PATH %GANT_HOME%\bin;%PATH%

REM -- Gradle
SET GRADLE_HOME=%DEV_TOOLS%\gradle-%_GRADLE_VERSION%
IF EXIST %GRADLE_HOME% (ECHO  Gradle ................ [X] %_GRADLE_VERSION%) ELSE (ECHO  Gradle ................ [ ] %_GRADLE_VERSION%)
PATH %GRADLE_HOME%\bin;%PATH%

REM -- Grails
SET GRAILS_HOME=%DEV_TOOLS%\grails-%_GRAILS_VERSION%
IF EXIST %GRAILS_HOME% (ECHO  Grails ................ [X] %_GRAILS_VERSION%) ELSE (ECHO  Grails ................ [ ] %_GRAILS_VERSION%)
PATH %GRAILS_HOME%\bin;%PATH%

REM -- Idea
SET IDEA_HOME=%DEV_TOOLS%\idea-%_IDEA_VERSION%
IF EXIST %IDEA_HOME% (ECHO  Idea .................. [X] %_IDEA_VERSION%) ELSE (ECHO  Idea .................. [ ] %_IDEA_VERSION%)
REM -- Don't add to path... We don't want their batch file!! (PATH %IDEA_HOME%\bin;%PATH%)
SET IDEA_JDK=%JDK_HOME%
SET IDEA_JVM_ARGS=-server -Xms512m -Xmx1024m -XX:MaxPermSize=300m -ea -Duser.home=%USERPROFILE%
SET IDEA_PROPERTIES=%DEV_STTGS%\idea\idea.properties
DOSKEY idea=%DEV_UTILS%\idea.bat $*

REM -- Jakarta Jmeter
SET JMETER_HOME=%DEV_TOOLS%\jmeter-%_JMETER_VERSION%
IF EXIST %JMETER_HOME% (ECHO  JMeter ................ [X] %_JMETER_VERSION%) ELSE (ECHO  JMeter ................ [ ] %_JMETER_VERSION%)
PATH %JMETER_HOME%\bin;%PATH%

REM -- Lift
SET LIFT_HOME=%DEV_TOOLS%\lift-%_LIFT_VERSION%
IF EXIST %LIFT_HOME% (ECHO  Lift .................. [X] %_LIFT_VERSION%) ELSE (ECHO  Lift .................. [ ] %_LIFT_VERSION%)

REM -- Maven
SET M2_HOME=%DEV_TOOLS%\maven-%_MAVEN_VERSION%
IF EXIST %M2_HOME% (ECHO  Maven ................. [X] %_MAVEN_VERSION%) ELSE (ECHO  Maven ................. [ ] %_MAVEN_VERSION%)
SET MAVEN_OPTS=-server -Xms256m -Xmx1024m -Xmn128m -XX:PermSize=64m -XX:MaxPermSize=128m -Duser.home=%USERPROFILE%
PATH %M2_HOME%\bin;%PATH%

REM -- MongoDB
SET MONGODB_HOME=%DEV_TOOLS%\mongodb-%_MONGODB_VERSION%
PATH %MONGODB_HOME%\bin;%PATH%

IF EXIST %MONGODB_HOME%\foo GOTO mdbHomeSet ELSE afterMdb
	
:mdbHomeSet
REM -- Copy the sample MongoDB settings file into place. (On first run)
IF NOT EXIST %DEV_STTGS%\mongodb\mongo.conf COPY %DEV_STTGS%\mongodb\mongo.sample.conf %DEV_STTGS%\mongodb\mongo.conf >NUL
SET MONGODB_DATA_LOCATION=%DEV_SRVRS%\mongodb\data\db
SET MONGODB_LOG_FILE=%DEV_SRVRS%\mongodb\data\mongo.log
IF NOT EXIST %DEV_SRVRS%\mongodb mkdir %DEV_SRVRS%\mongodb
IF NOT EXIST %DEV_SRVRS%\mongodb\data mkdir %DEV_SRVRS%\mongodb\data
IF NOT EXIST %DEV_SRVRS%\mongodb\data\db mkdir %DEV_SRVRS%\mongodb\data\db
CALL groovy %DEV_STTGS%\mongodb\MongoConfigParser.groovy >NUL

REM -- Install the service if it is not installed
REM -- Check by quering and looking for FAILED
FOR /f "usebackq tokens=*" %%A in (`sc query MongoDB ^| %WINFIND% /C "FAILED"`) DO SET _MDB_NOT_INSTALLED=%%A
IF 1==%_MDB_NOT_INSTALLED% START /HIGH CMD /C %MONGODB_HOME%\bin\mongod.exe --config %DEV_STTGS%\mongodb\mongo.conf --reinstall

REM -- Start the service if it is not started
FOR /f "usebackq tokens=*" %%A in (`sc query MongoDB ^| %WINFIND% /C "STOPPED"`) DO SET _MDB_STOPPED=%%A
IF 1==%_MDB_STOPPED% @NET START MongoDB >NUL

REM -- Print out the appropriate message
FOR /f "usebackq tokens=*" %%A in (`sc query MongoDB ^| %WINFIND% /C "RUNNING"`) DO SET _MDB_RUNNING=%%A
IF 1==%_MDB_RUNNING% (ECHO  MongoDb ......[RUNNING] [X] %_MONGODB_VERSION%) ELSE GOTO mdbNotRunning

GOTO afterMdb

:mdbNotRunning
FOR /f "usebackq tokens=*" %%A in (`sc query MongoDB ^| %WINFIND% /C "STOPPED"`) DO SET _MDB_STOPPED=%%A
IF 1==%_MDB_STOPPED% (ECHO  MongoDb ......[STOPPED] [X] %_MONGODB_VERSION%) ELSE (ECHO  MongoDb ......[TROUBLE] [X] %_MONGODB_VERSION%)

GOTO afterMdb

:afterMdb

REM -- Notepad++ (Note, defaults to ANSI due to more plugins compatible with ANSI)
SET NPP_HOME=%DEV_TOOLS%\npp-%_NPP_VERSION%
IF EXIST %NPP_HOME% (ECHO  Notepad++ ............. [X] %_NPP_VERSION%) ELSE (ECHO  Notepad++ ............. [ ] %_NPP_VERSION%)
PATH %NPP_HOME%\ansi;%PATH%
DOSKEY npp=%NPP_HOME%\ansi\notepad++.exe $*

REM -- Putty
SET PUTTY_HOME=%DEV_TOOLS%\putty-%_PUTTY_VERSION%
IF EXIST %PUTTY_HOME% (ECHO  Putty ................. [X] %_PUTTY_VERSION%) ELSE (ECHO  Putty ................. [ ] %_PUTTY_VERSION%)
PATH %PUTTY_HOME%;%PATH%
IF NOT EXIST %USERPROFILE%\.putty mkdir %USERPROFILE%\.putty
SET PUTTY_KEYS=%USERPROFILE%\.putty

REM -- Scala
SET SCALA_HOME=%DEV_TOOLS%\scala-%_SCALA_VERSION%
IF EXIST %SCALA_HOME% (ECHO  Scala ................. [X] %_SCALA_VERSION%) ELSE (ECHO  Scala ................. [ ] %_SCALA_VERSION%)
PATH %SCALA_HOME%\bin;%PATH%

REM -- Sysinternals
REM SET SYSINT_HOME=%DEV_TOOLS%\sysinternals
REM PATH %SYSINT_HOME%;%PATH%

REM -- jvmstat
REM SET JVMSTAT_HOME=%DEV_TOOLS%\jvmstat
REM PATH %JVMSTAT_HOME%\bat;%PATH%

REM -- Apply project specific settings
REM SET JAVA_OPTS=%JAVA_OPTS% -Dgov.epa.eis.showPageInfo=true
REM SET MAVEN_OPTS=%MAVEN_OPTS% -Dgov.epa.eis.showPageInfo=true

REM -- Set TERM for use with Git (which uses MingWin)
SET TERM=cygwin

REM -- Default color for ls
DOSKEY ls=ls --color $*

REM -- Cygwin complains
CYGWIN=nodosfilewarning

REM -- Load any custom development settings.
IF EXIST %DEV_STTGS%\dev-setup-custom.bat CALL %DEV_STTGS%\dev-setup-custom.bat
IF EXIST %USERPROFILE%\dev-setup-custom.bat CALL %USERPROFILE%\dev-setup-custom.bat

REM -- Provide method to launch GUI program after this script. If we get a %1 paramater,
REM -- then assume it is the GUI command, and pass in up to 9 additional paramters.
IF "%1" == "" GOTO :EOF
SET GUI_PROGRAM="%1"
SHIFT
SHIFT
CMD /C "%GUI_PROGRAM%" %0 %1 %2 %3 %4 %4 %6 %7 %8 %9
EXIT