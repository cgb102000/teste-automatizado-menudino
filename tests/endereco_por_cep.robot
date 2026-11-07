*** Settings ***
Documentation       Valida o cadastro do endereço de entrega a partir de um CEP na página inicial do MenuDino.
Resource            ../resources/menudino.resource

Test Setup          Abrir MenuDino
Test Teardown       Fechar Navegador


*** Variables ***
${CEP}              15043-540
${RUA}              Rua Doutor Nelson Luiz Proença Fernandes
${SLUG_CIDADE}      sao-jose-do-rio-preto-sp
${NUMERO}           121
${COMPLEMENTO}      fundos
${REFERENCIA}       portão branco


*** Test Cases ***
CEP válido com endereço completo leva aos restaurantes da cidade
    [Documentation]    Fluxo feliz: o CEP preenche a rua, o usuário completa número, complemento e
    ...    referência, e o site salva o endereço e abre os restaurantes da cidade.
    [Tags]    smoke    positivo
    Buscar Endereço Pelo CEP    ${CEP}
    Modal Deve Mostrar A Rua    ${RUA}
    Preencher Detalhes Do Endereço    ${NUMERO}    ${COMPLEMENTO}    ${REFERENCIA}
    Salvar Endereço
    Deve Estar Na Página De Restaurantes Da Cidade    ${SLUG_CIDADE}
    Endereço De Entrega Deve Conter    , ${NUMERO}

Número é obrigatório para salvar o endereço
    [Documentation]    Cenário negativo: sem o número, o site avisa e mantém o modal aberto.
    [Tags]    negativo    validacao
    Buscar Endereço Pelo CEP    ${CEP}
    Salvar Endereço
    Deve Exibir Aviso De Número Obrigatório
