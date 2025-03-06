#!/bin/bash
set -e

echo "🚀 Démarrage du script d'installation automatique de WordPress..."

# Composer
echo "📦 Installation de Composer..."
composer install --optimize-autoloader
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

# import started db
if [ -f "/var/www/html/docker/wordpress/start-dump.sql" ]; then
    echo "📥 Importation du fichier SQL de départ dans MySQL..."
    mysql -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" "$WORDPRESS_DB_NAME" < /var/www/html/docker/wordpress/start-dump.sql
    echo "✅ Base de données importée avec succès !"
else
    echo "⚠️ Fichier start-dump.sql non trouvé, aucune base importée."
fi

THEME_PATH="/var/www/html/web/app/themes/nsn-timber-theme"

if [ -d "$THEME_PATH" ]; then
    echo "🎨 Installation des dépendances pour le thème NSN Timber..."

    # composer
    if [ -f "$THEME_PATH/composer.json" ]; then
        echo "📦 Installation des dépendances Composer du thème..."
        composer install --optimize-autoloader --working-dir="$THEME_PATH"
    else
        echo "⚠️ Aucun composer.json trouvé dans $THEME_PATH, skipping..."
    fi

    # yarn
    if [ -f "$THEME_PATH/package.json" ]; then
        echo "📦 Installation des dépendances Yarn du thème..."
        cd "$THEME_PATH"
        yarn install

        echo "⚙️ Build du thème avec Yarn..."
        yarn build
    else
        echo "⚠️ Aucun package.json trouvé dans $THEME_PATH, skipping..."
    fi

    echo "✅ Dépendances du thème NSN Timber installées et buildées !"
else
    echo "⚠️ Le dossier du thème $THEME_PATH n'existe pas, skipping..."
fi

echo "✅ WordPress est maintenant totalement configuré et prêt à être utilisé !"
echo "🚀 Démarrage de PHP-FPM..."
exec "$@"
