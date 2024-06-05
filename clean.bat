@echo off
echo Limpiando carpetas temporales...

REM Preguntar al usuario si desea vaciar la papelera de reciclaje
set /p respuesta="¿Desea vaciar la papelera de reciclaje? (y/n): "

REM Limpiar %temp%
echo Limpiando %temp%...
del /s /q %temp%\*
rd /s /q %temp%
mkdir %temp%

REM Limpiar prefetch
echo Limpiando prefetch...
del /s /q C:\Windows\Prefetch\*

REM Limpiar carpeta temp del sistema
echo Limpiando carpeta temp del sistema...
del /s /q C:\Windows\Temp\*
rd /s /q C:\Windows\Temp
mkdir C:\Windows\Temp

REM Limpiar archivos temporales de Internet
echo Limpiando archivos temporales de Internet...
del /s /q "%LocalAppData%\Microsoft\Windows\INetCache\*"

REM Limpiar informes de errores de Windows
echo Limpiando informes de errores de Windows...
del /s /q C:\ProgramData\Microsoft\Windows\WER\*

REM Limpiar la carpeta de descargas
echo Limpiando la carpeta de descargas...
del /s /q "%UserProfile%\Downloads\*"

REM Limpiar historial de Windows Update
echo Limpiando historial de Windows Update...
net stop wuauserv
del /s /q C:\Windows\SoftwareDistribution\Download\*
net start wuauserv

REM Limpiar caché de iconos
echo Limpiando caché de iconos...
del /s /q %LocalAppData%\IconCache.db

REM Limpiar caché de miniaturas
echo Limpiando caché de miniaturas...
del /s /q %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db

if /i "%respuesta%"=="y" (
    echo Vaciando la papelera de reciclaje...
    pause
    PowerShell.exe -NoProfile -Command "& { Clear-Host; $Shell = New-Object -ComObject Shell.Application; $RecycleBin = $Shell.Namespace(0xA); $RecycleBin.Items() | ForEach-Object { Remove-Item $_.Path -Recurse -Force } }"
) else (
    echo Papelera de reciclaje no vaciada.
)

echo Limpieza completada.
pause
