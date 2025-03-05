#!/bin/bash

# ==========================================
# UNBLOADER LARAVEL - SCRIPT DE LIMPEZA
# ==========================================
# Este script remove componentes desnecessários
# de uma instalação Laravel e aplica configurações
# personalizadas.
# 
# Autor: Walisson Aguirra
# Email: walissonaguirra@proton.me
# ==========================================

# Definição de cores para saída no terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
RESET='\033[0m'
BOLD='\033[1m'
CIANO='\033[0;36m'

# Função para exibir mensagens de log com formatação
log() {
    echo -e "${BLUE}[INFO]${RESET} $1"
}

# Função para exibir mensagens de sucesso
success() {
    echo -e "${GREEN}[SUCESSO]${RESET} $1"
}

# Função para exibir mensagens de erro
error() {
    echo -e "${RED}[ERRO]${RESET} $1"
    exit 1
}

# Função para exibir mensagens de aviso
warning() {
    echo -e "${YELLOW}[AVISO]${RESET} $1"
}

# Função para exibir título de seção
section() {
    echo -e "\n${CIANO}== $1 ==${RESET}"
}

# Função para remover comentários de documentação dos arquivos PHP
removeDocBlock() {
    diretorio=${1:-app}
    if [ ! -d "$diretorio" ]; then
        warning "Diretório $diretorio/ não encontrado. Pulando remoção de DocBlocks."
        return
    fi

    log "Removendo comentarios DocBlocks do diretório ${BOLD}$diretorio/${RESET}"

    total_arquivos=$(find "$diretorio" -name "*.php" | wc -l)
    if [ "$total_arquivos" -eq 0 ]; then
        warning "Nenhum arquivo PHP encontrado em ${BOLD}$diretorio/${RESET}."
        return
    fi

    find "$diretorio" -name "*.php" | while read -r arquivo; do
        sed -i "/\/\*\*/,/\*\//d" "$arquivo"
        success "DocBlocks removido em ${BOLD}$arquivo${RESET}"
    done

    # success "Documentação removida de $total_arquivos arquivos em $diretorio"
    echo -ne "\r"
}

# Função para mostrar a animação de carregamento
loading() {
    local pid=$1
    local delay=0.2
    local spin='⠋⠙⠚⠒⠊⠑⠘⠴⠦⠧'

    while kill -0 $pid 2>/dev/null; do
        for i in $(seq 0 9); do
            echo -ne "\r${BLUE}${spin:i:1}${RESET} "
            sleep $delay
        done
    done
    echo -ne "\r"  # Limpa a linha
}

# Função para confirmar continuação do script
confirmContinue() {
    echo -e "\n${RED}⚠️  AVISO IMPORTANTE ⚠️${RESET}"
    echo -e "Este script é destinado APENAS para instalações ${GREEN}RECÉM-CRIADAS${RESET} do Laravel 12."
    echo -e "Ele removerá vários pacotes e aplicará modificações significativas no projeto."
    echo -e "Para mais detalhes sobre as alterações, visite: ${BLUE}https://github.com/walissonaguirra/unbloader-laravel${RESET}"
    echo -e "\nPressione ${GREEN}ENTER${RESET} para continuar ou ${RED}CTRL+C${RESET} para cancelar..."
    read -r
}

