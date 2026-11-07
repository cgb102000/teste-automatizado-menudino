# Teste automatizado - MenuDino

[![Testes](https://github.com/cgb102000/teste-automatizado-menudino/actions/workflows/testes.yml/badge.svg)](https://github.com/cgb102000/teste-automatizado-menudino/actions/workflows/testes.yml)

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
├── .github/workflows/testes.yml   # CI: dry-run a cada push; E2E sob demanda
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
- **CI**: a cada push, o `robot --dryrun` valida sintaxe, keywords e argumentos de todos os testes.

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

## CI e o anti-robô do site

O MenuDino fica atrás do Cloudflare. Nos servidores do GitHub Actions a página inicial não chega a exibir o campo de CEP (localmente o teste passa), o que indica bloqueio de acessos automatizados vindos de datacenter. Por isso:

- **A cada push**: roda a validação `--dryrun`, que não acessa o site.
- **E2E no GitHub**: só manual, em *Actions > Testes > Run workflow*, marcando a opção E2E. Pode ser bloqueado pelo site.
- **E2E completo**: rode localmente (`executar_teste.bat`), onde o acesso é de uma conexão residencial.

Se a página inicial não carregar, o teste falha com uma mensagem explicando o título e a URL recebidos, junto com um screenshot.

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
