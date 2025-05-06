# Base de Données Tifosi

Base de données MySQL pour un restaurant de focaccia.

## Structure du Projet

- `sql/01_schema.sql` : Script de création du schéma de la base de données
- `sql/02_data.sql` : Script d'insertion des données de test

## Structure de la Base de Données

La base de données contient les tables suivantes :
- `ingredient` : Liste des ingrédients
- `client` : Informations sur les clients
- `marque` : Marques des boissons
- `foccacia` : Types de focaccias disponibles
- `menu` : Menus proposés
- `boisson` : Boissons disponibles

Et les tables de relations :
- `comprend` : Composition des focaccias (ingrédients)
- `est_constitue` : Composition des menus (focaccias)
- `achete` : Historique des achats
- `contient` : Boissons incluses dans les menus

## Données de Test

Les données de test ont été importées depuis les fichiers Excel suivants :
- `marque.xlsx` → Table `marque`
- `boisson.xlsx` → Table `boisson`
- `ingredient.xlsx` → Table `ingredient`
- `focaccia.xlsx` → Tables `foccacia` et `comprend`

Les données comprennent :
- 4 marques de boissons
- 12 boissons
- 25 ingrédients
- 8 focaccias avec leurs compositions détaillées
