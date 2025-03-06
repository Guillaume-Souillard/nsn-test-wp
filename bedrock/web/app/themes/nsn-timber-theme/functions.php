<?php
/**
 * Timber starter-theme
 * https://github.com/timber/starter-theme
 */

// Load Composer dependencies.
require_once __DIR__ . '/vendor/autoload.php';

require_once __DIR__ . '/src/StarterSite.php';

Timber\Timber::init();

// Sets the directories (inside your theme) to find .twig files.
Timber::$dirname = [ 'templates', 'views' ];

new StarterSite();

function add_theme_scripts() {
    wp_enqueue_style('tailwind-styles', get_template_directory_uri() . '/dist/css/style.css', array(), '1.0.0');
}
add_action('wp_enqueue_scripts', 'add_theme_scripts');

// Ajouter le support des menus
function register_theme_menus() {
    register_nav_menus(array(
        'primary' => __('Menu Principal', 'your-theme-domain'),
        'footer' => __('Menu Footer', 'your-theme-domain')
    ));
}
add_action('init', 'register_theme_menus');
