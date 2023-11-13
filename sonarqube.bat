netstat -o -n -a | findstr 9000
if %ERRORLEVEL% equ 0 goto FOUND
start C:\sonarqube-8.9.0.43852\bin\windows-x86-64\StartSonar.bat

:LOOP
netstat -o -n -a | findstr 9000
if %ERRORLEVEL% equ 0 (
ping 127.0.0.1 -n 61 > nul
goto FOUND
)
echo Sonarqube server was Not open. It will be started 
ping 127.0.0.1 -n 11 > nul
goto LOOP

:FOUND
cd C:\Users\Public\new-web\eclipse\workspace_2\aceApp
start "SonarWindow" sonar-scanner -Dsonar.login=82c51d58f2aa88f635e0c525df54ff41f946cd44
for /l %%a in (1,1,7) do timeout 60 > nul
taskkill /fi "windowtitle eq SonarWindow"