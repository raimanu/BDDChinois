DROP TABLE IF EXISTS Familles_de_points CASCADE;
DROP TABLE IF EXISTS Points CASCADE;
DROP TABLE IF EXISTS Localisation CASCADE;
DROP TABLE IF EXISTS Division CASCADE;
DROP TABLE IF EXISTS Situation_anatomique CASCADE;
DROP TABLE IF EXISTS Indications_primaires CASCADE;
DROP TABLE IF EXISTS Indications_secondaires CASCADE;
DROP TABLE IF EXISTS Contre_indications CASCADE;
DROP TABLE IF EXISTS Technique_de_puncture CASCADE;
DROP TABLE IF EXISTS Methode_equilibre CASCADE;
DROP TABLE IF EXISTS Protocoles CASCADE;
DROP TABLE IF EXISTS Efficacite_sur_les_meridiens CASCADE;
DROP TABLE IF EXISTS Remarques CASCADE;
DROP TABLE IF EXISTS Mecanismes CASCADE;
DROP TABLE IF EXISTS Provenance CASCADE;


CREATE TABLE Familles_de_points (
  PRIMARY KEY (id_famille),
  id_famille  INTEGER,
  nom_famille TEXT,
  description TEXT
);

CREATE TABLE Localisation (
  PRIMARY KEY (ID_localisation),
  id_localisation         INTEGER,
  desc_anatomique         VARCHAR(255) NOT NULL,
  langue_localisation     VARCHAR(255),
  image_localisation      TEXT,
  image_ligne_de_puncture TEXT,
  note1                   VARCHAR(255),
  note2                   VARCHAR(255)
);

CREATE TABLE Division (
  PRIMARY KEY (id_division),
  id_division  INTEGER,
  nom_division TEXT
);

CREATE TABLE Situation_anatomique (
  PRIMARY KEY (id_situation),
  id_situation        INTEGER,
  nom_muscles         VARCHAR(50),
  nom_vascularisation VARCHAR(50),
  nom_innervation     VARCHAR(50),
  nom_shengjing       VARCHAR(50)
);

CREATE TABLE Indications_primaires (
  PRIMARY KEY (id_indication_primaire),
  id_indication_primaire    INTEGER,
  nom_indication_primaire   VARCHAR(255),
  texte_indication_primaire TEXT NOT NULL
);

CREATE TABLE Indications_secondaires (
  PRIMARY KEY (id_indication_secondaire),
  id_indication_secondaire    INTEGER,
  nom_indication_secondaire   VARCHAR(255),
  texte_indication_secondaire TEXT
);

CREATE TABLE Contre_indications (
  PRIMARY KEY (id_contre_indication),
  id_contre_indication    INTEGER,
  nom_contre_indication   TEXT,
  texte_contre_indication TEXT
);

CREATE TABLE Technique_de_puncture (
  PRIMARY KEY (id_technique_puncture),
  id_technique_puncture          INTEGER,
  nom_technique_puncture         VARCHAR(100) NOT NULL,
  description_technique_puncture TEXT NOT NULL
);

CREATE TABLE Methode_equilibre (
  PRIMARY KEY (id_methode_equilibre),
  id_methode_equilibre    INTEGER,
  nom_equilibrage         VARCHAR(255),
  description_equilibrage TEXT
);

CREATE TABLE Protocoles (
  PRIMARY KEY (id_protocole),
  id_protocole          INTEGER NOT NULL,
  nom_protocole         VARCHAR(255) NOT NULL,
  description_protocole TEXT
);

CREATE TABLE Efficacite_sur_les_meridiens (
  PRIMARY KEY (id_efficacite),
  id_efficacite INTEGER,
  id_meridien   INTEGER,
  efficacite    TEXT
);

CREATE TABLE Remarques (
  PRIMARY KEY (id_remarque),
  id_remarque      INTEGER,
  nom_remarque     VARCHAR(255),
  contenu_remarque TEXT
);

CREATE TABLE Mecanismes (
  PRIMARY KEY (id_mecanisme),
  id_mecanisme  INTEGER,
  nom_mecanisme VARCHAR(255)
);

