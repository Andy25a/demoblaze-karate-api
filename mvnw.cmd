@REM ----------------------------------------------------------------------------
@REM Maven Wrapper startup batch script, version 3.3.2
@REM ----------------------------------------------------------------------------
@ECHO OFF
SETLOCAL

set MAVEN_PROJECTBASEDIR=%~dp0
IF "%MAVEN_PROJECTBASEDIR%"=="" SET MAVEN_PROJECTBASEDIR=.
set MAVEN_PROJECTBASEDIR=%MAVEN_PROJECTBASEDIR:~0,-1%

set WRAPPER_JAR="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar"
set WRAPPER_PROPERTIES="%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties"

for /f "usebackq tokens=1,* delims==" %%A in (`type %WRAPPER_PROPERTIES% ^| findstr /r /c:"^wrapperUrl="`) do set WRAPPER_URL=%%B

IF EXIST %WRAPPER_JAR% GOTO RUN

ECHO Downloading Maven Wrapper...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$p = '%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar';" ^
  "$u = (Select-String -Path '%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties' -Pattern '^wrapperUrl=').Line.Split('=')[1];" ^
  "New-Item -ItemType Directory -Force -Path (Split-Path $p) | Out-Null;" ^
  "Invoke-WebRequest -UseBasicParsing -Uri $u -OutFile $p"
IF NOT EXIST %WRAPPER_JAR% (
  ECHO Failed to download Maven Wrapper.
  EXIT /B 1
)

:RUN
set JAVA_EXE=java
IF NOT "%JAVA_HOME%"=="" set JAVA_EXE="%JAVA_HOME%\bin\java.exe"

%JAVA_EXE% -classpath %WRAPPER_JAR% "-Dmaven.multiModuleProjectDirectory=%MAVEN_PROJECTBASEDIR%" org.apache.maven.wrapper.MavenWrapperMain %*
EXIT /B %ERRORLEVEL%

