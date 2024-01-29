SELECT
	datetime(ss.mise_a_jour, 'unixepoch') as maj,
	*
FROM station_statut ss 
WHERE UNIXEPOCH('now') - ss.mise_a_jour > 60*60*48;

DELETE 
FROM station_statut
WHERE UNIXEPOCH('now') - mise_a_jour > 60*60*48;