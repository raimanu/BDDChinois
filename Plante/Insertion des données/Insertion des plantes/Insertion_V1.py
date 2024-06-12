# Importer les modules nécessaires
import pandas as pd
import psycopg2 as mysql

# Fonction pour se connecter à une base de données PSQL avec le port 5042
def connectDB(host, user, password, database):
    # Se connecter à la base de données
    try:
        print("Connection à la base de donnée effectué")
        connection = mysql.connect(host=host, user=user, password=password, database=database, port=5432)
        print("Connection à la base de donnée réussie")
        return connection
    except mysql.Error as e:
        print(f"Error connecting to the database: {e}")
        return None

# # Fonction pour lire un fichier CSV
def readCSV(path):
    try:
        fichier = pd.read_csv(path, dtype=str, skip_blank_lines=True)
        return fichier
    except FileNotFoundError as e:
        print(f"Error reading the file: {e}")
        return None
    
# Fonction permettant de récupérer les données pour la table département
def dataDescription(fichier):
    try:
        fichier = fichier.iloc[:, [1, 8]]
        fichier = fichier.copy()
        return fichier
    except Exception as e:
        print(f"Error getting the columns: {e}")
        return None
    
# Fonction pour insérer les données de la table departement dans la base de données
def insertDescriptionData(df, connection):
    try:
        cursor = connection.cursor()
        data_to_insert = []
        for index, row in df.iterrows():
            Partie_Utile = str(row[0])  
            Preparations = str(row[1]) 
            data_to_insert.append((Partie_Utile, Preparations))
        cursor.executemany("""
            INSERT INTO Description (Partie_Utile, Preparations)
            VALUES (%s, %s)
            """, data_to_insert)
        cursor.execute("""UPDATE description SET Preparations = 'nan' WHERE Preparations = 'NaN';""")
        connection.commit()
        cursor.close()
    except Exception as e:
        print(f"Error inserting the data Description : {e}")

# Initialisation de la base de donnée et insertion des données dans les tables
connection = connectDB("localhost", "postgres", "postgres", "plantes")
insertDescriptionData(dataDescription(readCSV("plantes.csv")), connection)
if connection:
    connection.close()