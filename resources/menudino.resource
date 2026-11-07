*** Settings ***
Documentation       Keywords e seletores da página inicial do MenuDino (fluxo de endereço por CEP).
Library             Browser    run_on_failure=Take Screenshot    timeout=20s


*** Variables ***
${URL}                  https://menudino.com/
${HEADLESS}             ${TRUE}
${BROWSER}              chromium

# Seletores
${CAMPO_BUSCA}          input[placeholder="Digite sua cidade ou CEP"]
${BOTAO_BUSCAR}         role=button[name="Buscar"]
${MODAL_TITULO}         text=Confirme seu endereço
${CAMPO_NUMERO}         id=add-addr-number
${CAMPO_COMPLEMENTO}    id=add-addr-complement
${CAMPO_REFERENCIA}     id=add-addr-reference
${BOTAO_SALVAR}         text="Salvar endereço"
${AVISO_SEM_NUMERO}     text=Informe um número para entrega.
${ENTREGAR_EM}          text=Entregar em


*** Keywords ***
Abrir MenuDino
    [Documentation]    Abre o navegador em uma sessão limpa, sem endereço salvo.
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    locale=pt-BR    viewport={'width': 1366, 'height': 768}
    New Page    ${URL}
    Wait For Elements State    ${CAMPO_BUSCA}    visible

Fechar Navegador
    Close Browser    ALL

Buscar Endereço Pelo CEP
    [Arguments]    ${cep}
    Fill Text    ${CAMPO_BUSCA}    ${cep}
    Click    ${BOTAO_BUSCAR}
    Wait For Elements State    ${MODAL_TITULO}    visible

Modal Deve Mostrar A Rua
    [Arguments]    ${rua}
    Wait For Elements State    text=${rua}    visible

Preencher Detalhes Do Endereço
    [Arguments]    ${numero}    ${complemento}=${EMPTY}    ${referencia}=${EMPTY}
    Fill Text    ${CAMPO_NUMERO}    ${numero}
    IF    $complemento    Fill Text    ${CAMPO_COMPLEMENTO}    ${complemento}
    IF    $referencia    Fill Text    ${CAMPO_REFERENCIA}    ${referencia}

Salvar Endereço
    Click    ${BOTAO_SALVAR}

Deve Estar Na Página De Restaurantes Da Cidade
    [Arguments]    ${slug_cidade}
    Wait For Condition    Url    should end with    /delivery/${slug_cidade}

Endereço De Entrega Deve Conter
    [Arguments]    ${texto}
    Wait For Elements State    ${ENTREGAR_EM}    visible
    Get Text    body    contains    ${texto}

Deve Exibir Aviso De Número Obrigatório
    Wait For Elements State    ${AVISO_SEM_NUMERO}    visible
    Wait For Elements State    ${MODAL_TITULO}    visible    message=O modal fechou mesmo sem o número.