CREATE TABLE Provenance (
  PRIMARY KEY (id_provenance),
  id_provenance  INTEGER,
  nom_provenance VARCHAR(255)
);

CREATE TABLE Points (
  PRIMARY KEY (id_point),
  id_point                 SERIAL,
  nom_point                VARCHAR(255) NOT NULL,
  id_famille               INTEGER,
  nom_pinyin_accent        VARCHAR(255),
  nom_pinyin_sans_accent   VARCHAR(255),
  nom_chinois_simplifie    VARCHAR(255) NOT NULL,
  nom_chinois_traditionnel VARCHAR(255),
  nom_francais             VARCHAR(255),
  nom_anglais              VARCHAR(255),
  nom_espagnol             VARCHAR(255),
  utilisation              VARCHAR(255),
  point_nonfixe            BOOLEAN,
  autorisation_saignee     BOOLEAN,
  aiguilles_absolues       BOOLEAN,
  aiguilles_resolution     BOOLEAN,
  point_complet            BOOLEAN,
  id_provenance            INTEGER,
  id_division              INTEGER,
  id_localisation          INTEGER,
  id_mecanisme             INTEGER,
  id_technique_puncture    INTEGER,
  id_protocole             INTEGER,
  id_efficacite            INTEGER,
  id_remarque              INTEGER,
  id_indication_primaire   INTEGER,
  id_indication_secondaire INTEGER,
  id_contre_indication     INTEGER,
  id_situation             INTEGER,
  id_methode_equilibre     INTEGER
);

ALTER TABLE Points ADD FOREIGN KEY (id_indication_primaire) REFERENCES Indications_primaires (id_indication_primaire);
ALTER TABLE Points ADD FOREIGN KEY (id_methode_equilibre) REFERENCES Methode_equilibre (id_methode_equilibre);
ALTER TABLE Points ADD FOREIGN KEY (id_situation) REFERENCES Situation_anatomique (id_situation);
ALTER TABLE Points ADD FOREIGN KEY (id_indication_secondaire) REFERENCES Indications_secondaires (id_indication_secondaire);
ALTER TABLE Points ADD FOREIGN KEY (id_contre_indication) REFERENCES Contre_indications (id_contre_indication);
ALTER TABLE Points ADD FOREIGN KEY (id_remarque) REFERENCES Remarques (id_remarque);
ALTER TABLE Points ADD FOREIGN KEY (id_efficacite) REFERENCES Efficacite_sur_les_meridiens (id_efficacite);
ALTER TABLE Points ADD FOREIGN KEY (id_protocole) REFERENCES Protocoles (id_protocole);
ALTER TABLE Points ADD FOREIGN KEY (id_technique_puncture) REFERENCES Technique_de_puncture (id_technique_puncture);
ALTER TABLE Points ADD FOREIGN KEY (id_mecanisme) REFERENCES Mecanismes (id_mecanisme);
ALTER TABLE Points ADD FOREIGN KEY (id_localisation) REFERENCES Localisation (id_localisation);
ALTER TABLE Points ADD FOREIGN KEY (id_division) REFERENCES Division (id_division);
ALTER TABLE Points ADD FOREIGN KEY (id_provenance) REFERENCES Provenance (id_provenance);
ALTER TABLE Points ADD FOREIGN KEY (id_famille) REFERENCES Familles_de_points (id_famille);

-- Insertion des données
INSERT INTO Familles_de_points (id_famille, nom_famille, description)
VALUES
(1, 'Famille 1', 'Description de la famille 1'),
(2, 'Famille 2', 'Description de la famille 2'),
(3, 'Famille 3', 'Description de la famille 3'),
(4, 'Famille 4', 'Description de la famille 4'),
(5, 'Famille 5', 'Description de la famille 5');

