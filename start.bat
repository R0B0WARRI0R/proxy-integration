@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion
color 0B
mode con: cols=100 lines=40
cls

:: ASCII Art Header
echo.
echo.
echo      ██████╗ ██████╗  ██████╗ ██╗  ██╗██╗   ██╗
echo      ██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝╚██╗ ██╔╝
echo      ██████╔╝██████╔╝██║   ██║ ╚███╔╝  ╚████╔╝ 
echo      ██╔═══╝ ██╔══██╗██║   ██║ ██╔██╗   ╚██╔╝  
echo      ██║     ██║  ██║╚██████╔╝██╔╝ ██╗   ██║   
echo      ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
echo.
echo      I N T E G R A T I O N   S Y S T E M
echo      ===================================
echo.

:: Check Docker
echo    [+] Checking Docker status...
echo    (If this hangs, please RESTART Docker Desktop)
docker info >nul
if %errorlevel% neq 0 (
    color 0C
    echo.
    echo    [ERROR] Docker is NOT running or not responding!
    echo    Please start Docker Desktop and try again.
    echo.
    pause
    exit /b
)

:: Progress Bar Function
echo.
set /p a="   [+] Initializing modules: [" <nul
for /l %%x in (1, 1, 40) do (
    set /p a="█" <nul
    :: Small delay hack
    ping localhost -n 1 -w 50 >nul 2>&1
)
echo ] OK
echo.

echo    [+] Building and starting containers...
echo    (This might take a while on first run)
echo.

:: Run Docker Compose
docker compose up --build -d

cls
echo.
echo.
echo      ██████╗ ██████╗  ██████╗ ██╗  ██╗██╗   ██╗
echo      ██╔══██╗██╔══██╗██╔═══██╗╚██╗██╔╝╚██╗ ██╔╝
echo      ██████╔╝██████╔╝██║   ██║ ╚███╔╝  ╚████╔╝ 
echo      ██╔═══╝ ██╔══██╗██║   ██║ ██╔██╗   ╚██╔╝  
echo      ██║     ██║  ██║╚██████╔╝██╔╝ ██╗   ██║   
echo      ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
echo.
echo      ========================================================
echo        STATUS:  RUNNING
echo      ========================================================
echo.
echo        [1] SCRAPER SERVICE
echo            Status:  Active (Background)
echo            Action:  Searching for proxies...
echo.
echo        [2] MUBENG PROXY
echo            Status:  Active (Port 8089)
echo            Address: http://localhost:8089
echo.
echo      ========================================================
echo.
echo      USAGE INSTRUCTIONS:
echo      1. Open your browser settings
echo      2. Search for "Proxy"
echo      3. Set HTTP/HTTPS Proxy to: 127.0.0.1
echo      4. Set Port to: 8089
echo.
echo      Logs are shown below. Press Ctrl+C to stop viewing logs.
echo      (Containers will keep running in background)
echo.
echo      ========================================================
echo.

docker compose logs -f
pause
