*** Settings ***
Library    Browser

*** Variables ***
${URL}              https://menudino.com/
${CEP}              15043-540
${NUMERO}           121
${COMPLEMENTO}      fundos
${REFERENCIA}       portão branco

*** Test Cases ***
Teste Exploratório - Validação de CEP e Endereço no MenuDino
    [Documentation]    Teste exploratório para validar o preenchimento de endereço ao inserir um CEP válido no MenuDino.
      # Configurações do navegador
    New Browser    headless=False
    Set Browser Timeout    30s
    New Page    ${URL}
    
    # Etapa 1: Inserir CEP
    Log    Aguardando campo de CEP aparecer...
    Wait For Elements State    input[placeholder="Digite seu CEP"]    visible    timeout=15s
    Fill Text    input[placeholder="Digite seu CEP"]    ${CEP}
    Click    text=Buscar
    
    # Etapa 2: Preencher endereço
    Log    Aguardando formulário de endereço aparecer...
    Wait For Elements State    text=Adicione seu endereço!    visible    timeout=15s
    
    Log    Preenchendo dados do endereço...
    Fill Text    input[placeholder="Número"]    ${NUMERO}
    Fill Text    input[placeholder="Complemento"]    ${COMPLEMENTO}
    Fill Text    input[placeholder="Ponto de referência"]    ${REFERENCIA}
    
    Click    text=Salvar Endereço
    
    # Etapa 3: Aguardar carregamento (estratégia mais robusta)
    Log    Aguardando página carregar após salvar endereço...
    
    # Tenta encontrar elementos que indicam que o cardápio carregou
    ${success}=    Run Keyword And Return Status    Wait For Elements State    css=div.cardapio    visible    timeout=5s
    
    Run Keyword If    not ${success}    Log    Seletor div.cardapio não encontrado, tentando alternativas...
    
    # Tenta seletores alternativos
    Run Keyword If    not ${success}    
    ...    Run Keyword And Ignore Error    Wait For Elements State    css=[class*="cardapio"]    visible    timeout=5s
    
    Run Keyword If    not ${success}    
    ...    Run Keyword And Ignore Error    Wait For Elements State    css=[class*="menu"]    visible    timeout=5s
    
    Run Keyword If    not ${success}    
    ...    Run Keyword And Ignore Error    Wait For Elements State    text=*Cardápio*    visible    timeout=5s
      # Como última estratégia, aguarda a página estabilizar
    Run Keyword If    not ${success}    
    ...    Run Keywords
    ...    Log    Aguardando página estabilizar...
    ...    AND    Sleep    5s
    ...    AND    Run Keyword And Ignore Error    Wait For Load State    networkidle    timeout=15s
    
    # Tira screenshot do resultado final
    Log    Tirando screenshot do resultado...
    Take Screenshot    filename=resultado_final.png
      # Tira screenshot adicional da página inteira
    Take Screenshot    fullPage=True    filename=pagina_completa.png
    
    Log    Teste concluído! Verifique os screenshots gerados.
    
    # Aguarda 6 segundos antes de fechar automaticamente
    Log    Fechando automaticamente em 6 segundos...
    Sleep    6s
    
    Close Browser
