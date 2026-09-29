@echo off
setlocal EnableExtensions
cd /d "%~dp0"

echo ========================================
echo Fast Place - Minecraft 1.8.9 Forge
echo ========================================

echo.
if not defined JAVA_HOME (
  for /f "delims=" %%J in ('where java 2^>nul') do set "JAVA_EXE=%%J"
) else (
  set "JAVA_EXE=%JAVA_HOME%\bin\java.exe"
)

if not defined JAVA_EXE (
  echo Java not found.
  echo Install JDK 8 first, then run this file again.
  pause
  exit /b 1
)

"%JAVA_EXE%" -version 2>&1 | findstr /C:"version \"1.8" >nul
if errorlevel 1 (
  echo.
  echo ERROR: This build requires Java 8.
  echo Your current Java is:
  "%JAVA_EXE%" -version
  echo.
  echo Set JAVA_HOME to your JDK 8 folder and run again.
  pause
  exit /b 1
)

set "GRADLE_VERSION=2.14.1"
set "GRADLE_DIR=.gradle-dist\gradle-%GRADLE_VERSION%"
set "GRADLE_ZIP=.gradle-dist\gradle-%GRADLE_VERSION%-bin.zip"
if exist "%GRADLE_DIR%\bin\gradle.bat" goto BUILD

if not exist ".gradle-dist" mkdir ".gradle-dist"
echo Downloading Gradle %GRADLE_VERSION%...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-2.14.1-bin.zip' -OutFile 'gradle-2.14.1-bin.zip'"
if errorlevel 1 (
  echo.
  echo Gradle download failed. Check your internet connection and try again.
  pause
  exit /b 1
)
move /y "gradle-2.14.1-bin.zip" "%GRADLE_ZIP%" >nul
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%GRADLE_ZIP%' -DestinationPath '.gradle-dist' -Force"
if errorlevel 1 (
  echo Failed to extract Gradle.
  pause
  exit /b 1
)

:BUILD
call "%GRADLE_DIR%\bin\gradle.bat" --no-daemon build
if errorlevel 1 (
  echo.
  echo BUILD FAILED.
  pause
  exit /b 1
)

echo.
echo BUILD SUCCESSFUL!
echo JAR: build\libs\FastPlace-1.0.jar
pause
