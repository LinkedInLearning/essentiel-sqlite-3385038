import sqlite3
from datetime import date
from pathlib import Path

print(Path.cwd())

# on ouvre la base de données
cn = sqlite3.connect('./pachadataformation.sqlite')

# on crée une sauvegarde
destination = f'./pachadataformation.{date.today().strftime("%Y.%m.%d")}.sql'

with open(destination, 'w') as f:
    for ligne in cn.iterdump():
        f.write('%s\n' % ligne)

cn.close()