#!/bin/bash
set -e

echo "🚀 Démarrage du script d'installation automatique de WordPress..."

# Composer
echo "📦 Installation de Composer..."
composer install --no-interaction --prefer-dist --no-dev --optimize-autoloader
wait

# .env install
if [ -f "/var/www/html/.env.example" ] && [ ! -f "/var/www/html/.env" ]; then
    echo "📄 Copie de .env.example vers .env..."
    cp /var/www/html/.env.example /var/www/html/.env
fi

echo "🛠️ Vérification des permissions sur wp-content/uploads..."
mkdir -p /var/www/html/web/app/uploads/
chown -R www-data:www-data /var/www/html/web/app/uploads/
chmod -R 755 /var/www/html/web/app/uploads/
echo "✅ Permissions corrigées pour wp-content/uploads !"

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

echo "🔌 Activation du plugin NSN LazyLoad..."
wp plugin activate nsn-wp-lazyload-plugin --allow-root || true

echo "✅ WordPress est maintenant totalement configuré et prêt à être utilisé !"
echo "🚀 Démarrage de PHP-FPM..."
exec "$@"
