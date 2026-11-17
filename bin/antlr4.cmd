@echo off
set "ANTLR_HOME=%USERPROFILE%\antlr"
if not exist "%ANTLR_HOME%\antlr-4.13.2-complete.jar" (
    set "ANTLR_HOME=%~dp0..\jar"
)
for %%a in (%*) do (
  if "%%a"=="-helpantlr" (
    call "%~dp0helpantlr.cmd"
    exit /b 0
  )
)
java -jar "%ANTLR_HOME%\antlr-4.13.2-complete.jar" %*
