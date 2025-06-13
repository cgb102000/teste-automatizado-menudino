# Teste Exploratório - MenuDino

Este projeto contém um teste automatizado para validar o preenchimento de endereço no site MenuDino usando Robot Framework com a biblioteca Browser (Playwright).

## 🚀 Guia Rápido para Iniciantes

### Passo 1: Baixar e Instalar Python
1. Vá para https://www.python.org/downloads/
2. Clique em "Download Python" (versão mais recente)
3. **IMPORTANTE**: Durante a instalação, marque a opção **"Add Python to PATH"**
4. Continue a instalação normalmente

### Passo 2: Verificar Instalação
Abra o Prompt de Comando (CMD) ou PowerShell e digite:
```cmd
python --version
```
Se aparecer a versão do Python, está tudo certo!

### Passo 3: Navegar até a pasta do projeto
```cmd
cd "C:\Users\Caio\Desktop\Teste exploratório Novo MenuDino"
```

### Passo 4: Instalar dependências automaticamente
```cmd
instalar.bat
```
Este comando vai instalar tudo que é necessário automaticamente.

### Passo 4.1: (Opcional) Verificar se tudo foi instalado
```cmd
verificar_instalacao.bat
```
Este script verifica se todas as dependências estão instaladas corretamente.

### Passo 5: Executar o teste
```cmd
executar_teste.bat
```

## 📁 Como obter este projeto

Se você não tem os arquivos ainda, você pode:

1. **Baixar via GitHub** (se disponível):
   - Clique em "Code" > "Download ZIP"
   - Extraia em uma pasta de sua preferência

2. **Ou criar manualmente**:
   - Crie uma pasta nova no seu computador
   - Baixe todos os arquivos deste projeto (.robot, .bat, requirements.txt, etc.)
   - Coloque todos na mesma pasta

## Pré-requisitos

### 1. Instalar Python

1. Acesse o site oficial do Python: https://www.python.org/downloads/
2. Baixe a versão mais recente do Python (3.8 ou superior)
3. Durante a instalação, **marque a opção "Add Python to PATH"**
4. Complete a instalação

Para verificar se o Python foi instalado corretamente:
```cmd
python --version
```

### 2. Verificar se o pip está instalado

O pip geralmente vem junto com o Python. Verifique executando:
```cmd
pip --version
```

## Instalação das Dependências

### Opção 1: Instalação Automática (Recomendada)

1. **Execute o script de instalação**:
   ```cmd
   instalar.bat
   ```

Este script irá:
- Verificar se o Python está instalado
- Instalar automaticamente o Robot Framework e bibliotecas necessárias
- Baixar os navegadores do Playwright
- Exibir mensagens de status durante o processo

### Opção 2: Instalação Manual

### 1. Instalar dependências via requirements.txt

```cmd
pip install -r requirements.txt
```

### 2. Inicializar o Playwright

Após instalar as dependências, execute o comando para baixar os navegadores necessários:

```cmd
python -m Browser.entry init
```

## Como Executar o Teste

### Opção 1: Execução Automática (Recomendada)

```cmd
executar_teste.bat 
```

Este script irá:
- Verificar se os arquivos necessários existem
- Executar o teste automaticamente
- Exibir progresso e observações importantes
- Abrir o relatório automaticamente em caso de sucesso
- Fechar o terminal automaticamente após 3 segundos

**Observação**: Mantenha o terminal aberto até o fim do teste. O teste pode demorar até 2 minutos para ser executado e você verá o navegador abrir automaticamente.

### Opção 2: Execução Manual

### 1. Navegar até o diretório do projeto

```cmd
cd "caminho\para\o\projeto\Teste exploratório Novo MenuDino"
```

### 2. Executar o teste

```cmd
python -m robot teste_menu_dino.robot
```

## Estrutura do Projeto