INSERT INTO Localisation (id_localisation, desc_anatomique, langue_localisation, image_localisation, image_ligne_de_puncture, note1, note2)
VALUES
(1, 'Description 1', 'Français', 'image1.png', 'image_ligne1.png', 'Note 1', 'Note 2'),
(2, 'Description 2', 'Français', 'image2.png', 'image_ligne2.png', 'Note 1', 'Note 2'),
(3, 'Description 3', 'Français', 'image3.png', 'image_ligne3.png', 'Note 1', 'Note 2'),
(4, 'Description 4', 'Français', 'image4.png', 'image_ligne4.png', 'Note 1', 'Note 2'),
(5, 'Description 5', 'Français', 'image5.png', 'image_ligne5.png', 'Note 1', 'Note 2');

INSERT INTO Division (id_division, nom_division)
VALUES
(1, 'Division 1'),
(2, 'Division 2'),
(3, 'Division 3'),
(4, 'Division 4'),
(5, 'Division 5');

INSERT INTO Situation_anatomique (id_situation, nom_muscles, nom_vascularisation, nom_innervation, nom_shengjing)
VALUES
(1, 'Muscles 1', 'Vascularisation 1', 'Innervation 1', 'Shengjing 1'),
(2, 'Muscles 2', 'Vascularisation 2', 'Innervation 2', 'Shengjing 2'),
(3, 'Muscles 3', 'Vascularisation 3', 'Innervation 3', 'Shengjing 3'),
(4, 'Muscles 4', 'Vascularisation 4', 'Innervation 4', 'Shengjing 4'),
(5, 'Muscles 5', 'Vascularisation 5', 'Innervation 5', 'Shengjing 5');

INSERT INTO Indications_primaires (id_indication_primaire, nom_indication_primaire, texte_indication_primaire)
VALUES
(1, 'Indication primaire 1', 'Texte de l''indication primaire 1'),
(2, 'Indication primaire 2', 'Texte de l''indication primaire 2'),
(3, 'Indication primaire 3', 'Texte de l''indication primaire 3'),
(4, 'Indication primaire 4', 'Texte de l''indication primaire 4'),
(5, 'Indication primaire 5', 'Texte de l''indication primaire 5');

INSERT INTO Indications_secondaires (id_indication_secondaire, nom_indication_secondaire, texte_indication_secondaire)
VALUES
(1, 'Indication secondaire 1', 'Texte de l''indication secondaire 1'),
(2, 'Indication secondaire 2', 'Texte de l''indication secondaire 2'),
(3, 'Indication secondaire 3', 'Texte de l''indication secondaire 3'),
(4, 'Indication secondaire 4', 'Texte de l''indication secondaire 4'),
(5, 'Indication secondaire 5', 'Texte de l''indication secondaire 5');

INSERT INTO Contre_indications (id_contre_indication, nom_contre_indication, texte_contre_indication)
VALUES
(1, 'Contre-indication 1', 'Texte de la contre-indication 1'),
(2, 'Contre-indication 2', 'Texte de la contre-indication 2'),
(3, 'Contre-indication 3', 'Texte de la contre-indication 3'),
(4, 'Contre-indication 4', 'Texte de la contre-indication 4'),
(5, 'Contre-indication 5', 'Texte de la contre-indication 5');

INSERT INTO Technique_de_puncture (id_technique_puncture, nom_technique_puncture, description_technique_puncture)
VALUES
(1, 'Technique de puncture 1', 'Description de la technique de puncture 1'),
(2, 'Technique de puncture 2', 'Description de la technique de puncture 2'),
(3, 'Technique de puncture 3', 'Description de la technique de puncture 3'),
(4, 'Technique de puncture 4', 'Description de la technique de puncture 4'),
(5, 'Technique de puncture 5', 'Description de la technique de puncture 5');

INSERT INTO Methode_equilibre (id_methode_equilibre, nom_equilibrage, description_equilibrage)
VALUES
(1, 'Méthode d''équilibrage 1', 'Description de la méthode d''équilibrage 1'),
(2, 'Méthode d''équilibrage 2', 'Description de la méthode d''équilibrage 2'),
(3, 'Méthode d''équilibrage 3', 'Description de la méthode d''équilibrage 3'),
(4, 'Méthode d''équilibrage 4', 'Description de la méthode d''équilibrage 4'),
(5, 'Méthode d''équilibrage 5', 'Description de la méthode d''équilibrage 5');

