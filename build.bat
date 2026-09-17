@echo off
setlocal enabledelayedexpansion

set MEMORYLIB_DIR="memorylib"
set ADDON_NAME="instantah"

echo === Building MemoryLib ===

pushd %MEMORYLIB_DIR%
call .\build.bat
if errorlevel 1 (
    echo ERROR: memorylib build failed
    exit /b 1
)
popd

echo === Copying files ===

xcopy /e /i /y /q "lua\%ADDON_NAME%.lua" "build\%ADDON_NAME%\"
xcopy /y /q "%MEMORYLIB_DIR%\build\_lib\Release\memorylib.dll" "build\%ADDON_NAME%\libs\"

echo === Build finished ===

endlocal