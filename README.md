# Sample Tracking

## Sobre o Projeto

Este projeto é o Front-end que funciona em conjunto com [ContactList](https://github.com/m4rcelotoledo/ContactList).

É uma aplicação web simples construída com Sinatra que permite navegar e criar novos contatos via POST, utilizando uma API REST. Gera dados de tracking e envia informações para outro projeto (ContactList).

## Informações Técnicas e Dependências

```code
- Docker            - versão 20.10+
- Docker Compose    - versão 2.0+
- Ruby              - versão 3.4.6
- Sinatra           - versão 3.2+
- Puma              - versão 7.0+
- RuboCop           - versão 1.81+ (desenvolvimento)
```

## Funcionalidades

- ✅ **Ruby 3.4.6** - Versão mais recente do Ruby com melhorias de performance
- ✅ **Sinatra 3.2** - Framework web moderno e leve
- ✅ **Puma 7.0** - Servidor web de alta performance
- ✅ **Configuração por Ambiente** - Configuração flexível via variáveis de ambiente
- ✅ **JavaScript Moderno** - Vanilla JS com recursos ES6+, sem dependência do jQuery
- ✅ **Health Check** - Endpoint `/health` para monitoramento
- ✅ **Design Responsivo** - Interface amigável para dispositivos móveis
- ✅ **Formulário de Contato** - Submissão de contatos integrada com tracking
- ✅ **User Tracking** - Rastreamento automático de visitas com persistência de GUID
- ✅ **Dockerização** - Containerização completa com Docker e Docker Compose
- ✅ **Makefile** - Automação de build e deploy com comandos simples

## Variáveis de Ambiente

A aplicação pode ser configurada usando variáveis de ambiente:

- `PORT`: Porta para executar a aplicação (padrão: 4567)
- `HOST`: Host para vincular a aplicação (padrão: 0.0.0.0)
- `RACK_ENV`: Modo do ambiente (padrão: development)
- `CONTACT_API_URL`: URL da API de submissão de contatos (padrão: http://localhost:3000/contacts)
- `TRACKING_API_URL`: URL da API de tracking (padrão: http://localhost:3000/tracks)
- `APP_NAME`: Nome da aplicação (padrão: Sample Tracking)
- `APP_VERSION`: Versão da aplicação (padrão: 1.0.0)

## Uso com Docker

Clone o projeto e prepare para usar:

```bash
git clone git@github.com:m4rcelotoledo/sample_tracking.git
cd sample_tracking
```

### Executar a Aplicação

Para verificar se a aplicação executa corretamente:

```bash
# Usando Makefile (recomendado)
make up

# Ou usando Docker Compose diretamente
docker-compose up --build
```

Para ver a aplicação em ação, abra uma janela do navegador e navegue para <http://localhost:4567>.

### Health Check

Verifique a saúde da aplicação em: <http://localhost:4567/health>

## Desenvolvimento

### Desenvolvimento Local (sem Docker)

1. Instale Ruby 3.4.6 usando asdf ou rbenv
2. Instale as dependências:
   ```bash
   bundle install
   ```
3. Execute a aplicação:
   ```bash
   bundle exec ruby app.rb
   ```

### Configuração do Ambiente

1. Copie o arquivo de exemplo de ambiente:
   ```bash
   cp env.example .env
   ```
2. Edite `.env` com seus valores de configuração
3. Execute a aplicação

### Comandos Makefile

O projeto inclui um Makefile com comandos úteis:

```bash
make help          # Mostra todos os comandos disponíveis
make build         # Constrói a imagem Docker
make up            # Sobe a aplicação
make down          # Para a aplicação
make logs          # Mostra os logs
make health        # Verifica a saúde da aplicação
make clean         # Limpa containers e imagens
make dev           # Modo desenvolvimento
make prod          # Modo produção
make test          # Executa testes
make status        # Status dos containers
make restart       # Reinicia a aplicação
make stop          # Para a aplicação
make deploy        # Deploy da aplicação
```

## Estrutura do Projeto

```
sample_tracking/
├── app.rb                 # Aplicação principal Sinatra
├── config.ru             # Configuração Rack
├── config/
│   └── puma.rb           # Configuração do Puma
├── Dockerfile            # Imagem Docker
├── docker-compose.yml    # Configuração Docker Compose
├── Makefile              # Comandos de automação
├── Gemfile               # Dependências Ruby
├── Gemfile.lock          # Versões fixas das dependências
├── env.example           # Exemplo de variáveis de ambiente
├── .gitignore            # Arquivos ignorados pelo Git
├── .dockerignore         # Arquivos ignorados pelo Docker
├── public/               # Arquivos estáticos
│   ├── assets/
│   │   ├── css/          # Estilos CSS
│   │   ├── js/           # JavaScript moderno
│   │   └── fonts/        # Fontes
│   └── images/           # Imagens
└── views/
    └── index.html        # Template principal
```

## Melhorias Implementadas

- **Upgrade do Ruby**: 2.7.0 → 3.4.6
- **Substituição do WEBrick**: Por Puma 7.0 para melhor performance
- **JavaScript Moderno**: Removida dependência do jQuery, implementado Vanilla JS
- **Dockerização**: Containerização completa com Alpine Linux
- **Automação**: Substituição de scripts por Makefile moderno
- **Configuração**: Sistema de variáveis de ambiente
- **Monitoramento**: Endpoint de health check
- **Qualidade de Código**: Integração do RuboCop

## Créditos do Template

Template HTML usado de html5up.net | @ajlkn

- Template: Dimension by HTML5 UP
- [Credits.txt](Credits.txt)