INSERT INTO Protocoles (id_protocole, nom_protocole, description_protocole)
VALUES
(1, 'Protocole 1', 'Description du protocole 1'),
(2, 'Protocole 2', 'Description du protocole 2'),
(3, 'Protocole 3', 'Description du protocole 3'),
(4, 'Protocole 4', 'Description du protocole 4'),
(5, 'Protocole 5', 'Description du protocole 5');

INSERT INTO Efficacite_sur_les_meridiens (id_efficacite, id_meridien, efficacite)
VALUES
(1, 1, 'Efficacité sur le méridien 1'),
(2, 2, 'Efficacité sur le méridien 2'),
(3, 3, 'Efficacité sur le méridien 3'),
(4, 4, 'Efficacité sur le méridien 4'),
(5, 5, 'Efficacité sur le méridien 5');

INSERT INTO Remarques (id_remarque, nom_remarque, contenu_remarque)
VALUES
(1, 'Remarque 1', 'Contenu de la remarque 1'),
(2, 'Remarque 2', 'Contenu de la remarque 2'),
(3, 'Remarque 3', 'Contenu de la remarque 3'),
(4, 'Remarque 4', 'Contenu de la remarque 4'),
(5, 'Remarque 5', 'Contenu de la remarque 5');

INSERT INTO Mecanismes (id_mecanisme, nom_mecanisme)
VALUES
(1, 'Mécanisme 1'),
(2, 'Mécanisme 2'),
(3, 'Mécanisme 3'),
(4, 'Mécanisme 4'),
(5, 'Mécanisme 5');

INSERT INTO Provenance (id_provenance, nom_provenance)
VALUES
(1, 'Provenance 1'),
(2, 'Provenance 2'),
(3, 'Provenance 3'),
(4, 'Provenance 4'),
(5, 'Provenance 5');

-- Insertion de données dans la table Points (Id_point étant auto-incrémenté, il n'est pas nécessaire de le spécifier)
INSERT INTO Points (nom_point, id_famille, nom_pinyin_accent, nom_pinyin_sans_accent, nom_chinois_simplifie, nom_chinois_traditionnel, nom_francais, nom_anglais, nom_espagnol, utilisation, point_nonfixe, autorisation_saignee, aiguilles_absolues, aiguilles_resolution, point_complet, id_provenance, id_division, id_localisation, id_mecanisme, id_technique_puncture, id_protocole, id_efficacite, id_remarque, id_indication_primaire, id_indication_secondaire, id_contre_indication, id_situation, id_methode_equilibre)
VALUES
('Point 1', 1, 'Pinyin accent 1', 'Pinyin sans accent 1', 'Chinois simplifié 1', 'Chinois traditionnel 1', 'Français 1', 'Anglais 1', 'Espagnol 1', 'Utilisation 1', TRUE, TRUE, TRUE, TRUE, TRUE, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
('Point 2', 2, 'Pinyin accent 2', 'Pinyin sans accent 2', 'Chinois simplifié 2', 'Chinois traditionnel 2', 'Français 2', 'Anglais 2', 'Espagnol 2', 'Utilisation 2', TRUE, TRUE, TRUE, TRUE, TRUE, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2),
('Point 3', 3, 'Pinyin accent 3', 'Pinyin sans accent 3', 'Chinois simplifié 3', 'Chinois traditionnel 3', 'Français 3', 'Anglais 3', 'Espagnol 3', 'Utilisation 3', TRUE, TRUE, TRUE, TRUE, TRUE, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
('Point 4', 4, 'Pinyin accent 4', 'Pinyin sans accent 4', 'Chinois simplifié 4', 'Chinois traditionnel 4', 'Français 4', 'Anglais 4', 'Espagnol 4', 'Utilisation 4', TRUE, TRUE, TRUE, TRUE, TRUE, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4),
('Point 5', 5, 'Pinyin accent 5', 'Pinyin sans accent 5', 'Chinois simplifié 5', 'Chinois traditionnel 5', 'Français 5', 'Anglais 5', 'Espagnol 5', 'Utilisation 5', TRUE, TRUE, TRUE, TRUE, TRUE, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5);
