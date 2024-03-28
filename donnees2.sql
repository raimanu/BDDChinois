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

-- Insertion des données pour Familles_de_points
INSERT INTO Familles_de_points (id_famille, nom_famille, description)
VALUES
(1, 'Points d''acupuncture', 'Famille de points d''acupuncture généraux'),
(2, 'Points de tonification', 'Famille de points utilisés pour la tonification'),
(3, 'Points de dispersion', 'Famille de points utilisés pour la dispersion'),
(4, 'Points pour la douleur', 'Famille de points utilisés pour le soulagement de la douleur'),
(5, 'Points spécifiques', 'Famille de points utilisés pour des indications spécifiques');

-- Insertion des données pour Localisation
INSERT INTO Localisation (id_localisation, desc_anatomique, langue_localisation, image_localisation, image_ligne_de_puncture, note1, note2)
VALUES
(1, 'Bras', 'Français', 'bras.png', 'ligne_puncture_bras.png', 'Note sur la localisation du bras', 'Autre note sur la localisation'),
(2, 'Jambe', 'Français', 'jambe.png', 'ligne_puncture_jambe.png', 'Note sur la localisation de la jambe', 'Autre note sur la localisation'),
(3, 'Dos', 'Français', 'dos.png', 'ligne_puncture_dos.png', 'Note sur la localisation du dos', 'Autre note sur la localisation'),
(4, 'Tête', 'Français', 'tete.png', 'ligne_puncture_tete.png', 'Note sur la localisation de la tête', 'Autre note sur la localisation'),
(5, 'Tronc', 'Français', 'tronc.png', 'ligne_puncture_tronc.png', 'Note sur la localisation du tronc', 'Autre note sur la localisation');

-- Insertion des données pour Division
INSERT INTO Division (id_division, nom_division)
VALUES
(1, 'Supérieure'),
(2, 'Moyenne'),
(3, 'Inférieure'),
(4, 'Antérieure'),
(5, 'Postérieure');

-- Insertion des données pour Situation_anatomique
INSERT INTO Situation_anatomique (id_situation, nom_muscles, nom_vascularisation, nom_innervation, nom_shengjing)
VALUES
(1, 'Biceps', 'Artère brachiale', 'Nerf musculo-cutané', 'Méridien du Cœur'),
(2, 'Quadriceps', 'Artère fémorale', 'Nerf fémoral', 'Méridien de la Rate'),
(3, 'Dorsaux', 'Artère thoracique postérieure', 'Nerf dorsal', 'Méridien du Rein'),
(4, 'Trapèzes', 'Artère subclavière', 'Nerf spinal', 'Méridien de la Vessie'),
(5, 'Pectoraux', 'Artère thoracique interne', 'Nerf intercostal', 'Méridien du Poumon');

-- Insertion des données pour Indications_primaires
INSERT INTO Indications_primaires (id_indication_primaire, nom_indication_primaire, texte_indication_primaire)
VALUES
(1, 'Douleur', 'Indication principale pour le soulagement de la douleur'),
(2, 'Inflammation', 'Indication principale pour le traitement des inflammations'),
(3, 'Fatigue', 'Indication principale pour le traitement de la fatigue'),
(4, 'Stress', 'Indication principale pour la réduction du stress'),
(5, 'Insomnie', 'Indication principale pour le traitement de l''insomnie');

-- Insertion des données pour Indications_secondaires
INSERT INTO Indications_secondaires (id_indication_secondaire, nom_indication_secondaire, texte_indication_secondaire)
VALUES
(1, 'Anxiété', 'Indication secondaire pour le traitement de l''anxiété'),
(2, 'Dépression', 'Indication secondaire pour le traitement de la dépression'),
(3, 'Hypertension', 'Indication secondaire pour le traitement de l''hypertension'),
(4, 'Nausée', 'Indication secondaire pour le traitement des nausées'),
(5, 'Problèmes digestifs', 'Indication secondaire pour le traitement des problèmes digestifs');

