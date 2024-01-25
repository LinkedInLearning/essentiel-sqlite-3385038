CREATE TABLE IF NOT EXISTS Formation (
	FormationId INTEGER PRIMARY KEY,
	Nom
);

INSERT INTO Formation (Nom) VALUES ('SQLite');
INSERT INTO Formation (Nom) VALUES ('Python');

SELECT * FROM Formation;

DROP TABLE Formation;