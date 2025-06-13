@echo off
echo ======================================
echo  INSTALACAO AUTOMATICA - TESTE MENUDINO
echo ======================================
echo.

echo Verificando se Python esta instalado...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERRO: Python nao encontrado!
    echo Por favor, instale o Python primeiro:
    echo https://www.python.org/downloads/
    echo.
    echo Lembre-se de marcar "Add Python to PATH" durante a instalacao.
    pause
    exit /b 1
)

echo Python encontrado!
echo.

echo Atualizando pip...
python -m pip install --upgrade pip

echo.
echo Instalando dependencias...
pip install -r requirements.txt

if errorlevel 1 (
    echo ERRO: Falha ao instalar dependencias!
    pause
    exit /b 1
)

echo.
echo Inicializando navegadores do Playwright...
echo Tentando metodo 1...
python -m Browser.entry init

if errorlevel 1 (
    echo Metodo 1 falhou. Tentando metodo alternativo...
    python -c "from Browser.entry import main; main()" || (
        echo ERRO: Falha ao inicializar navegadores!
        echo.
        echo Tente executar manualmente um dos comandos:
        echo python -m Browser.entry init
        echo ou
        echo python -c "from Browser.entry import main; main()"
        pause
        exit /b 1
    )
)

echo.
echo ======================================
echo  INSTALACAO CONCLUIDA COM SUCESSO!
echo ======================================
echo.
echo Para executar o teste, use:
echo python -m robot teste_menu_dino.robot
echo.
echo Ou execute o script automatico:
echo executar_teste.bat
echo.
pause
