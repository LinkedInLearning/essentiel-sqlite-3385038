SELECT 
	ss.mise_a_jour, 
	datetime(ss.mise_a_jour, 'unixepoch') as maj,
	ss.velos_disponibles, 
	ss.velos_disponibles_calc 
FROM station_information si 
JOIN station_statut ss USING (station_id) 
WHERE si.nom = 'Gare du Nord - Saint-Vincent de Paul';

SELECT 
	STRFTIME('%Y-%m-%d %H:%M', ss.mise_a_jour, 'unixepoch') as minute, 
	SUM(ss.velos_disponibles) as velos_disponibles, 
	COUNT(DISTINCT ss.station_id) as stations,
	si.nom
FROM station_information si 
JOIN station_statut ss USING (station_id) 
GROUP BY STRFTIME('%Y-%m-%d %H:%M', ss.mise_a_jour, 'unixepoch')
HAVING COUNT(DISTINCT ss.station_id) > 1;
