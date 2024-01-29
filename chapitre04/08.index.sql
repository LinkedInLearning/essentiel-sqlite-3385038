EXPLAIN QUERY PLAN SELECT 
	ss.mise_a_jour, 
	ss.velos_disponibles, 
	ss.velos_disponibles_calc 
FROM station_information si 
JOIN station_statut ss USING (station_id) 
WHERE si.nom = 'Gare du Nord - Saint-Vincent de Paul';

CREATE INDEX ix_station_information_nom ON station_information (nom);
