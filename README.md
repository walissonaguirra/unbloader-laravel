# Unbloader Laravel

[![Laravel Version](https://img.shields.io/badge/Laravel-12-FF2D20.svg?style=flat&logo=laravel&logoColor=white)](https://laravel.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25.svg?style=flat&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)

Script para simplificar e torna sua instalação Laravel menos "opnativa", removendo dependencia opcionais e aplicando configurações personalizadas para otimização.

<p align="center">

https://github.com/user-attachments/assets/4c2aa927-a280-4be2-bbbe-c61f24ff6d17

https://github.com/user-attachments/assets/c5c044aa-f077-4925-ab52-4bac1a89b7a2

</p>

> [!Warning]  
> Este script é destinado APENAS para instalações RECÉM-CRIADAS do Laravel 12!

## 📋 Requisitos

| Requisito | Versão/Sistema |
|-----------|----------------|
| Sistema Operacional | Linux (Ubuntu ou Arch) |
| PHP | 8.2 ou superior |
| Ferramentas | Composer, Git, NPM |
| Laravel | 12 (instalação nova) |

## 🚀 Uso Rápido

Após navega até a raiz do seu projeto laravel, execute o seguinte comando em seu terminal.

```bash
bash <(curl -sSL 'https://raw.githubusercontent.com/walissonaguirra/unbloader-laravel/main/unbloader_laravel.sh')
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

#### 2. **Remoção de Diretórios**

| **Diretório**         | **Descrição**                      |
|-----------------------|------------------------------------|
| `tests/`              | Remove o diretório de testes unitários e de integração |

#### 3. **Limpeza de Documentação**

| **Diretório**         | **Descrição**                      |
|-----------------------|------------------------------------|
| `app/`                | Remove anotações de documentação (DocBlocks) |
| `database/`           | Remove anotações de documentação (DocBlocks) |

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
