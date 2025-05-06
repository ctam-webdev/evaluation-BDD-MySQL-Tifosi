-- Script d'export et analyse des résultats des requêtes de test
USE tifosi;

/*
Requête #1 : Liste des focaccias par ordre alphabétique
But : Vérifier l'insertion correcte des focaccias et leur tri alphabétique
Code SQL :
*/
SELECT nom
FROM foccacia
ORDER BY nom ASC;
/*
Résultat attendu :
- Liste de 8 focaccias triées par ordre alphabétique
- Doit correspondre aux focaccias insérées dans 02_data.sql :
  * Mozaccia
  * Gorgonzollaccia
  * Raclaccia
  * Emmentalaccia
  * Tradizione
  * Hawaienne
  * Américaine
  * Paysanne

Résultat obtenu :
- Américaine
- Emmentalaccia
- Gorgonzollaccia
- Hawaienne
- Mozaccia
- Paysanne
- Raclaccia
- Tradizione

Analyse des écarts :
Aucun écart constaté. Les 8 focaccias sont présentes et correctement triées par ordre alphabétique.
*/

/*
Requête #2 : Nombre total d'ingrédients
But : Vérifier que tous les ingrédients ont été importés correctement
Code SQL :
*/
SELECT COUNT(*) as nombre_ingredients
FROM ingredient;
/*
Résultat attendu :
- 25 ingrédients au total (selon les données de 02_data.sql)

Résultat obtenu :
25 ingrédients au total

Analyse des écarts :
Aucun écart constaté. Le nombre d'ingrédients correspond exactement au nombre attendu selon 02_data.sql.
*/

/*
Requête #3 : Prix moyen des focaccias
But : Analyser la cohérence des prix des focaccias
Code SQL :
*/
SELECT ROUND(AVG(prix), 2) as prix_moyen
FROM foccacia;
/*
Résultat attendu :
- Prix moyen arrondi à 2 décimales
- Devrait être cohérent avec les prix du fichier focaccia.xlsx

Résultat obtenu :
- Le prix moyen d'une foccacia est de 10.28 (cohérent avec le fichier)

Analyse des écarts :
- Aucun écart constaté, le prix moyen est cohérent.
*/

/*
Requête #4 : Liste des boissons avec leur marque
But : Vérifier la relation entre boissons et marques
Code SQL :
*/
SELECT b.nom as boisson, m.nom as marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom;
/*
Résultat attendu :
- 12 boissons au total (selon 02_data.sql)
- Chaque boisson associée à sa marque correcte
- Liste triée par nom de boisson

Résultat obtenu :
- Capri-sun (Coca-cola)
- Coca-cola original (Coca-cola)
- Coca-cola zéro (Coca-cola)
- Eau de source (Cristalline)
- Fanta citron (Coca-cola)
- Fanta orange (Coca-cola)
- Lipton Peach (Pepsico)
- Lipton zéro citron (Pepsico)
- Monster energy ultra blue (Monster)
- Monster energy ultra gold (Monster)
- Pepsi (Pepsico)
- Pepsi Max Zéro (Pepsico)

Analyse des écarts :
- Aucun écart constaté, la relation entre boissons et marques est cohérente avec le fichier 02_data.sql
*/

/*
Requête #5 : Ingrédients de la Raclaccia
But : Vérifier la composition détaillée d'une focaccia spécifique
Code SQL :
*/
SELECT i.nom as ingredient, c.quantite
FROM ingredient i
JOIN comprend c ON i.id_ingredient = c.id_ingredient
JOIN foccacia f ON c.id_foccacia = f.id_foccacia
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom;
/*
Résultat attendu :
- Liste des ingrédients de la Raclaccia selon 02_data.sql
- Les quantités doivent correspondre aux données insérées

Résultat obtenu :
- Ail : 2
- Base Tomate : 200
- Champignon : 40
- Cresson : 20
- Parmesan : 50
- Poivre : 1
- Raclette : 50

Analyse des écarts :
Aucun écart constaté, la composition de la Raclaccia est cohérente avec le fichier 02_data.sql
*/

