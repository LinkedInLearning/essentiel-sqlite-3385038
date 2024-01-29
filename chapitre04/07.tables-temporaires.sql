CREATE TEMPORARY TABLE t1
AS
SELECT 
	ss.station_id,
	STRFTIME('%Y-%m-%d %H:%M', ss.mise_a_jour, 'unixepoch') as maj,
	ss.mise_a_jour,
	ss.velos_disponibles
FROM station_statut ss;

SELECT *
FROM t1;




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



