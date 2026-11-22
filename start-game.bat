@echo off
setlocal

set "url=http://127.0.0.1:8765/"
set "port=8765"

curl.exe --fail --silent --max-time 1 "%url%" 2>nul | findstr /C:"<title>Petualangan Tumbuh" >nul
if not errorlevel 1 (
    start "" "%url%"
    exit /b 0
)

start "" /min python -m http.server %port% --bind 127.0.0.1
for /L %%i in (1,1,20) do (
    timeout /t 1 /nobreak >nul
    curl.exe --fail --silent --max-time 1 "%url%" 2>nul | findstr /C:"<title>Petualangan Tumbuh" >nul
    if not errorlevel 1 (
        start "" "%url%"
        exit /b 0
    )
)

echo Tidak dapat membuka game. Pastikan Python sudah terpasang dan port %port% tersedia.
exit /b 1
