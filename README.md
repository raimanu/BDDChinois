**Requirements :**
Pour travailler sur la base de données, il faut installer les outils suivants :
- Python https://www.python.org/downloads/
- Module Python : CSV, DOCX, PANDAS, PSYCOPG2
- Postgresql https://www.enterprisedb.com/downloads/postgres-postgresql-downloads

Dans un terminal, après vous être placé dans le dossier du projet,  installer les requirements avec cette commande : 
```py
pip install -r requirements.txt
```

**Pour la base de donnée :**
Après avoir téléchargé PostgreSQL via le lien et l'avoir installé, 
il est inutile d'installer les packages supplémentaires proposés, car nous ne les utiliserons pas et cela ralentit l'installation.

Pour utiliser PostgreSQL, ouvrez l'application pgAdmin. 
Vous devrez alors créer un utilisateur et définir un mot de passe.

Une fois cette étape accomplie, vous pouvez créer votre base de données :
- Faites un clic droit sur "Base de données" => "Créer" => "Base de données".
- Donnez un nom à votre base de données et cliquez sur "Enregistrer" en bas de la fenêtre.

Ensuite, faites un clic droit sur la base de données nouvellement créée et sélectionnez "Éditeur de requête". 
Éditeur de requête permet de lancer des scripts SQL sur votre base de données, et ainsi créer des tables, insérer des données ou encore faire des recherches.

Sur la nouvelle page, copiez et collez le contenu du fichier **"CodeSqlTung.psql"** qui se trouve dans le dossier **“bdd/BddTung”**, puis cliquez sur le bouton "Exécuter" qui ressemble à ">" ou appuyez sur F5. 
Votre base de données des points d’acupuncture est maintenant créée.

Pour la base de donnée des plantes, copier et coller le contenue du fichier **“CodeSqlPlante.psql”** qui se trouve dans le dossier **“bdd/BddPlante"** puis cliquez sur le bouton "Exécuter" qui ressemble à ">" ou appuyez sur F5.
Votre base de données des plantes est maintenant créée.

Création des données :

Une fois la base de données créée, on va pouvoir insérer les données dans les bases de données.

Pour la base de données Acupuncture se référer au readme.md ou readme.pdf dans le dossier Acupuncture.

Pour la base de données des plantes :
- Aller dans le fichier Plante ⇒ Extraction des données et exécuter le fichier “Extraction COMPLET - Les herbes communes - P Sterckx.py”
- L’exécution du fichier va créer un fichier csv ou le mettre à jour s’il existe déjà dans le projet.
- Pour la partie insertion on réutiliser le fichier csv créé précédemment, malheureusement l’insertion n’a pas pu être finalisé mais on peut tout de même essayer de l’exécuter même si cela ne va pas faire grand chose.
- Aller dans le fichier Plante ⇒ Insertion des données et exécuter le fichier “InsertionV1.py”


