import sqlite3
import mysql.connector

# se connecter à une base de données serveur MySQL
cn_mysql = mysql.connector.connect(
    host="localhost",
    user="root",
    password=""
)

# se connecter à une base de données SQLite
cn_sqlite = sqlite3.connect("2024.01.sqlite")