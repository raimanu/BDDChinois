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