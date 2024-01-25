import requests
import sqlite3

# On récupère les informations des stations de Vélib de Paris
url = 'https://velib-metropole-opendata.smovengo.cloud/opendata/Velib_Metropole/gbfs.json'
urls = requests.get(url).json()

# On récupère les URLs qui nous intéressent
for url in urls['data']['en']['feeds']:
    if url['name'] == 'station_information':
        url_stations = url['url']
    if url['name'] == 'station_status':
        url_status = url['url']

# On se connecte à la base de données
cn = sqlite3.connect('velib.sqlite')

# On récupère les données des stations
stations = requests.get(url_stations, headers={'Accept': 'application/json'}).json()

insert = """INSERT INTO station_information
            (station_id, nom, capacite, latitude, longitude) 
            VALUES (?, ?, ?, ?, ?)"""

for station in stations['data']['stations']:
    # print(f"Station {station['station_id']} : {station['name']}")
    # On insère les données dans la base de données
    
    # On utilise la méthode execute() de l'objet cursor pour insérer les données
    # On peut déclarer un objet cursor implicitement sur la connexion.
    cn.execute(insert, (station['station_id'], station['name'], 
        station['capacity'], station['lon'], station['lat']))

cn.commit()