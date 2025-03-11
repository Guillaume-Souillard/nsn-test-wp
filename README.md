# Test technique NSN Wordpress / Bedrock / Timber
Pour lancer le projet il suffit de suivre les instructions suivantes.

Tout est automatisé ici : https://github.com/Guillaume-Souillard/nsn-test-wp/blob/main/docker/wordpress/entrypoint.sh donc vous n'avez normalement rien à faire.

## On le clone
```
git clone git@github.com:Guillaume-Souillard/nsn-test-wp.git
```

## On l'initialise avec Docker

```
docker compose build 
docker compose up -d
```

Ensuite, rendez-vous ici (Bien attendre que le container php a bien fini sa popote d'installation de composer etc... Voir entrypoint.sh pour plus d'infos): 

http://localhost:89/sample-page/

Sur cette page, vous aurez un exemple avec 2 photos pour démontrer que le plugin de lazyload fonctionne bien.

Ce dernier est installé automatique avec composer grâce à bedrock.

Vous pouvez le retrouver ici : https://github.com/Guillaume-Souillard/nsn-wp-lazyload-plugin

On debrief de tout ça dans une visio si vous voulez.
