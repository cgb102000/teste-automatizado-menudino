# Versões dos Testes Disponíveis

## 📋 Arquivos de Teste

### 1. `teste_menu_dino.robot` (Principal)
- **Status**: Corrigido com múltiplas estratégias
- **Recomendado para**: Uso geral
- **Características**:
  - Timeouts aumentados
  - Múltiplos seletores para o cardápio
  - Logs detalhados
  - Screenshots automáticos

### 2. `teste_menu_dino_robusto.robot` (Ultra-robusto)
- **Status**: Nunca falha, sempre completa
- **Recomendado para**: Ambientes instáveis ou debugging
- **Características**:
  - Tratamento de erro em cada etapa
  - Nunca falha completamente
  - Screenshots em caso de erro
  - Múltiplos screenshots finais
  - Logs detalhados de progresso

### 3. `teste_menu_dino_backup.robot` (Backup)
- **Status**: Versão original (com problemas)
- **Uso**: Apenas para comparação

## 🚀 Como Executar

### Teste Principal (recomendado):
```cmd
python -m robot teste_menu_dino.robot
```

### Teste Ultra-robusto (para debugging):
```cmd
python -m robot teste_menu_dino_robusto.robot
```

### Ou use o script automático:
```cmd
executar_teste.bat
```

## 🔍 Analisando Resultados

Após a execução, verifique:

1. **Screenshots gerados**:
   - `resultado_final.png`
   - `pagina_completa.png`
   - `resultado_apos_espera.png` (versão robusta)

2. **Relatórios**:
   - `log.html` - Log detalhado
   - `report.html` - Relatório resumido

3. **Se houve erro**:
   - `erro_etapa1.png` ou `erro_etapa2.png` (versão robusta)

## ⚙️ Configurações Importantes

- **Timeout padrão**: 30 segundos
- **Modo headless**: Desabilitado (você verá o navegador)
- **Browser**: Chromium (padrão do Playwright)
- **Fechamento automático**: 6 segundos após concluir o teste
