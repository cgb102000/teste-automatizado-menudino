@echo off
echo ======================================
echo   VERIFICANDO INSTALACAO DO SISTEMA
echo ======================================
echo.

echo [1/4] Verificando Python...
python --version 2>nul
if errorlevel 1 (
    echo ❌ ERRO: Python nao encontrado!
    goto :error
) else (
    echo ✅ Python encontrado!
)

echo.
echo [2/4] Verificando pip...
pip --version 2>nul
if errorlevel 1 (
    echo ❌ ERRO: pip nao encontrado!
    goto :error
) else (
    echo ✅ pip encontrado!
)

echo.
echo [3/4] Verificando Robot Framework...
python -c "import robot; print('Robot Framework versao:', robot.__version__)" 2>nul
if errorlevel 1 (
    echo ❌ Robot Framework nao instalado!
    echo Execute: pip install robotframework
    goto :error
) else (
    echo ✅ Robot Framework instalado!
)

echo.
echo [4/4] Verificando Browser Library...
python -c "import Browser; print('Browser Library instalada!')" 2>nul
if errorlevel 1 (
    echo ❌ Browser Library nao instalada!
    echo Execute: pip install robotframework-browser
    echo Depois: python -m Browser.entry init
    goto :error
) else (
    echo ✅ Browser Library instalada!
)

echo.
echo ======================================
echo ✅ TUDO INSTALADO CORRETAMENTE!
echo ======================================
echo.
echo Voce pode executar o teste com:
echo executar_teste.bat
echo.
goto :end

:error
echo.
echo ======================================
echo ❌ PROBLEMAS ENCONTRADOS!
echo ======================================
echo.
echo Execute primeiro o script de instalacao:
echo instalar.bat
echo.

:end
pause
