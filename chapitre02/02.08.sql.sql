SELECT *
FROM Contact c 
LIMIT 1 OFFSET 10;

SELECT *
FROM Contact c 
NATURAL JOIN Inscription i 
ORDER BY c.ContactId ;

SELECT *
FROM Contact c 
JOIN Inscription i USING (ContactId)
ORDER BY c.ContactId ;

SELECT DISTINCT Nom
FROM Contact c 
WHERE Nom LIKE '%grand%'
ORDER BY Nom ;

SELECT DISTINCT Nom
FROM Contact c 
WHERE Nom GLOB '*[Gg]rand*'
ORDER BY Nom ;
