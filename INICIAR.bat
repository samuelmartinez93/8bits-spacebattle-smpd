@echo off
title 8 BITS BATTLE - Servidor
cd /d "%~dp0"
if not exist node_modules (
  echo Instalando dependencias...
  call npm install --no-audit --no-fund
)
echo Iniciando el servidor...
start "" /b node server.js

echo Esperando a que el servidor este disponible...
powershell.exe -NoProfile -Command "$limit = (Get-Date).AddSeconds(10); while ((Get-Date) -lt $limit) { if (Test-NetConnection -ComputerName localhost -Port 3000 -InformationLevel Quiet) { exit 0 }; Start-Sleep -Milliseconds 250 }; exit 1"
if errorlevel 1 (
  echo No se pudo iniciar el servidor en el puerto 3000.
  pause
  exit /b 1
)

start "" http://localhost:3000
echo Servidor activo en http://localhost:3000
pause