-- Insertion des données pour Contre_indications
INSERT INTO Contre_indications (id_contre_indication, nom_contre_indication, texte_contre_indication)
VALUES
(1, 'Grossesse', 'Contre-indication en cas de grossesse'),
(2, 'Hémorragie', 'Contre-indication en cas d''hémorragie sévère'),
(3, 'Troubles de la coagulation', 'Contre-indication en cas de troubles de la coagulation'),
(4, 'Infection locale', 'Contre-indication en cas d''infection locale'),
(5, 'Troubles cardiaques', 'Contre-indication en cas de troubles cardiaques sévères');

-- Insertion des données pour Technique_de_puncture
INSERT INTO Technique_de_puncture (id_technique_puncture, nom_technique_puncture, description_technique_puncture)
VALUES
(1, 'Puncture superficielle', 'Technique de puncture peu profonde'),
(2, 'Puncture en oblique', 'Technique de puncture à un angle oblique'),
(3, 'Puncture rapide', 'Technique de puncture rapide'),
(4, 'Puncture tonifiante', 'Technique de puncture pour la tonification'),
(5, 'Puncture dispersante', 'Technique de puncture pour la dispersion');

-- Insertion des données pour Methode_equilibre
INSERT INTO Methode_equilibre (id_methode_equilibre, nom_equilibrage, description_equilibrage)
VALUES
(1, 'Harmonisation des énergies', 'Méthode visant à harmoniser les énergies du corps'),
(2, 'Renforcement du Yin', 'Méthode pour renforcer l''aspect Yin de l''organisme'),
(3, 'Renforcement du Yang', 'Méthode pour renforcer l''aspect Yang de l''organisme'),
(4, 'Équilibrage des méridiens', 'Méthode visant à équilibrer les méridiens du corps'),
(5, 'Stimulation des points Shu', 'Méthode de stimulation des points Shu antiques');

-- Insertion des données pour Protocoles
INSERT INTO Protocoles (id_protocole, nom_protocole, description_protocole)
VALUES
(1, 'Protocole de base', 'Protocole standard pour un traitement d''acupuncture'),
(2, 'Protocole de relaxation', 'Protocole pour la relaxation et le bien-être'),
(3, 'Protocole anti-douleur', 'Protocole spécifique pour le soulagement de la douleur'),
(4, 'Protocole énergétique', 'Protocole pour l''équilibre énergétique'),
(5, 'Protocole de tonification', 'Protocole pour la tonification générale');

-- Insertion des données pour Efficacite_sur_les_meridiens
INSERT INTO Efficacite_sur_les_meridiens (id_efficacite, id_meridien, efficacite)
VALUES
(1, 1, 'Efficacité sur le méridien du Cœur'),
(2, 2, 'Efficacité sur le méridien de la Rate'),
(3, 3, 'Efficacité sur le méridien du Rein'),
(4, 4, 'Efficacité sur le méridien de la Vessie'),
(5, 5, 'Efficacité sur le méridien du Poumon');

-- Insertion des données pour Remarques
INSERT INTO Remarques (id_remarque, nom_remarque, contenu_remarque)
VALUES
(1, 'Remarque sur le point 1', 'Contenu de la remarque sur le point 1'),
(2, 'Remarque sur le point 2', 'Contenu de la remarque sur le point 2'),
(3, 'Remarque sur le point 3', 'Contenu de la remarque sur le point 3'),
(4, 'Remarque sur le point 4', 'Contenu de la remarque sur le point 4'),
(5, 'Remarque sur le point 5', 'Contenu de la remarque sur le point 5');

-- Insertion des données pour Mecanismes
INSERT INTO Mecanismes (id_mecanisme, nom_mecanisme)
VALUES
(1, 'Mécanisme 1'),
(2, 'Mécanisme 2'),
(3, 'Mécanisme 3'),
(4, 'Mécanisme 4'),
(5, 'Mécanisme 5');

-- Insertion des données pour Provenance
INSERT INTO Provenance (id_provenance, nom_provenance)
VALUES
(1, 'Provenance 1'),
(2, 'Provenance 2'),
(3, 'Provenance 3'),
(4, 'Provenance 4'),
(5, 'Provenance 5');