```
Teste exploratório Novo MenuDino/
├── README.md                      # Esta documentação
├── requirements.txt               # Dependências do projeto  
├── instalar.bat                   # Script de instalação automática
├── executar_teste.bat             # Script para executar o teste
├── verificar_instalacao.bat       # Script para verificar se tudo está instalado
├── teste_menu_dino.robot          # Arquivo principal do teste (CORRIGIDO)
├── teste_menu_dino_robusto.robot  # Versão ultra-robusta do teste
├── teste_menu_dino_backup.robot   # Backup da versão original
├── MELHORIAS.md                   # Documentação das melhorias
├── VERSOES_TESTE.md               # Guia das versões de teste
└── browser/                       # Pasta com screenshots (criada automaticamente)
    └── screenshot/
```

## O que o Teste Faz

O teste automatizado executa os seguintes passos:

1. **Abre o navegador** (Chromium) em modo visível
2. **Navega para o site** https://menudino.com/
3. **Preenche o CEP** no campo de busca (15043-540)
4. **Clica no botão "Buscar"**
5. **Aguarda aparecer** a tela de preenchimento de endereço
6. **Preenche os dados do endereço**:
   - Número: 121
   - Complemento: fundos
   - Ponto de referência: portão branco
7. **Clica em "Salvar Endereço"**
8. **Aguarda o cardápio aparecer**
9. **Tira um screenshot** do resultado
10. **Aguarda 6 segundos** antes de fechar automaticamente
11. **Fecha o navegador**

## Arquivos Gerados Após a Execução

Após executar o teste, os seguintes arquivos serão criados automaticamente:

- `log.html` - Log detalhado da execução
- `report.html` - Relatório resumido dos resultados
- `output.xml` - Resultados em formato XML
- `browser/` - Pasta com screenshots e traces do Playwright

## Parâmetros Configuráveis

No arquivo `teste_menu_dino.robot`, você pode alterar as seguintes variáveis:

```robotframework
*** Variables ***
${URL}              https://menudino.com/
${CEP}              15043-540           # Altere para outro CEP válido
${NUMERO}           121                 # Número da residência
${COMPLEMENTO}      fundos              # Complemento do endereço
${REFERENCIA}       portão branco       # Ponto de referência
```

## Possíveis Problemas e Soluções

### Erro: "'rfbrowser' não é reconhecido como um comando interno"
Este é o erro mais comum e acontece porque o comando `rfbrowser` não está disponível diretamente no PATH.

**Soluções (tente na ordem):**

1. **Use o comando correto**:
   ```cmd
   python -m Browser.entry init
   ```

2. **Se ainda não funcionar, instale novamente**:
   ```cmd
   pip uninstall robotframework-browser
   pip install robotframework-browser
   python -m Browser.entry init
   ```

3. **Alternativa com comando completo**:
   ```cmd
   python -c "from Browser.entry import main; main()"
   ```

### Erro: "robot: command not found" ou "'robot' não é reconhecido"
Este erro acontece quando o comando `robot` não está no PATH do sistema.

**Soluções:**
1. **Use o comando completo**:
   ```cmd
   python -m robot teste_menu_dino.robot
   ```

2. **Ou reinstale o Robot Framework**:
   ```cmd
   pip install robotframework
   ```

### Erro: "Browser library not found"
- **Solução**: Execute `pip install robotframework-browser` e depois `python -m Browser.entry init`

### Erro: "TimeoutError" no teste
- **Possível causa**: Site lento ou elemento não encontrado
- **Solução**: Aumente o timeout ou verifique se o site está funcionando

### Navegador não abre
- **Solução**: Execute `python -m Browser.entry init` para baixar os navegadores necessários

### Erro: "TimeoutError" - elemento não encontrado
Este erro acontece quando o teste não consegue encontrar um elemento na página no tempo esperado.

**Possíveis causas:**
- Site está lento para carregar
- Elemento mudou de classe/ID
- Elemento não existe mais na página

**Soluções implementadas no teste:**
- ✅ Timeouts aumentados para 15 segundos
- ✅ Múltiplas estratégias de detecção do cardápio
- ✅ Logs detalhados para acompanhar o progresso
- ✅ Screenshots automáticos mesmo em caso de erro
- ✅ Aguarda a página estabilizar como estratégia final

**Para debugging:**
1. Execute o teste e verifique os screenshots gerados
2. Verifique os logs no arquivo `log.html`
3. Se necessário, aumente ainda mais o timeout no arquivo `.robot`


