DROP TABLE IF EXISTS Points__Indication CASCADE;
DROP TABLE IF EXISTS Division CASCADE;
DROP TABLE IF EXISTS Points__Meridien CASCADE;
DROP TABLE IF EXISTS Meridien CASCADE;
DROP TABLE IF EXISTS Technique_aiguille CASCADE;
DROP TABLE IF EXISTS Points__Famille CASCADE;
DROP TABLE IF EXISTS Familles_de_points CASCADE;
DROP TABLE IF EXISTS Indication CASCADE;
DROP TABLE IF EXISTS Sources CASCADE;
DROP TABLE IF EXISTS Localisation CASCADE;
DROP TABLE IF EXISTS Mecanismes CASCADE;
DROP TABLE IF EXISTS Methode_equilibre CASCADE;
DROP TABLE IF EXISTS Points CASCADE;
DROP TABLE IF EXISTS Protocoles CASCADE;
DROP TABLE IF EXISTS Remarques CASCADE;
DROP TABLE IF EXISTS Situation_anatomique CASCADE;


CREATE TABLE Division (
  PRIMARY KEY (id_division),
  id_division       SERIAL,
  nom_division      TEXT
);

CREATE TABLE Meridien (
  PRIMARY KEY (id_meridien),
  id_meridien       SERIAL,
  nom_meridien      TEXT UNIQUE,
  type_energie      TEXT,
  organe            TEXT,
  trajet_meridien   TEXT,
  fonction_meridien TEXT
);

CREATE TABLE Technique_aiguille (
  PRIMARY KEY (id_technique),
  id_technique      SERIAL,
  nom_technique     TEXT,
  profondeur        TEXT,
  sens              TEXT,
  description       TEXT UNIQUE
);

CREATE TABLE Familles_de_points (
  PRIMARY KEY (famille_id),
  famille_id        SERIAL,
  nom_famille       TEXT UNIQUE
);

CREATE TABLE Indication (
  PRIMARY KEY (id_indication),
  id_indication     SERIAL,
  nom_indication    TEXT,
  type_indication   BOOLEAN, -- Indication ou contre indication
  description       TEXT UNIQUE,
  num_indication    TEXT     -- potentiellement pour classer importance
);

CREATE TABLE Sources (
  PRIMARY KEY (id_sources),
  id_sources     SERIAL,
  titre          TEXT,
  auteur         TEXT,
  isbn           INT UNIQUE,
  edition        TEXT,
  annee          TEXT,
  lien           TEXT
);

CREATE TABLE Localisation (
  PRIMARY KEY (id_localisation),
  id_localisation         SERIAL,
  description             TEXT UNIQUE,
  langue_localisation     TEXT,
  image_localisation      TEXT,
  image_ligne_de_puncture TEXT,
  note1                   TEXT,
  note2                   TEXT
);

CREATE TABLE Mecanismes (
  PRIMARY KEY (id_mecanisme),
  id_mecanisme            SERIAL,
  nom_mecanisme           TEXT UNIQUE
);

CREATE TABLE Methode_equilibre (
  PRIMARY KEY (id_methode_equilibre),
  id_methode_equilibre    SERIAL,
  nom_equilibrage         TEXT UNIQUE,
  description TEXT UNIQUE
);

CREATE TABLE Protocoles (
  PRIMARY KEY (id_protocole),
  id_protocole          SERIAL,
  nom_protocole         TEXT UNIQUE,
  description TEXT UNIQUE
);

CREATE TABLE Remarques (
  PRIMARY KEY (id_remarque),
  id_remarque      SERIAL,
  nom_remarque     TEXT UNIQUE,
  description TEXT UNIQUE
);

CREATE TABLE Situation_anatomique (
  PRIMARY KEY (id_situation),
  id_situation        SERIAL,
  nom_muscles         TEXT,
  nom_vascularisation TEXT,
  nom_innervation     TEXT,
  nom_shengjing       TEXT
);

CREATE TABLE Points (
  PRIMARY KEY (id_point, id_sources),
  id_point                 TEXT,
  id_sources               INT,
  nom_pinyin_accent        TEXT,
  nom_pinyin_sans_accent   TEXT,
  nom_chinois_simplifie    TEXT,
  nom_chinois_traditionnel TEXT,
  nom_francais             TEXT,
  nom_anglais              TEXT,
  nom_espagnol             TEXT,
  autorisation_saignee     BOOLEAN,
  aiguilles_absolues       TEXT,
  aiguilles_resolution     TEXT,
  id_methode_equilibre     INT,
  id_mecanisme             INT,
  id_protocole             INT,
  id_localisation          INT,
  id_division              INT,
  id_situation             INT,
  id_remarque              INT,
  id_technique             INT
);

CREATE TABLE Points__Meridien (
  PRIMARY KEY (id_point, id_sources, id_meridien),
  id_point              TEXT,
  id_sources            INT,
  id_meridien           INT,
  note_efficacite       INT,
  description           TEXT
);

CREATE TABLE Points__Indication (
  PRIMARY KEY (id_indication, id_point, id_sources),
  id_indication         INT,
  id_point              TEXT,
  id_sources            INT
);

CREATE TABLE Points__Famille (
  PRIMARY KEY (id_point, id_sources, famille_id),
  id_point              TEXT,
  id_sources            INT,
  famille_id            INT
);


ALTER TABLE Points ADD FOREIGN KEY (id_sources) REFERENCES Sources (id_sources);
ALTER TABLE Points ADD FOREIGN KEY (id_remarque) REFERENCES Remarques (id_remarque);
ALTER TABLE Points ADD FOREIGN KEY (id_situation) REFERENCES Situation_anatomique (id_situation);
ALTER TABLE Points ADD FOREIGN KEY (id_division) REFERENCES Division (id_division);
ALTER TABLE Points ADD FOREIGN KEY (id_localisation) REFERENCES Localisation (id_localisation);
ALTER TABLE Points ADD FOREIGN KEY (id_protocole) REFERENCES Protocoles (id_protocole);
ALTER TABLE Points ADD FOREIGN KEY (id_mecanisme) REFERENCES Mecanismes (id_mecanisme);
ALTER TABLE Points ADD FOREIGN KEY (id_methode_equilibre) REFERENCES Methode_equilibre (id_methode_equilibre);
ALTER TABLE Points ADD FOREIGN KEY (id_technique) REFERENCES Technique_aiguille (id_technique);

ALTER TABLE Points__Meridien ADD FOREIGN KEY (id_meridien) REFERENCES Meridien (id_meridien);

ALTER TABLE Points__Indication ADD FOREIGN KEY (id_point, id_sources) REFERENCES Points (id_point, id_sources);
ALTER TABLE Points__Indication ADD FOREIGN KEY (id_indication) REFERENCES Indication (id_indication);

ALTER TABLE Points__Famille ADD FOREIGN KEY (famille_id) REFERENCES Familles_de_points (famille_id);
ALTER TABLE Points__Famille ADD FOREIGN KEY (id_point, id_sources) REFERENCES Points (id_point, id_sources);