-- Insertion des données pour Points
INSERT INTO Points (
  nom_point, id_famille, nom_pinyin_accent, nom_pinyin_sans_accent, nom_chinois_simplifie, nom_chinois_traditionnel, nom_francais, nom_anglais, nom_espagnol, 
  utilisation, point_nonfixe, autorisation_saignee, aiguilles_absolues, aiguilles_resolution, point_complet, id_provenance, id_division, id_localisation, id_mecanisme, 
  id_technique_puncture, id_protocole, id_efficacite, id_remarque, id_indication_primaire, id_indication_secondaire, id_contre_indication, id_situation, id_methode_equilibre
)
VALUES
('Point 1', 1, 'Pinyin accent 1', 'Pinyin sans accent 1', 'Chinois simplifié 1', 'Chinois traditionnel 1', 'Français 1', 'Anglais 1', 'Espagnol 1', 
 'Utilisation 1', TRUE, TRUE, TRUE, TRUE, TRUE, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
('Point 2', 2, 'Pinyin accent 2', 'Pinyin sans accent 2', 'Chinois simplifié 2', 'Chinois traditionnel 2', 'Français 2', 'Anglais 2', 'Espagnol 2', 
 'Utilisation 2', TRUE, TRUE, TRUE, TRUE, TRUE, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2),
('Point 3', 3, 'Pinyin accent 3', 'Pinyin sans accent 3', 'Chinois simplifié 3', 'Chinois traditionnel 3', 'Français 3', 'Anglais 3', 'Espagnol 3', 
 'Utilisation 3', TRUE, TRUE, TRUE, TRUE, TRUE, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
('Point 4', 4, 'Pinyin accent 4', 'Pinyin sans accent 4', 'Chinois simplifié 4', 'Chinois traditionnel 4', 'Français 4', 'Anglais 4', 'Espagnol 4', 
 'Utilisation 4', TRUE, TRUE, TRUE, TRUE, TRUE, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4),
('Point 5', 5, 'Pinyin accent 5', 'Pinyin sans accent 5', 'Chinois simplifié 5', 'Chinois traditionnel 5', 'Français 5', 'Anglais 5', 'Espagnol 5', 
 'Utilisation 5', TRUE, TRUE, TRUE, TRUE, TRUE, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5),
('Point 6', 1, 'Pinyin accent 6', 'Pinyin sans accent 6', 'Chinois simplifié 6', 'Chinois traditionnel 6', 'Français 6', 'Anglais 6', 'Espagnol 6', 
 'Utilisation 6', FALSE, TRUE, TRUE, FALSE, FALSE, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),
('Point 7', 2, 'Pinyin accent 7', 'Pinyin sans accent 7', 'Chinois simplifié 7', 'Chinois traditionnel 7', 'Français 7', 'Anglais 7', 'Espagnol 7', 
 'Utilisation 7', TRUE, FALSE, FALSE, TRUE, TRUE, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2),
('Point 8', 3, 'Pinyin accent 8', 'Pinyin sans accent 8', 'Chinois simplifié 8', 'Chinois traditionnel 8', 'Français 8', 'Anglais 8', 'Espagnol 8', 
 'Utilisation 8', TRUE, TRUE, FALSE, FALSE, FALSE, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3),
('Point 9', 4, 'Pinyin accent 9', 'Pinyin sans accent 9', 'Chinois simplifié 9', 'Chinois traditionnel 9', 'Français 9', 'Anglais 9', 'Espagnol 9', 
 'Utilisation 9', FALSE, FALSE, TRUE, TRUE, FALSE, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4),
('Point 10', 5, 'Pinyin accent 10', 'Pinyin sans accent 10', 'Chinois simplifié 10', 'Chinois traditionnel 10', 'Français 10', 'Anglais 10', 'Espagnol 10', 
 'Utilisation 10', TRUE, FALSE, TRUE, FALSE, TRUE, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5),
 ('Point 11', 3, 'Pinyin accent 11', 'Pinyin sans accent 11', 'Chinois simplifié 11', 'Chinois traditionnel 11', 'Français 11', 'Anglais 11', 'Espagnol 11', 
 'Utilisation 11', TRUE, TRUE, TRUE, FALSE, FALSE, 2, 2, 1, 3, 1, 1, 2, 1, 1, 1, 1, 1, 1),
('Point 12', 4, 'Pinyin accent 12', 'Pinyin sans accent 12', 'Chinois simplifié 12', 'Chinois traditionnel 12', 'Français 12', 'Anglais 12', 'Espagnol 12', 
 'Utilisation 12', FALSE, FALSE, TRUE, TRUE, TRUE, 3, 3, 2, 4, 2, 2, 3, 2, 2, 2, 2, 2, 3),
('Point 13', 5, 'Pinyin accent 13', 'Pinyin sans accent 13', 'Chinois simplifié 13', 'Chinois traditionnel 13', 'Français 13', 'Anglais 13', 'Espagnol 13', 
 'Utilisation 13', TRUE, TRUE, FALSE, TRUE, FALSE, 4, 4, 3, 5, 3, 3, 4, 3, 3, 3, 3, 3, 4),
('Point 14', 1, 'Pinyin accent 14', 'Pinyin sans accent 14', 'Chinois simplifié 14', 'Chinois traditionnel 14', 'Français 14', 'Anglais 14', 'Espagnol 14', 
 'Utilisation 14', FALSE, TRUE, FALSE, FALSE, TRUE, 5, 5, 4, 1, 4, 4, 5, 4, 4, 4, 4, 4, 2),
('Point 15', 2, 'Pinyin accent 15', 'Pinyin sans accent 15', 'Chinois simplifié 15', 'Chinois traditionnel 15', 'Français 15', 'Anglais 15', 'Espagnol 15', 
 'Utilisation 15', TRUE, FALSE, TRUE, FALSE, TRUE, 1, 1, 5, 2, 5, 5, 1, 5, 5, 5, 5, 5, 3),
('Point 16', 3, 'Pinyin accent 16', 'Pinyin sans accent 16', 'Chinois simplifié 16', 'Chinois traditionnel 16', 'Français 16', 'Anglais 16', 'Espagnol 16', 
 'Utilisation 16', FALSE, TRUE, FALSE, TRUE, FALSE, 2, 2, 1, 3, 1, 1, 2, 1, 1, 1, 1, 1, 4),
('Point 17', 4, 'Pinyin accent 17', 'Pinyin sans accent 17', 'Chinois simplifié 17', 'Chinois traditionnel 17', 'Français 17', 'Anglais 17', 'Espagnol 17', 
 'Utilisation 17', TRUE, FALSE, TRUE, FALSE, TRUE, 3, 3, 2, 4, 2, 2, 3, 2, 2, 2, 2, 2, 5),
('Point 18', 5, 'Pinyin accent 18', 'Pinyin sans accent 18', 'Chinois simplifié 18', 'Chinois traditionnel 18', 'Français 18', 'Anglais 18', 'Espagnol 18', 
 'Utilisation 18', TRUE, TRUE, FALSE, TRUE, FALSE, 4, 4, 3, 5, 3, 3, 4, 3, 3, 3, 3, 3, 2),
('Point 19', 1, 'Pinyin accent 19', 'Pinyin sans accent 19', 'Chinois simplifié 19', 'Chinois traditionnel 19', 'Français 19', 'Anglais 19', 'Espagnol 19', 
 'Utilisation 19', FALSE, FALSE, TRUE, FALSE, TRUE, 5, 5, 4, 1, 4, 4, 5, 4, 4, 4, 4, 4, 3),
('Point 20', 2, 'Pinyin accent 20', 'Pinyin sans accent 20', 'Chinois simplifié 20', 'Chinois traditionnel 20', 'Français 20', 'Anglais 20', 'Espagnol 20', 
 'Utilisation 20', TRUE, TRUE, TRUE, FALSE, FALSE, 1, 1, 5, 2, 5, 5, 1, 5, 5, 5, 5, 5, 4);