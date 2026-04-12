@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo 유지보수 계약 관리 시스템을 시작합니다...
echo.
echo 브라우저가 자동으로 열립니다.
echo 이 창을 닫으면 서버가 종료됩니다.
echo.
start http://localhost:8080
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0server.ps1"
