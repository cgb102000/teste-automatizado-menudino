@echo off
echo ====================================================
echo        TESTE AUTOMATIZADO - MENUDINO
echo ====================================================
echo.
echo O navegador vai abrir e executar os cenarios sozinho.
echo Aguarde: leva cerca de 1 minuto.
echo.

if not exist "tests\endereco_por_cep.robot" (
    echo [ERRO] Pasta "tests" nao encontrada. Execute este script na pasta do projeto.
    pause
    exit /b 1
)

python -m robot --outputdir results --variable HEADLESS:False tests
set RESULTADO=%errorlevel%

echo.
if %RESULTADO%==0 (
    echo ====================[ SUCESSO ]====================
    echo Todos os testes passaram.
) else (
    echo =====================[ FALHA ]=====================
    echo %RESULTADO% teste^(s^) falharam. Veja os detalhes no relatorio.
)
echo.
echo Relatorio: results\report.html
echo Log:       results\log.html
if exist "results\report.html" start "" "results\report.html"
echo.
pause
exit /b %RESULTADO%
