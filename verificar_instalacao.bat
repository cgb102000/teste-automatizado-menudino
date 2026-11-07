@echo off
echo ======================================
echo   VERIFICANDO INSTALACAO
echo ======================================
echo.
set PROBLEMA=0

python --version 2>nul || (echo [ERRO] Python nao encontrado & set PROBLEMA=1)
node --version 2>nul || (echo [ERRO] Node.js nao encontrado & set PROBLEMA=1)
python -c "import robot; print('Robot Framework', robot.__version__)" 2>nul || (echo [ERRO] Robot Framework nao instalado & set PROBLEMA=1)
python -c "import Browser; print('Browser Library instalada')" 2>nul || (echo [ERRO] Browser Library nao instalada & set PROBLEMA=1)

echo.
if %PROBLEMA%==0 (
    echo [OK] Tudo instalado. Rode executar_teste.bat
) else (
    echo Execute instalar.bat para corrigir.
)
echo.
pause