# Função principal
main() {
    # Exibir mensagem de confirmação
    confirmContinue

    # Verificar se estamos em um projeto Laravel
    if [ ! -f "artisan" ]; then
        error "Este script deve ser executado na raiz de um projeto Laravel"
    fi

    echo -e "\n${BLUE}======================================${RESET}"
    echo -e "${GREEN}   UNBLOADER LARAVEL - INICIANDO 🚀${RESET}"
    echo -e "${BLUE}======================================${RESET}\n"

    # Removendo arquivos desnecessários
    section "Limpeza de Arquivos"
    log "Removendo arquivos desnecessários"
    arquivos_remover=(".editorconfig" ".env.example" ".gitattributes" "phpunit.xml" "routes/console.php" "README.md")
    total=${#arquivos_remover[@]}

    for ((i=0; i<total; i++)); do
        arquivo="${arquivos_remover[$i]}"
        if [ -f "$arquivo" ]; then
            rm "$arquivo"
            success "Arquivo ${BOLD}$arquivo${RESET} removido"
        else
            warning "Arquivo não encontrado: $arquivo"
        fi
    done && loading
    
    # Removendo diretórios
    section "Limpeza de Diretórios"
    if [ -d "tests" ]; then
        log "Removendo diretório de testes"
        rm -rf tests
        success "Diretório ${BOLD}testes/${RESET} removido"
    else
        warning "Diretório ${BOLD}testes/${RESET} não encontrado"
    fi
   
    # URL do Github
    GIST_URL="https://raw.githubusercontent.com/walissonaguirra/unbloader-laravel/refs/heads/main/unbloader_laravel.patch"

    # Aplicar patch diretamente do Gist
    section "Aplicação de Configurações"
    log "Aplicando patch de configurações"
    if curl -sSL "$GIST_URL" | git apply & loading $! && wait $!; then
        success "Patch aplicado com sucesso"
    else
        error "Falha ao aplicar o patch"
    fi

    # Removendo documentação dos diretórios
    section "Limpeza de Documentação"
    removeDocBlock "app" && loading $!
    removeDocBlock "database" && loading $!

    # Removendo pacotes composer
    section "Ajustes de Dependências"
    log "Removendo pacotes do Composer"
    if command -v composer >/dev/null 2>&1; then
        if composer remove laravel/pail laravel/sail mockery/mockery phpunit/phpunit --dev --quiet & loading $! && wait $!; then
            success "Pacote ${BOLD}laravel/pail${RESET} removido"
            success "Pacote ${BOLD}laravel/sail${RESET} removido"
            success "Pacote ${BOLD}mockery/mockery${RESET} removido"
            success "Pacote ${BOLD}phpunit/phpunit${RESET} removido"
        else
            warning "Problema ao remover pacotes de desenvolvimento"
            warning "Pacote ${BOLD}laravel/pail${RESET} não removido"
            warning "Pacote ${BOLD}laravel/sail${RESET} não removido"
            warning "Pacote ${BOLD}mockery/mockery${RESET} não removido"
            warning "Pacote ${BOLD}phpunit/phpunit${RESET} não removido"
        fi

        if composer remove laravel/tinker --quiet & loading $! && wait $!; then
            success "Pacote ${BOLD}laravel/tinker${RESET} removido"
        else
            warning "Problema ao remover ${BOLD}laravel/tinker${RESET}"
        fi
    else
        error "Composer não encontrado. Verifique se está instalado e disponível no PATH"
    fi

    # Removendo pacotes npm
    log "Removendo pacotes NPM"
    if command -v npm >/dev/null 2>&1; then
        if npm uninstall @tailwindcss/vite tailwindcss --silent & loading $! && wait $!; then
            success "Pacote ${BOLD}@tailwindcss/vite${RESET} removido"
            success "Pacote ${BOLD}tailwindcss${RESET} removido"
        else
            warning "Problema ao remover pacotes NPM"
            warning "Pacote ${BOLD}@tailwindcss/vite${RESET} não removido"
            warning "Pacote ${BOLD}tailwindcss${RESET} não removido"
        fi
    else
        warning "NPM não encontrado. Pacotes não foram removidos"
    fi

    # Atualizando view welcome
    section "Configuração de Views"
    log "Atualizando página inicial"
    cat <<EOL > resources/views/welcome.blade.php
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        @if (file_exists(public_path('build/manifest.json')) || file_exists(public_path('hot')))
            @vite(['resources/css/app.css', 'resources/js/app.js'])
        @endif
    </head>
    <body>
       <main>{!! \$inspiring !!}</main>
    </body>
</html>
EOL
    success "Página inicial atualizada"

    # Criando arquivo .env
    section "Configuração de Ambiente"
    log "Configurando arquivo de ambiente .env"
    cat <<EOL > .env
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://127.0.0.1:8000

APP_LOCALE=pt-BR
APP_FALLBACK_LOCALE=en
APP_FAKER_LOCALE=pt_BR

DB_CONNECTION=sqlite
# DB_HOST=127.0.0.1
# DB_PORT=3306
# DB_DATABASE=laravel
# DB_USERNAME=root
# DB_PASSWORD=
EOL
    success "Arquivo .env configurado"

    # Gerando chave da aplicação
    log "Gerando chave da aplicação"
    if php artisan key:generate >/dev/null 2>&1; then
        success "Chave da aplicação gerada"
    else
        error "Falha ao gerar chave da aplicação"
    fi

    # Formatando código com Laravel Pint
    section "Formatação de Código"
    log "Formatando código com Laravel Pint"
    if vendor/bin/pint --quiet; then
        success "Código formatado com Laravel Pint"
    else
        warning "Falha ao formatar código com Laravel Pint. Verifique se está instalado"
    fi

    echo -e "\n${GREEN}======================================${RESET}"
    echo -e "${GREEN}   UNBLOADER LARAVEL - CONCLUÍDO ✨${RESET}"
    echo -e "${GREEN}======================================${RESET}\n"
}

# Executar a função principal
main