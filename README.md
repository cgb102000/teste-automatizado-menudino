# Teste automatizado - MenuDino

[![Testes E2E](https://github.com/cgb102000/teste-automatizado-menudino/actions/workflows/testes.yml/badge.svg)](https://github.com/cgb102000/teste-automatizado-menudino/actions/workflows/testes.yml)

Testes end-to-end do fluxo de **endereço de entrega por CEP** no site [MenuDino](https://menudino.com), escritos com **Robot Framework** e a **Browser Library** (Playwright).

## Cenários

| Cenário | Tipo | O que valida |
|---|---|---|
| CEP válido com endereço completo leva aos restaurantes da cidade | Positivo (smoke) | O CEP preenche a rua no modal, o endereço é salvo com número, complemento e referência, a página de restaurantes da cidade abre e o cabeçalho mostra o endereço com o número |
| Número é obrigatório para salvar o endereço | Negativo | Sem número, o site exibe "Informe um número para entrega." e mantém o modal aberto |

## Estrutura

```
├── tests/
│   └── endereco_por_cep.robot     # Casos de teste e massa de dados
├── resources/
│   └── menudino.resource          # Keywords reutilizáveis e seletores
├── .github/workflows/testes.yml   # CI: roda a cada push e toda segunda-feira
├── requirements.txt
├── instalar.bat                   # Instalação no Windows
├── verificar_instalacao.bat
└── executar_teste.bat             # Execução com navegador visível
```

Boas práticas aplicadas:

- **Page Object simplificado**: seletores e ações ficam no `.resource`, e os testes leem como passos de negócio.
- **Seletores estáveis**: IDs (`#add-addr-number`), papel acessível (`role=button[name="Buscar"]`) e textos visíveis, em vez de classes CSS.
- **Asserções de verdade**: o teste falha se o endereço não for salvo ou se a página esperada não abrir. Sem `Sleep` fixo: as esperas são por estado dos elementos.
- **Isolamento**: cada teste abre um contexto novo do navegador (sem endereço salvo) e fecha no teardown, mesmo em caso de falha.
- **Evidências**: screenshot automático em qualquer falha, junto com `log.html` e `report.html`.
- **CI agendada**: a execução semanal avisa quando o site muda e o teste precisa ser atualizado.

## Como rodar

Pré-requisitos: [Python 3.9+](https://www.python.org/downloads/) (marque "Add Python to PATH") e [Node.js LTS](https://nodejs.org/).

### Windows (scripts prontos)

```bat
instalar.bat
executar_teste.bat
```

### Linha de comando

```bash
pip install -r requirements.txt
rfbrowser init chromium

# Navegador invisível (padrão)
python -m robot --outputdir results tests

# Navegador visível
python -m robot --outputdir results --variable HEADLESS:False tests

# Só os testes de smoke
python -m robot --outputdir results --include smoke tests
```

Os resultados ficam em `results/` (`report.html`, `log.html` e screenshots de falha).

## Massa de dados

As variáveis ficam no topo de `tests/endereco_por_cep.robot`:

| Variável | Valor |
|---|---|
| `${CEP}` | 15043-540 |
| `${RUA}` | Rua Doutor Nelson Luiz Proença Fernandes |
| `${SLUG_CIDADE}` | sao-jose-do-rio-preto-sp |
| `${NUMERO}` / `${COMPLEMENTO}` / `${REFERENCIA}` | 121 / fundos / portão branco |

## Problemas comuns

- **`rfbrowser` não é reconhecido**: use `python -m Browser.entry init chromium`.
- **`robot` não é reconhecido**: use `python -m robot ...`.
- **Elemento não encontrado (timeout)**: o site pode ter mudado. Abra `results/log.html`, veja o screenshot da falha e ajuste o seletor em `resources/menudino.resource`.
