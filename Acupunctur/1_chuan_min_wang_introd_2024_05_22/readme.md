# Fichiers finaux :
## Requêtes SQL
| Fichier | Description |
|---------|-------------|
|**1_bdd_one.sql** | permet la création du schéma de base de données. 'one' fait référence au fait qu'elle ne permet qu'un seul livre par point, ce qui facilitera le traitement sur la base de données (déduplication des lignes, calcul, ...) Pour la version final il faudra juste passer sur la version de base de données qui permet plusieurs livres par points d'acupunctur. 
|**2_meridiens.sql** | permet la création des méridiens en bdd. Ce fichier est distinct car il a était modifier à la main pour être nettoyé afin d'éviter des doublons inutiles (espace en plus, ...) en base.
|**3_inserts.sql** | permet l'insertion des données en base.
|**4_attentions_a_ne_pas_oublier.sql** | permet de s'assurrer qu'aucune indication n'est orpheline, le cas contraire serais anormale.
|**all.sql** | regroupe toutes les requêtes précédentes.

Ces requêtes sont à exécuter manuellement dans le SGBD PostgreSQL une fois la base de données créé manuellement. Je conseille d'exécuter que `all.sql` car moins d'action nécessaire, ce fichier a été créé manuellement alimenté par le résultat du script `3_inserts.py`, fichier `meridiens.sql` et du fichier `1_bdd_one.sql`.

## Autres
| Fichier | Description |
|---------|-------------|
|**la video .mp4** | vidéo permettant de retracer la création de la pluspart des requêts SQL (orientées DEV pas forcément client car difficilement compréhensible). 
|**INFOS_-_Chuan_Min_Wang_-_Introd_2024_05_22.xlsx** | copie renommé (avant out_clean.xlsx) du fichier de données final utilisé pour créer les requêtes SQL, princpalement par `3_inserts.py`. 

---
# Fichier développement *(dossier script)*
## Processus
- Livre Google Drive en .DOCX (microsoft word)
- Transformer en Google Docs (ouvrir et convertir) (car GAS ne peux pas traiter les documents Word)
- Depuis le Google sheets servant de table de stockage, executer le google apps script lié (Google Sheets > Extensions > Apps Script)
- Copier coller le code de `0_googleAppsScript.gs` dans l'ide. Modifier l'id du document source (visible dans l'url du fichier voulu) et exécuter le script
- Télécharger sous forme `.xlsx` le résultat stocké sur Google Sheets
- Disposer le classeur `répertoire_des_scripts/data/extract_script_clean.xlsx`
- Executer le script `1_script_v3.py` celui-ci executera automatiquement le script suivant `2_clean.py`
- `out_clean.xlsx` Corriger les quelques erreurs de données restantes du fichier de sortie 
- `out_clean.xlsx` Récupérer tous les méridiens et les insérer en base (c'est le fichier `2_meridiens.sql`).
- `3_inserts.py` exécuter comme dans la `vidéo`

Pour d'autres détails *cf.readme_image_process.png* [source](https://docs.google.com/spreadsheets/d/1HOMi9Tfg3Wy1a4YgPg2GUHa_Dr7x0E1g5d1SJFqfwEA/edit?gid=1265677031#gid=1265677031) 

## Fichier
| Fichier | entrée | sortie | Description | colonnes |
|---------|----------------|----------------|-------------|----------|
|**0_googleAppsScript (sous Google Sheets)** | id de livre spécifié dans le script | feuille au nom du fichier d'entrée (à exporter) | Premier script exécuté, récupère les noms des [Point] avec leurs contenu [texte] Point est le délimiteur et Texte le contenu de se point. |2 [ Point , Texte ]
|**1_script_v3.py** | data/extract_script_clean.xlsx (export_depuis_google_sheets) | out.xlsx | Décompile la colonne Texte parmis les 2 colonnes en entrée en autant de colonne qu'il peut décompiler tout en se limitant aux clés (Indication, Meridien, ...) répertorié dans le script > variable `allowed_keys`. | 2 + Autant qu'il y en a [Point, Texte, Localisation, ...]
|**2_clean.py** | out.xlsx | out_clean.xlsx | Transforme les données, exemple regrouper des colonnes de mêmes sens mais orthographié différement, ... | 2 + les précèdentes - celles fusionnées
|**3_inserts.py** | out_clean.xlsx + ses corrections manuel | inserts.sql | Génère les requêtes contenant les données à insérer en base | 
|**mapping.json** |  |  | Utilisé par `3_inserts.py`. Permet de donner la correspondance [ nom_attribut_livre_dans_excel ] et [ nom_attribut_bdd ] et également dans quel [ table_bdd ]


# Points d'amélioration
- Transférer le process de Google Apps Script dans le script python 1_script*.py faire sur un script python
- Récupérer les images également (fonctionne sur Google Apps Script)
- Simplifier le processus pour l'intégration en base, stocker tous les points dans un fichier Excel contenant tous les attributs nécessaire afin de faire l'intégration en BDD qu'une seul fois.


# Lien entre les BDD
Raimanu avait proposé de lier les bases Acupunctur et Plantes sur l'attribut Indication, ce qui à première vue paraît très bien.

# Interface base de données
Avec Microsoft Access on peux utiliser un connecteur ODBC PostgreSQL facilement pour synchroniser l'état visible dans Access et la base de données.
Je pense qu'il serait plus facile et rapide d'utiliser cette solution en dépit de codage.
En effet, les besoins ne sont pas très elevé sur cette partie et MS Access dispose déjà de formulaire et de tout un fonctionnement conçu dans le but.
- Il faut mettre en place un formulaire permettant la consultation et l'insertion manuel des données. 

# Application
L'utilisation de Unity semble une bonne solution.
Je pense que cela nécessitera d'ajouter des attributs en base de données pour cette application afin qu'elle puisse attribuer à une coordonnée du modèle 3D un point d'acupunctur.