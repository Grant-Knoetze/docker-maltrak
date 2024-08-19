@echo off
:: This script checks for Chocolatey and Docker installations, installs them if not found, and runs the Caldera Docker image

:: Check if Chocolatey is installed
echo Checking for Chocolatey installation...
choco -v >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Chocolatey is already installed. Skipping installation.
) else (
    :: Install Chocolatey
    echo Installing Chocolatey...
    @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    if %ERRORLEVEL% NEQ 0 (
        echo Failed to install Chocolatey. Exiting.
        pause
        exit /b %ERRORLEVEL%
    )
)

:: Check if Docker is installed
echo Checking for Docker installation...
docker --version >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Docker is already installed. Skipping installation.
) else (
    :: Install Docker
    echo Installing Docker...
    choco install docker-desktop -y
    if %ERRORLEVEL% NEQ 0 (
        echo Failed to install Docker. Exiting.
        pause
        exit /b %ERRORLEVEL%
    )
    
    :: Ask user to restart the terminal and run the script again
    echo Docker installation completed. Please restart the terminal and run this script again.
    pause
    exit /b
)

:: Ensure Docker Desktop is running
echo Starting Docker Desktop...
start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
timeout /t 10

:: Build the docker image
echo Building Caldera image
start "" ""

:: Run Caldera Docker container
echo Running Caldera Docker container...
docker run -p 8888:8888 caldera_image_name

echo Caldera is now running on http://localhost:8888
pause

