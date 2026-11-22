@echo off



setlocal



::- Get the Java Version

set KEY="HKLM\SOFTWARE\JavaSoft\Java Development Kit"

set VALUE=CurrentVersion

reg query %KEY% /v %VALUE% 2>nul || (

    echo JDK not installed

    exit /b 1

)

set JDK_VERSION=

for /f "tokens=2,*" %%a in ('reg query %KEY% /v %VALUE% ^| findstr %VALUE%') do (

    set JDK_VERSION=%%b

)



echo JDK VERSION: %JDK_VERSION%



::- Get the JavaHome

set KEY="HKLM\SOFTWARE\JavaSoft\Java Development Kit\%JDK_VERSION%"

set VALUE=JavaHome

reg query %KEY% /v %VALUE% 2>nul || (

    echo JavaHome not installed

    exit /b 1

)



set JAVAHOME=

for /f "tokens=2,*" %%a in ('reg query %KEY% /v %VALUE% ^| findstr %VALUE%') do (

    set JAVAHOME=%%b

)



echo JavaHome: %JAVAHOME%



mkdir lib

cd lib

set "PATH=%PATH%;%JAVAHOME%\bin"

jar xvf ..\kiosk-lib-lite.jar

cd ..

java -Dloader.path=lib -Xdebug -Xrunjdwp:transport=dt_socket,address=8800,server=y,suspend=n -jar kiosk.jar



endlocal



REM #

REM # NOTE:    After change replace unix line endings with windows's

REM # Example: unix2dos kiosk.cmd

REM #
