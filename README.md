# Unbloader Laravel

[![Laravel Version](https://img.shields.io/badge/Laravel-12-FF2D20.svg?style=flat&logo=laravel&logoColor=white)](https://laravel.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25.svg?style=flat&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)

Script para otimização de instalações novas do Laravel 12, removendo componentes desnecessários e aplicando configurações personalizadas.

<p align="center">
  <img src="demo.gif" alt="Demonstração do Unbloader Laravel em ação" width="800">
</p>

> [!Warning]  
> Este script é destinado APENAS para instalações RECÉM-CRIADAS do Laravel 12!

## 📋 Requisitos

| Requisito | Versão/Sistema |
|-----------|----------------|
| Sistema Operacional | Linux (Ubuntu ou Arch) |
| PHP | 8.2 ou superior |
| Ferramentas | Composer, Git, NPM (opcional) |
| Laravel | 12 (instalação nova) |

## 🚀 Uso Rápido

Para executar o script em uma instalação nova do Laravel 12, siga as instruções abaixo:

```bash
# Crie um novo projeto Laravel
composer create-project laravel/laravel meu-projeto

# Entre no diretório do projeto
cd meu-projeto

# Execute o script diretamente do repositório
curl -sSL 'https://raw.githubusercontent.com/walissonaguirra/unbloader-laravel/main/unbloader_laravel.sh' | bash
```
## ⚙️ O que o script faz?


O **Unbloader Laravel** realiza as seguintes modificações no seu projeto:

#### 1. **Remoção de Arquivos**

| **Arquivo**           | **Descrição**                      |
|-----------------------|------------------------------------|
| `.editorconfig`       | Remove configurações de editor     |
| `.env.example`        | Remove o arquivo de exemplo de ambiente |
| `.gitattributes`      | Remove atributos Git               |
| `phpunit.xml`         | Remove configuração de testes      |
| `routes/console.php`  | Remove rotas de console            |
| `README.md`           | Remove o README padrão             |

---

#### 2. **Remoção de Diretórios**

| **Diretório**         | **Descrição**                      |
|-----------------------|------------------------------------|
| `tests/`              | Remove o diretório de testes unitários e de integração |

---

#### 3. **Limpeza de Documentação**

| **Diretório**         | **Descrição**                      |
|-----------------------|------------------------------------|
| `app/`                | Remove anotações de documentação (DocBlocks) |
| `database/`           | Remove anotações de documentação (DocBlocks) |

---

#### 4. **Remoção de Dependências**

| **Dependência**       | **Tipo**   | **Descrição**                      |
|-----------------------|------------|------------------------------------|
| `laravel/pail`        | Composer (dev) | Remove dependência de desenvolvimento |
| `laravel/sail`        | Composer (dev) | Remove dependência de desenvolvimento |
| `mockery/mockery`     | Composer (dev) | Remove dependência de desenvolvimento |
| `phpunit/phpunit`     | Composer (dev) | Remove dependência de desenvolvimento |
| `laravel/tinker`      | Composer   | Remove dependência                 |
| `@tailwindcss/vite`   | NPM        | Remove dependência de front-end    |
| `tailwindcss`         | NPM        | Remove dependência de front-end    |

---

#### 5. **Configurações Adicionais**

| **Ação**                                                      | **Descrição**                           |
|---------------------------------------------------------------|-----------------------------------------|
| Aplicação de patch                                            | Personaliza a configuração do projeto  |
| Configuração da página inicial                                 | Define um design minimalista           |
| Configuração do arquivo `.env` para usar SQLite por padrão     | Altera a configuração do banco de dados |
| Geração de nova chave de aplicação                             | Gera uma chave única para o projeto    |
| Formatação do código com Laravel Pint                          | Aplica o formato de código padrão do Laravel |


## 📄 Licença
Este projeto está licenciado sob a [Licença MIT](LICENSE).

💻 Feito com ❤️ para a comunidade Laravel