SELECT 
	STRFTIME('%Y-%m-%d %H:%M', ss.mise_a_jour, 'unixepoch') as minute, 
	SUM(ss.velos_disponibles) as velos_disponibles, 
	COUNT(DISTINCT ss.station_id) as stations,
	si.nom
FROM station_information si 
JOIN station_statut ss USING (station_id) 
GROUP BY STRFTIME('%Y-%m-%d %H:%M', ss.mise_a_jour, 'unixepoch')
HAVING COUNT(DISTINCT ss.station_id) > 1;

WITH cte1 AS (
	SELECT 
		ss.station_id,
		STRFTIME('%Y-%m-%d %H:%M', ss.mise_a_jour, 'unixepoch') as maj,
		ss.mise_a_jour,
		ss.velos_disponibles
	FROM station_statut ss  
), 
cte2 AS (
	SELECT
		maj,
		velos_disponibles,
		ROW_NUMBER() OVER (PARTITION BY station_id, maj ORDER BY mise_a_jour DESC) as rn
	FROM cte1
)
SELECT
	maj,
	SUM(velos_disponibles)
FROM cte2
WHERE rn = 1
GROUP BY maj
HAVING SUM(velos_disponibles) > 0
ORDER BY maj;

