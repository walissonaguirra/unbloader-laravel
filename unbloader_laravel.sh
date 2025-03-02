#!/bin/bash

rm .editorconfig
rm .env.example
rm .gitattributes
rm phpunit.xml
rm -rf tests
rm routes/console.php
rm README.md

git apply unbloader_laravel.patch

rd() {
    dir=${1:-app}
    find "$dir" -name "*.php" -exec sed -i "/\/\*\*/,/\*\//d" {} +
}

rd app
rd database

composer remove laravel/pail laravel/sail mockery/mockery phpunit/phpunit --dev
composer remove laravel/tinker

npm uninstall @tailwindcss/vite
npm uninstall tailwindcss

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

php artisan key:generate
vendor/bin/pint