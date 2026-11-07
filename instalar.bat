@echo off
echo ======================================
echo  INSTALACAO - TESTE MENUDINO
echo ======================================
echo.

python --version >nul 2>&1
if errorlevel 1 (
    echo [ERRO] Python nao encontrado.
    echo Instale em https://www.python.org/downloads/ marcando "Add Python to PATH".
    pause
    exit /b 1
)

node --version >nul 2>&1
if errorlevel 1 (
    echo [ERRO] Node.js nao encontrado. A Browser Library precisa dele.
    echo Instale a versao LTS em https://nodejs.org/
    pause
    exit /b 1
)

echo [1/2] Instalando dependencias Python...
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
if errorlevel 1 (
    echo [ERRO] Falha ao instalar as dependencias.
    pause
    exit /b 1
)

echo.
echo [2/2] Baixando o navegador Chromium do Playwright...
python -m Browser.entry init chromium
if errorlevel 1 (
    echo [ERRO] Falha ao inicializar o navegador. Tente: python -m Browser.entry init chromium
    pause
    exit /b 1
)

echo.
echo ======================================
echo  INSTALACAO CONCLUIDA
echo ======================================
echo Para rodar os testes: executar_teste.bat
echo.
pause
