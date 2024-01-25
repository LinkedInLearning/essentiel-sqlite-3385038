DROP TABLE IF EXISTS Activite; 

CREATE TABLE IF NOT EXISTS Activite 
(
    ActiviteId INTEGER PRIMARY KEY,
    Type integer CHECK (Type BETWEEN 1 AND 5),
    Date text UNIQUE ON CONFLICT REPLACE,
    Prix real NOT NULL CHECK (Prix > 0),
    Description text COLLATE NOCASE
) STRICT;

INSERT INTO Activite (Type, Date, Prix, Description)
VALUES 
	(3, '2024-01-10', 1, 'Très intéressant'),
	(1, '2024-01-10', 5.5, 'Pas intéressant'),
	(2, '2024-01-11', 6.5, 'PAS intéressant');

SELECT * FROM Activite;