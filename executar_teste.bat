@echo off
echo ====================================================
echo        INICIANDO TESTE AUTOMATIZADO - MENUDINO
echo ====================================================
echo.
echo OBS: Mantenha este terminal aberto ate o fim do teste.
echo      Voce vera o navegador abrir automaticamente.
echo      O teste pode demorar ate 2 minutos para ser executado completamente.
echo      Por favor, AGUARDE. O navegador ira fechar sozinho e o relatorio sera aberto.
echo.

if not exist "teste_menu_dino.robot" (
    echo [ERRO] Arquivo de teste "teste_menu_dino.robot" NAO ENCONTRADO!
    echo Certifique-se de estar no diretorio correto.
    pause
    exit /b 1
)

echo Iniciando teste automatizado...
echo.
python -m robot teste_menu_dino.robot

if errorlevel 1 (
    echo.
    echo =====================[ FALHA ]=====================
    echo [ERRO] O TESTE FALHOU! Verifique os arquivos abaixo para mais detalhes:
    echo.
    echo - log.html       (log detalhado do erro)
    echo - report.html    (relatorio resumido)
    echo.
    if exist "log.html" start log.html
    echo.
    echo Esta janela sera fechada em 3 segundos...
    ping 127.0.0.1 -n 4 > nul
) else (
    echo.
    echo ====================[ SUCESSO ]====================
    echo O TESTE FOI EXECUTADO COM SUCESSO!
    echo.
    echo Arquivos gerados:
    echo - log.html             (log detalhado)
    echo - report.html          (relatorio resumido)
    echo - output.xml           (resultados em XML)
    echo - resultado_final.png  (screenshot final)
    echo - pagina_completa.png  (screenshot completo)
    echo.
    echo Abrindo relatorio automaticamente...
    if exist "report.html" start report.html
    echo.
    echo Esta janela sera fechada em 3 segundos...
    ping 127.0.0.1 -n 4 > nul
)
