DROP TABLE IF EXISTS Activite; 

CREATE TABLE IF NOT EXISTS Activite 
(
    ActiviteId INTEGER PRIMARY KEY,
    Type integer CHECK (Type BETWEEN 1 AND 5),
    Date text UNIQUE, -- ON CONFLICT REPLACE,
    Prix real NOT NULL CHECK (Prix > 0),
    Description text COLLATE NOCASE
) STRICT;

INSERT INTO Activite (Type, Date, Prix, Description)
VALUES (3, '2024-01-10', 1, 'Très intéressant');

INSERT OR REPLACE INTO Activite (Type, Date, Prix, Description)
VALUES (1, '2024-01-10', 5.5, 'Pas intéressant');

INSERT OR IGNORE INTO Activite (Type, Date, Prix, Description)
VALUES (1, '2024-01-10', 10.5, 'Pas intéressant');

UPDATE OR IGNORE Activite 
SET Type = 10;

SELECT * FROM Activite;