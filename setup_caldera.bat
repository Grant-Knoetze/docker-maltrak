@echo off

:: Check if Chocolatey is installed
echo Checking if Chocolatey is installed...
choco -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Chocolatey is not installed. Installing Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy AllSigned; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex"
) else (
    echo Chocolatey is already installed.
)

:: Check if Docker is installed
echo Checking if Docker is installed...
docker -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Docker is not installed. Installing Docker...
    choco install -y docker-desktop
    echo Docker installation complete.
) else (
    echo Docker is already installed.
)

:: Wait for Docker to start if it was just installed
echo Waiting for Docker to start...
timeout /t 10

:: Ensure Docker is running
echo Checking if Docker is running...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo Docker is not running. Please start Docker Desktop and run this script again.
    exit /b 1
)

:: Create a temporary directory for Dockerfile and local.yml
set TEMP_DIR=%TEMP%\caldera_docker
mkdir %TEMP_DIR%

:: Copy the Dockerfile and local.yml to the temporary directory
echo Copying Dockerfile and local.yml to the temporary directory...
copy /y "Dockerfile" "%TEMP_DIR%\Dockerfile"
copy /y "local.yml" "%TEMP_DIR%\local.yml"

:: Navigate to the temporary directory
cd /d %TEMP_DIR%

:: Build the Docker image for Caldera
echo Building the Docker image for Caldera...
docker build -t caldera-cnc .

:: Clean up temporary files
echo Cleaning up temporary files...
rd /s /q %TEMP_DIR%

:: Run the Caldera Docker container
echo Running the Caldera Docker container...
docker run -d -p 8888:8888 --name caldera-cnc caldera-cnc

echo Caldera is running on port 8888.