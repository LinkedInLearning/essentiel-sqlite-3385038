SELECT 
	ss.mise_a_jour, 
	ss.velos_disponibles, 
	ss.velos_disponibles_calc 
FROM station_information si 
JOIN station_statut ss USING (station_id) 
WHERE si.nom = 'Gare du Nord - Saint-Vincent de Paul';

SELECT DATETIME('now'), CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP; 
SELECT UNIXEPOCH('now');