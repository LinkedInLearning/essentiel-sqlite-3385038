CREATE TABLE Activite 
(
    ActiviteId INTEGER PRIMARY KEY,
    Type,
    Date,
    Prix
);

INSERT INTO Activite (Type, Date, Prix)
VALUES (1, '2024-01-24', 100),
       ('Fête', '2024-01-24', '100'),
       ('Bêtise', '24/01/2024', 1.50);

SELECT *, strftime( '%Y', Date)
FROM Activite;

DROP TABLE Activite;

CREATE TABLE Activite 
(
    ActiviteId INTEGER PRIMARY KEY,
    Type tinyint,
    Date date,
    Prix decimal(10, 2)
);

INSERT INTO Activite (Type, Date, Prix)
VALUES (1, '2024-01-24', 100),
       ('Fête', '2024-01-24', '100'),
       ('Bêtise', '24/01/2024', 1.50);

SELECT *, strftime( '%Y', Date)
FROM Activite;

SELECT 
	typeof(Type) as typeof_type,
	typeof(Date) as typeof_date,
	typeof(Prix) as typeof_Prix
FROM Activite;

INSERT INTO Activite (Type, Date, Prix)
VALUES ('2', '2024-01-24', '12.7');

DROP TABLE Activite;

CREATE TABLE Activite 
(
    ActiviteId INTEGER PRIMARY KEY,
    Type integer,
    Date text,
    Prix real
) STRICT;

INSERT INTO Activite (Type, Date, Prix)
VALUES (1, '2024-01-24', 100),
       ('Fête', '2024-01-24', '100'),
       ('Bêtise', '24/01/2024', 1.50);


CREATE TABLE attribut(name TEXT PRIMARY KEY, value) WITHOUT ROWID;