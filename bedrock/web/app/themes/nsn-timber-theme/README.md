# Thème de départ Timber avec Tailwind CSS

Ce projet est basé sur le [Timber Starter Theme](https://github.com/timber/starter-theme), un thème minimaliste pour démarrer avec Timber et WordPress. J'y ai intégré Tailwind CSS afin de faciliter la gestion du style et optimiser le développement front-end.

## Installation du thème

Suivez le guide officiel pour [installer Timber avec le thème de départ](https://timber.github.io/docs/v2/installation/installation/#use-the-starter-theme).

Ensuite :

1. Renommez le dossier du thème selon le nom de votre projet.
2. Activez le thème dans le tableau de bord WordPress sous **Apparence → Thèmes**.
3. Profitez de Timber et Tailwind pour développer votre site efficacement !

## Compilation et développement

Pour compiler les styles et scripts :

- En mode développement :
  ```sh
  yarn dev
  ```
- Pour une version optimisée en production :
  ```sh
  yarn build
  ```

## Structure du projet

- **`static/`** : Contient les fichiers front-end tels que les scripts JS, styles CSS (avec Tailwind), polices et images.
- **`views/`** : Contient les fichiers Twig utilisés par Timber pour générer les pages.
- **`src/`** : Contient la classe `StarterSite`, que vous pouvez modifier pour ajouter des fonctionnalités au thème.

## Ressources utiles

- [Documentation Timber](https://timber.github.io/docs/)
- [Documentation Tailwind CSS](https://tailwindcss.com/)
- [Twig pour Timber - Cheatsheet](http://notlaura.com/the-twig-for-timber-cheatsheet/)

