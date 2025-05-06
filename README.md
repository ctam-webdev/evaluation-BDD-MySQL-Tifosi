# Base de Données Tifosi

Base de données MySQL pour un restaurant de focaccia.

## Structure du Projet

- `sql/01_schema.sql` : Script de création du schéma de la base de données
- `sql/02_data.sql` : Script d'insertion des données de test
- `sql/03_test.sql` : Script des requêtes de test pour validation

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

## Requêtes de Test

Le script `03_test.sql` contient des requêtes pour valider la base de données :
1. Liste des focaccias par ordre alphabétique
2. Nombre total d'ingrédients disponibles
3. Prix moyen des focaccias
4. Liste des boissons avec leurs marques
5. Liste des ingrédients d'une focaccia spécifique
6. Nombre d'ingrédients par focaccia
7. Focaccia avec le plus d'ingrédients
8. Focaccias contenant de l'ail
9. Ingrédients non utilisés
10. Focaccias sans champignons
