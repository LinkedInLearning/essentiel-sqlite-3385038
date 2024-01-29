import sqlite3

# On se connecte à la base de données
cn = sqlite3.connect('velib.sqlite')
cn.enable_load_extension(True)
cn.load_extension('c:/Users/linkedin/Documents/git/essentiel-sqlite-3385038/sqlean/sqlean')

sql = """SELECT *
         FROM station_information
         WHERE nom REGEXP ?;"""

cur = cn.cursor()

resultat = cur.execute(sql, ['.*Nord$'])

for r in resultat:
    print (r[1])

cur.close();
cn.close();