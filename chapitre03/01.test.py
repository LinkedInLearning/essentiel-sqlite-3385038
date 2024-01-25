import requests

##########################################################################
# On récupère les informations des stations de Vélib de Paris
# 
# Le format un JSON qui correspond au GBFS, ou 
# General Bikeshare Feed Specification. 
# Une spécification de données ouvertes pour les vélos en libre service. 
# GBFS permet d'obtenir des informations en temps réel.
##########################################################################
url = 'https://velib-metropole-opendata.smovengo.cloud/opendata/Velib_Metropole/gbfs.json'
urls = requests.get(url).json()

# On récupère les URLs qui nous intéressent
for url in urls['data']['en']['feeds']:
    if url['name'] == 'station_information':
        url_stations = url['url']
    if url['name'] == 'station_status':
        url_status = url['url']


# On récupère les données des stations

stations = requests.get(url_stations, headers={'Accept': 'application/json'}).json()

for station in stations['data']['stations']:
    print(f"Station {station['station_id']} : {station['name']}")


# On récupère les statuts des stations

statuts = requests.get(url_status, headers={'Accept': 'application/json'}).json()

print(f"{statuts.keys()}")

for station in statuts['data']['stations']:
    print(f"Station {station['station_id']} : {station['num_bikes_available']} vélo(s) disponible(s)")
