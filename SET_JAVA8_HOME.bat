@echo off
setlocal
for /d %%D in ("C:\Program Files\Java\jdk1.8*" "C:\Program Files\Eclipse Adoptium\jdk8*" "C:\Program Files (x86)\Java\jdk1.8*") do (
  if exist "%%~D\bin\javac.exe" (
    set "JAVA_HOME=%%~D"
    goto FOUND
  )
)
echo JDK 8 was not found in common folders.
echo Install JDK 8, then set JAVA_HOME manually.
pause
exit /b 1
:FOUND
endlocal & set "JAVA_HOME=%JAVA_HOME%"
echo JAVA_HOME=%JAVA_HOME%
pause
