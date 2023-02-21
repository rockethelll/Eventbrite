![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/rockethelll/Eventbrite)

# Eventbrite prokect

Vous pouvez regarder la liste des événements qui sont prévus dans les jours à venir, créer un compte, vous connecter.

## Fonctionnement

* Pense à démarrer le service postgresql si tu utilises WSL &rarr; `sudo service postgresql start`
* Lance `bundle install`
* Puis `rails db:create`
* Et enfin `rails db:migrate` pour mettre tes bases de données UP

Un fichier contenant des générateurs de contenu aléatoire est à disposition pour effectuer des tests.
Pour t'en servir et remplir tes bases, lance cette dernière commande `rails db:seed`.

## Accès au site

Pour accéder au site, lance la commande `rails s` qui va lancer un serveur.
Va sur [le site](http://localhost:3000) via ce lien une fois que tu as exécuté toutes ces commandes.

Le site est également visible sur internet à l'adresse suivante https://my-eventbrite.herokuapp.com/events
