#!/bin/bash
set -e

echo "🚀 Démarrage du script d'installation automatique de WordPress..."

# WP install
if [ ! -d "/var/www/html/web/wp" ]; then
    echo "📦 Installation de WordPress via Composer..."
    composer install --no-interaction --prefer-dist --no-dev --optimize-autoloader
fi

# .env install
if [ -f "/var/www/html/.env.example" ] && [ ! -f "/var/www/html/.env" ]; then
    echo "📄 Copie de .env.example vers .env..."
    cp /var/www/html/.env.example /var/www/html/.env
fi

# wait mysql
echo "⏳ Attente de la disponibilité de MySQL..."
until mysqladmin ping -h"$WORDPRESS_DB_HOST" --silent; do
    sleep 2
    echo "🔄 En attente de MySQL..."
done
echo "✅ MySQL est disponible !"

# preinstall WP
echo "⚙️ Configuration de WordPress..."
if ! wp core is-installed --allow-root; then
    wp core install \
        --url="http://localhost:89" \
        --title="Mon Site WordPress" \
        --admin_user="admin" \
        --admin_password="admin" \
        --admin_email="admin@example.com" \
        --skip-email \
        --allow-root
    echo "✅ WordPress installé avec succès !"
else
    echo "🔹 WordPress est déjà installé."
fi

echo "✅ WordPress est maintenant totalement configuré et prêt à être utilisé !"
echo "🚀 Démarrage de PHP-FPM..."
exec "$@"
