import requests
import sqlite3
from collections import ChainMap

def create_tables():
    cn = sqlite3.connect('velib.sqlite')
    cur = cn.cursor()

    cur.execute("""CREATE TABLE IF NOT EXISTS station_information (
                    station_id int primary key not null,
                    nom text not null,
                    capacite int,
                    latitude real,
                    longitude real
                ) STRICT, WITHOUT ROWID;""")

    cur.execute("""CREATE TABLE IF NOT EXISTS station_statut (
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
                ) STRICT, WITHOUT ROWID;""")

    cn.commit()
    cur.close()
    cn.close()

def get_urls():
    # On récupère les informations des stations de Vélib de Paris
    url = 'https://velib-metropole-opendata.smovengo.cloud/opendata/Velib_Metropole/gbfs.json'
    urls = requests.get(url).json()

    # On récupère les URLs qui nous intéressent
    for url in urls['data']['en']['feeds']:
        if url['name'] == 'station_information':
            url_stations = url['url']
        if url['name'] == 'station_status':
            url_status = url['url']

    return url_stations, url_status

def get_station_information(url_stations):

    # On récupère les données des stations
    stations = requests.get(url_stations, headers={'Accept': 'application/json'}).json()
    lignes = [(s['station_id'], s['name'], s['capacity'], s['lon'], s['lat']) 
            for s in stations['data']['stations']] 

    return lignes

def get_station_status(url_status):
    
    # On récupère les statuts de stations
    statuts = requests.get(url_status, headers={'Accept': 'application/json'}).json()

    lignes = [ (l['station_id'], l['last_reported'], l['is_installed'], l['is_renting'], l['is_returning'], 
                l['numDocksAvailable'], l['mechanical'], l['ebike'], l['numBikesAvailable'] )
        for l in ({**s, **ChainMap(*s['num_bikes_available_types'])} for s in statuts['data']['stations']) ] 

    return lignes

def get_stations():

    url_stations, url_status = get_urls()

    # On se connecte à la base de données
    cn = sqlite3.connect('velib.sqlite')

    lignes = get_station_information(url_stations)

    cur = cn.cursor()

    # On insère les informations de stations dans la base de données
    insert = """INSERT INTO station_information
                (station_id, nom, capacite, latitude, longitude) 
                VALUES (?, ?, ?, ?, ?)
                ON CONFLICT(station_id) DO UPDATE SET
                nom = excluded.nom,
                capacite = excluded.capacite,
                latitude = excluded.latitude,
                longitude = excluded.longitude;"""

    cur.executemany(insert, lignes)
    cn.commit()
    cur.close()

    lignes = get_station_status(url_status)

    # On insère les statuts de stations dans la base de données
    cur = cn.cursor()

    insert = """INSERT OR IGNORE INTO station_statut
                (station_id, mise_a_jour, est_installe, peut_louer, peut_recevoir, bornes_disponibles,
                nb_velos_mecaniques, nb_velos_electriques, velos_disponibles) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);"""

    cur.executemany(insert, lignes)
    cn.commit()
    cur.close()

    cn.close()