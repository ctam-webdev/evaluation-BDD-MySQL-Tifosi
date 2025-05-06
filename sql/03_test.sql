
-- Script de test pour la base de données Tifosi
USE tifosi;

-- 1. Liste des noms des focaccias par ordre alphabétique croissant
SELECT nom
FROM foccacia
ORDER BY nom ASC;

-- 2. Nombre total d'ingrédients
SELECT COUNT(*) as nombre_ingredients
FROM ingredient;

-- 3. Prix moyen des focaccias
SELECT ROUND(AVG(prix), 2) as prix_moyen
FROM foccacia;

-- 4. Liste des boissons avec leur marque, triée par nom de boisson
SELECT b.nom as boisson, m.nom as marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom;

-- 5. Liste des ingrédients pour une Raclaccia
SELECT i.nom as ingredient, c.quantite
FROM ingredient i
JOIN comprend c ON i.id_ingredient = c.id_ingredient
JOIN foccacia f ON c.id_foccacia = f.id_foccacia
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom;

-- 6. Nom et nombre d'ingrédients pour chaque foccacia
SELECT f.nom, COUNT(c.id_ingredient) as nombre_ingredients
FROM foccacia f
JOIN comprend c ON f.id_foccacia = c.id_foccacia
GROUP BY f.id_foccacia, f.nom
ORDER BY f.nom;

-- 7. Nom de la focaccia qui a le plus d'ingrédients
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

-- 8. Liste des focaccia qui contiennent de l'ail
SELECT DISTINCT f.nom
FROM foccacia f
JOIN comprend c ON f.id_foccacia = c.id_foccacia
JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom;

-- 9. Liste des ingrédients inutilisés
SELECT i.nom as ingredient
FROM ingredient i
LEFT JOIN comprend c ON i.id_ingredient = c.id_ingredient
WHERE c.id_ingredient IS NULL
ORDER BY i.nom;

-- 10. Liste des focaccia qui n'ont pas de champignons
SELECT f.nom
FROM foccacia f
WHERE f.id_foccacia NOT IN (
    SELECT c.id_foccacia
    FROM comprend c
    JOIN ingredient i ON c.id_ingredient = i.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom;