CREATE TABLE IF NOT EXISTS station_information
(
	station_id int primary key not null,
	nom text not null,
	capacite int,
	latitude real,
	longitude real
) STRICT, WITHOUT ROWID;	

CREATE TABLE IF NOT EXISTS station_statut
(
	station_id int not null,
	mise_a_jour int not null,
	est_installe int not null default 0,	
	peut_louer int not null default 0,
	peut_recevoir int not null default 0,
	bornes_disponibles int not null default 0,
	nb_velos_mecaniques int not null default 0,
	nb_velos_electriques int not null default 0,
	velos_disponibles int not null default 0,
	velos_disponibles_calc int GENERATED ALWAYS AS (nb_velos_mecaniques + nb_velos_electriques) VIRTUAL,
	PRIMARY KEY (station_id, mise_a_jour),
	FOREIGN KEY (station_id)
		REFERENCES station_information (station_id)
) STRICT, WITHOUT ROWID;	
