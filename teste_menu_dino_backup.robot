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
    New Browser    headless=False
    New Page    ${URL}

    Wait For Elements State    input[placeholder="Digite seu CEP"]    visible    timeout=10s
    Fill Text    input[placeholder="Digite seu CEP"]    ${CEP}
    Click    text=Buscar    Wait For Elements State    text=Adicione seu endereço!    visible    timeout=10s
    Fill Text    input[placeholder="Número"]    ${NUMERO}
    Fill Text    input[placeholder="Complemento"]    ${COMPLEMENTO}
    Fill Text    input[placeholder="Ponto de referência"]    ${REFERENCIA}
    Click    text=Salvar Endereço

    # Estratégia mais robusta: tentar múltiplos seletores para o cardápio
    ${cardapio_encontrado}=    Run Keyword And Return Status    
    ...    Wait For Elements State    css=div.cardapio    visible    timeout=5s
    
    Run Keyword If    not ${cardapio_encontrado}    
    ...    Run Keywords
    ...    Log    Tentando seletor alternativo para cardápio...    
    ...    AND    Wait For Elements State    css=[class*="cardapio"]    visible    timeout=5s
    
    # Se ainda não encontrou, tenta por texto que indica carregamento do cardápio
    ${cardapio_por_texto}=    Run Keyword And Return Status    
    ...    Wait For Elements State    text=*Menu*    visible    timeout=5s
    
    # Como última opção, espera a página carregar completamente
    Run Keyword If    not ${cardapio_encontrado} and not ${cardapio_por_texto}
    ...    Run Keywords
    ...    Log    Aguardando carregamento geral da página...
    ...    AND    Sleep    3s
    ...    AND    Wait For Load State    networkidle    timeout=10s

    # Tira screenshot independente do que aconteceu
    Take Screenshot    path=C:\\Users\\Caio\\Desktop\\Teste exploratório Novo MenuDino\\browser\\screenshot\\resultado.png

    Close Browser
