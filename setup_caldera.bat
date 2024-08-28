
echo This will first install chocolatey, Docker-Desktop and add Caldera

echo Ensure that your cmd.exe runs as Administrator


powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
cd C:\ProgramData\chocolatey
choco feature enable -n=allowGlobalConfirmation
pause
echo Now chocolatey should be ready and we can go ahead
pause

rem enable clicking on choco:// links in the browser
rem https://community.chocolatey.org/packages/choco-protocol-support
rem choco install choco-protocol-support


choco install docker-desktop --force
choco pin add -n=docker-desktop
echo Docker is not running. Please start Docker Desktop manually
pause


set TEMP_DIR=%TEMP%\caldera_docker
mkdir %TEMP_DIR%


echo Copying Dockerfile and local.yml to the temporary directory...
copy /y "%~dp0Dockerfile" "%TEMP_DIR%\Dockerfile"
copy /y "%~dp0local.yml" "%TEMP_DIR%\local.yml"


cd /d %TEMP_DIR%

echo Building the Docker image for Caldera...
docker build -t caldera-cnc .


echo Cleaning up temporary files...
rd /s /q %TEMP_DIR%


echo Running the Caldera Docker container...
docker run -d -p 8888:8888 --name caldera-cnc caldera-cnc

echo Caldera is running on port 8888.
pause

:END