/*
Requête #6 : Nombre d'ingrédients par focaccia
But : Analyser la complexité des recettes
Code SQL :
*/
SELECT f.nom, COUNT(c.id_ingredient) as nombre_ingredients
FROM foccacia f
JOIN comprend c ON f.id_foccacia = c.id_foccacia
GROUP BY f.id_foccacia, f.nom
ORDER BY f.nom;
/*
Résultat attendu :
- 8 focaccias listées
- Nombre d'ingrédients cohérent avec le fichier focaccia.xlsx

Résultat obtenu :
- Américaine : 8
- Emmentalaccia : 7
- Gorgonzollaccia : 8
- Hawaienne : 8
- Mozaccia : 8
- Paysanne : 12
- Raclaccia : 7
- Tradizione : 9

Analyse des écarts :
Aucun écart constaté, le nombre d'ingrédients par focaccia est cohérent avec le fichier 02_data.sql
*/

/*
Requête #7 : Focaccia avec le plus d'ingrédients
But : Identifier la recette la plus complexe
Code SQL :
*/
SELECT f.nom, COUNT(c.id_ingredient) as nombre_ingredients
FROM foccacia f
JOIN comprend c ON f.id_foccacia = c.id_foccacia
GROUP BY f.id_foccacia, f.nom
HAVING COUNT(c.id_ingredient) = (
    SELECT COUNT(id_ingredient)
    FROM comprend
    GROUP BY id_foccacia
    ORDER BY COUNT(id_ingredient) DESC
    LIMIT 1
);
/*
Résultat attendu :
- Une seule focaccia (ou plusieurs en cas d'égalité)
- Nombre d'ingrédients maximum

Résultat obtenu :
- Paysanne : 12

Analyse des écarts :
Aucun écart constaté, la focaccia avec le plus d'ingrédients est cohérente avec le fichier 02_data.sql
*/

/*
Requête #8 : Focaccias contenant de l'ail
But : Tester la recherche par ingrédient spécifique
Code SQL :
*/
SELECT DISTINCT f.nom
FROM foccacia f
JOIN comprend c ON f.id_foccacia = c.id_foccacia
JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom;
/*
Résultat attendu :
- Liste des focaccias contenant de l'ail selon 02_data.sql
- Résultat trié par ordre alphabétique

Résultat obtenu :
- Gorgonzollaccia
- Paysanne
- Raclaccia

Analyse des écarts :
Aucun écart constaté, la liste des focaccias contenant de l'ail est cohérente avec le fichier 02_data.sql
*/

/*
Requête #9 : Ingrédients inutilisés
But : Identifier les ingrédients jamais utilisés dans les recettes
Code SQL :
*/
SELECT i.nom as ingredient
FROM ingredient i
LEFT JOIN comprend c ON i.id_ingredient = c.id_ingredient
WHERE c.id_ingredient IS NULL
ORDER BY i.nom;
/*
Résultat attendu :
- Liste des ingrédients qui n'apparaissent dans aucune recette
- Permet d'identifier les ingrédients potentiellement à supprimer

Résultat obtenu :
- Tomate cerise

Analyse des écarts :
Aucun écart constaté, la liste des ingrédients inutilisés est cohérente avec le fichier 02_data.sql
*/

/*
Requête #10 : Focaccias sans champignons
But : Tester l'exclusion d'un ingrédient spécifique
Code SQL :
*/
SELECT f.nom
FROM foccacia f
WHERE f.id_foccacia NOT IN (
    SELECT c.id_foccacia
    FROM comprend c
    JOIN ingredient i ON c.id_ingredient = i.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom;
/*
Résultat attendu :
- Liste des focaccias ne contenant pas de champignons selon 02_data.sql
- Résultat trié par ordre alphabétique

Résultat obtenu :
- Américaine
- Hawaienne

Analyse des écarts :
Aucun écart constaté, la liste des focaccias sans champignons est cohérente avec le fichier 02_data.sql
*/
