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




INSERT INTO meridien (organe)
VALUES ('cœur'),
       ('poumon'),
       ('foie'),
       ('reins'),
       ('vésicule biliaire'),
       ('rate'),
       ('utérus'),
       ('gros intestin'),
       ('petit intestin'),
       ('poumons'),
       ('foie (ou poumons)'),
       ('estomac');

INSERT INTO meridien (nom_meridien)
VALUES ('six fu'),
       ('zhèngzhòng (centre droit 正中)');

select * from meridien;





-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Localisation (description) VALUES ('3 fen du côté radial de Crevasse centrale/ Zhong Jian. Prendre le point 11.05 comme repère/référence');
INSERT INTO Localisation (description) VALUES ('2 fen distaux de la Grande Crevasse. Prendre le point 11.05 comme repère/référence');
INSERT INTO Localisation (description) VALUES ('2 fen radialement à partir de la ligne médiane de la phalange moyenne de l''index et 3,3 fen (1/3 de la longueur de la phalange moyenne) proximalement à l''articulation de la phalange distale. Prendre le point 11.05 comme repère/référence');
INSERT INTO Localisation (description) VALUES ('2 fen radialement à partir de la ligne médiane de la phalange moyenne de l''index et 6,6 fen (2/3 de la longueur de la phalange moyenne) proximalement à l''articulation de la phalange distale. Prendre le point 11.05 comme repère/référence');
INSERT INTO Localisation (description) VALUES ('patient en décubitus dorsal, paume vers le haut, au centre de la phalange proximale de l''index.');
INSERT INTO Localisation (description) VALUES ('Paume vers le bas, au (centre du côté ulnaire de la phalange moyenne de l''annulaire.');
INSERT INTO Localisation (description) VALUES ('Unité de trois points. Paume vers le bas, sur une ligne de 2 fen à la face ulnaire de la ligne médiane sur la face dorsale de la deuxième phalange de l''index. Le point central se trouve au milieu de la ligne. Les deux autres points se trouvent à 3 fen au-dessus et en dessous de ce point central.');
INSERT INTO Localisation (description) VALUES ('Unité de deux points. Paume vers le bas, sur une ligne de 2 fen sur la face ulnaire de la ligne médiane de la première phalange de l''index. Mesurez 1/3 et 2/3 de cette ligne pour localiser ces 2 points.');
INSERT INTO Localisation (description) VALUES ('Unité de deux points. Paume en bas, l''un est au centre du bord radial de la deuxième phalange du majeur ; l''autre est au centre du bord cubital.');
INSERT INTO Localisation (description) VALUES ('Paume vers le bas, sur le centre de jonction entre la troisième et la deuxième phalange du majeur dorsal.');
INSERT INTO Localisation (description) VALUES ('Unité de deux points. Paume vers le bas, mesurer 1/3 et 2/3 de la ligne médiane de la deuxième phalange du majeur.');
INSERT INTO Localisation (description) VALUES ('Unité de deux points. Paume vers le bas, mesurez 1/3 et 2/3 de la ligne médiane de la première phalange du majeur.');
INSERT INTO Localisation (description) VALUES ('Unité à deux points. Paume vers le bas, un point est au centre du bord ulnaire de la première phalange du majeur, un autre est au centre du bord radial.');
INSERT INTO Localisation (description) VALUES ('Unité de trois points. Mesurer une ligne à 2 fen du côté ulnaire de la ligne médiane de la deuxième phalange de l''annulaire. Le point médian de cette ligne est le premier point, les 2 autres points sont à 3 fen proximaux et distaux par rapport au point médian.');
INSERT INTO Localisation (description) VALUES ('Unité de trois points. Mesurer une ligne à 2 fen du côté ulnaire de la ligne médiane de la première phalange de l''annulaire. Le point médian de cette ligne est le premier point, les 2 autres points sont à 3 fen proximaux et distaux du point médian.');
INSERT INTO Localisation (description) VALUES ('2 fen latéraux à la racine de l''ongle du petit doigt.');
INSERT INTO Localisation (description) VALUES ('Unité à deux points. Placez une ligne à 2 fen du côté ulnaire de la ligne médiane sur la surface palmaire de la phalange proximale de l''index. Les points sont situés à 1/3 et 2/3 de cette ligne.');
INSERT INTO Localisation (description) VALUES ('Unité de deux points. Paume vers le haut, mesurer 1/3 et 2/3 de la ligne médiane de la phalange moyenne du majeur.');
INSERT INTO Localisation (description) VALUES ('Unité à deux points. Placez une ligne à 2 fen du côté ulnaire de la ligne médiane sur la surface palmaire de la phalange proximale du majeur. Les points sont situés à 1/3 et 2/3 de cette ligne.');
INSERT INTO Localisation (description) VALUES ('Unité de deux points. Paume vers le haut, mesurer une ligne à 2 fen du côté ulnaire de la ligne médiane de la deuxième phalange de l''annulaire. Les points sont situés à 1/3 et 2/3 de cette ligne.');
INSERT INTO Localisation (description) VALUES ('3 fen du côté radial de la ligne médiane sur la surface palmaire de la phalange proximale de l''annulaire. Mesurer ensuite 2 fen en proximal du 2ème pli de l''annulaire.');
INSERT INTO Localisation (description) VALUES ('Unité à trois points. Côté palmaire, mesurer 2 fen du côté ulnaire à partir de la ligne médiane de la phalange proximale de l''annulaire, et le premier point est situé au centre, puis 3 fen en haut et en bas pour trouver 2 autres points.');
INSERT INTO Localisation (description) VALUES ('paume vers le haut, au centre de la surface palmaire de la deuxième phalange de l''auriculaire.');
INSERT INTO Localisation (description) VALUES ('Unité formée de deux points. Patient en décubitus dorsal, paume en bas, mesurez une ligne à 3 fen du côté ulnaire à partir de la ligne médiane dorsale de la première phalange du pouce, repérez 1/3 et 2/3 de cette ligne.');
INSERT INTO Localisation (description) VALUES ('Unité à deux points. Mesurer une ligne à 3 fen du côté radial de la ligne médiane sur la surface dorsale de la première phalange du pouce. Les points sont situés à 1/3 et 2/3 de cette ligne.');
INSERT INTO Localisation (description) VALUES ('Ligne médiane sur la face dorsale de la première phalange du pouce, localiser 1/4, 1/2, 3/4 sur cette ligne.');
INSERT INTO Localisation (description) VALUES ('Unité de cinq points. Division radiale entre la face palmaire et la face dorsale du pouce ; diviser la distance entre le premier pli et le second en 5 parties égales, chaque point étant à 2 fen du suivant.');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Indication (description, type_indication) VALUES ('shan qi (i.e. hernie) le plus efficace, qi de l''intestin grêle, maladie cardiaque, douleur au genou, douleur au canthus.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('shan qi, qi de l''intestin grêle, bronchite, division du flegme jaune, oppression thoracique, palpitations cardiaques, douleur au genou, douleur au canthus.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('shan qi, qi de l''intestin grêle, urétrite, maux de dents, maux d''estomac.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('même chose que Crevasse flottante.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('shan qi, palpitations cardiaques, oppression thoracique, douleurs aux genoux, vertiges, vision trouble.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('Utérodynie, tumeur utérine, utérite, menstruations anormales, pertes leucorrhéiques rougeâtres ou blanches, blocage des trompes de Fallope, malposition de l''utérus, mictions fréquentes, gonflement vaginal, prévention des fausses couches.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('pleurésie, douleurs pleurales, maladies de la peau, taches noires du visage (émotions contrariées), rhinite, acouphènes et otites.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('entérite, douleurs abdominales', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('douleurs du genou, scapulalgie.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('hémiplégie', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('douleurs vertébrales, douleurs cervicales, douleurs de distension des crus (jambe inférieure).', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('lumbago avec déchirure et respiration difficile, douleurs rénales, douleurs de la crête supra-orbitaire (céphalée frontale) et douleurs des os du nez.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('tremblements de peur et pleurs nocturnes des enfants.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('dissiper le vent, paralysie faciale (paralysie de Bell), engorgement mammaire, atrophie musculaire.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('soif excessive, épuisement des reins, insuffisance cardiaque, douleurs dorsales.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('douleurs aux genoux, arthrite, maladies cardiaques rhumatismales, mucosités dans les orifices du cœur dues à la colère.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('montée du feu du foie, agitation du qi de la rate, rhume, yeux secs, larmoiement, froid avec transpiration, problème de peau des mains, desquamation de la peau des mains.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('splénomégalie, splénite, splenceratose.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('palpitations, maladies cardiaques, maladies cardiaques rhumatismales.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('hépatite, hépatomégalie, cirrhose du foie.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('point de complément (même fonction que ZuSanLi E36)', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('gonflement des os.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('Yeux jaunes (jaunisse).', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('utérite, utérodynie (aiguë ou chronique), tumeur utérine, distension abdominale inférieure, infertilité chronique, irrégularité menstruelle, colique menstruelle, hyperménorrhée ou hypoménorrhée.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('bave (incessante) des enfants.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('ulcère malin chronique, liquide suintant d''une entaille profonde après une chirurgie tumorale, et plaie ne cicatrisant pas.', 'true');
INSERT INTO Indication (description, type_indication) VALUES ('gonflement des articulations et des os de tout le corps, douleur au talon, douleur au pied, douleur à la main et douleur au sommet de la tête.\nWu Hu 1 : douleur aux doigts. Wu Hu 2 & 3 : douleur aux orteils. Wu Hu 3 : douleur au sommet de la tête. Wu Hu 4 : douleur à l''arrière du pied. Wu Hu 5 : douleur au talon.', 'true');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Remarques (description) VALUES ('1. Trouvez un point de réaction (veine bleue/violette ou tache sombre) autour des cinq points Crevasse pour piquer ou saigner : Bon résultat.\n2. Pour les maladies cardiaques, il est très important de saigner pour faire sortir le liquide jaune ou le sang foncé au niveau de la Crevasse centrale (Zhong Jian 11.05).\n3. Shan qi avec des testicules enflammés et gonflés, saigner la zone entre l''empereur de la Terre (Di Huang 77.19) et l''empereur humain (Ren Huang 77.21). (Chen, 1964)\n4. Il n''existe pas de traduction anglaise directe du terme shan qi (疝氣). Shan (疝) contient 3 conditions : (1) hernie : saillie d''une partie d''un organe ou d''un tissu de la cavité corporelle par une ouverture anormale ; (2) maladie génitale : maladies des organes génitaux masculins et féminins ; (3) colique abdominale inférieure : douleur de type colique sévère dans le bas-ventre généralement accompagnée de constipation et d''ischurie. Shan qi (疝氣） est un synonyme de shan (疝). Et le qi de l''intestin grêle est une hernie qui porte un autre nom que 疝 (shan) dans la médecine traditionnelle chinoise. Dans le Huang Di Nei Jing, le shan est classé selon la forme et la constitution, par exemple le shan du renard ou le shan du sang. Il est également classé selon les cinq zang shan. "Lorsque le pouls du foie est important, rapide et profond et que le pouls des reins est important et profond, toutes ces conditions sont des signes de shan [foie et reins]. Lorsque le pouls du cœur est important, rapide et profond, c''est le signe de shan du cœur. Lorsque le pouls du poumon est profond et battant, c''est le signe du poumon shan....... Lorsque le pouls du troisième organe yin [rate] est rapide, c''est le shan [de la rate]." (Suwen, Chap. 48, Discussion des maladies inhabituelles).\nQuel type de shan doit être traité par le Groupe des Cinq Crevasses ? La réponse est le shan du cœur et le shan du poumon, car les points des Cinq Crevasses ont soit un canal relié au cœur, soit un canal relié au poumon. Pour traiter le shan des reins ou de la rate, Maître Tung appliquait une saignée comme dans l''expérience clinique 3. Il traitait le shan du foie en faisant une saignée au F1 (Da Dun), puis en brûlant 3 à 7 cônes de moxa (Tung, 1973).');
INSERT INTO Remarques (description) VALUES ('1. Infertilité : (D) Gynécologie (FuKe 11.24), (G) Nid de retour (Huan Chao 11.06), Côtés des Montagnes d''État (Zhou Lun 1010.04) en bilatéral, Rein ouvert (Tong Shen 88.09) en bilatéral.\n2. Infertilité, test EMAS (Electro Meridian Analysis System), déficience SJ, GI.\n3. Prostatite de l''homme âgé du à un froid pervers, piquez Huan Chao 11.06. Parce que Huan Chao 11.06 peut promouvoir le yang qi du triple réchauffeur (Sanjiao). (Dr. Liu)\n4. Utérodynie due à un avortement, piquez Huan Chao (11.06) qui soulagera la douleur pendant 4-5 heures. Piquer en bilatéral Rte6 (San Yin Jiao) ne soulage une telle douleur que pendant 10 minutes environ. (Lee, 1992)\n5. Leucorrhée : Piquez à droite Gynécologie (FuKe 11.24), et ajouter également un point entre 22.04 & 22.05. (Maître Tung)\n6. Menstruations retardées : Eau-Métal (1010.20), Gynécologie (FuKe 11.24), Ren 24 (Cheng Jiang). (Dr. Tze en Argentine)\n7. Galactorrhée mélangée à du sang vaginal collant : (D) Gynécologie (FuKe 11.24), (G) Retour au nid (Huan Chao 11.06), et (D) Groupe des trois couches (San Chong Xue Zu 77.05-77.07).');
INSERT INTO Remarques (description) VALUES ('1. Bon pour les taches noires du visage des femmes dues au syndrome de déficience rénale et pulmonaire. - Acupuncture cosmétique.\n2. Cas de lactorrhée de Maître Tung. 3 traitements pour une lactorrhée (galactorrhée) de 12 ans. (Lai, 1987)');
INSERT INTO Remarques (description) VALUES ('douleur vertébrale, faiblesse du genou, douleur de la rotule et douleur autour de la zone de F8 (genou médial). (Lai, 1987)');
INSERT INTO Remarques (description) VALUES ('1. Conditions pour le point de feu de bois :\n1) Membres inférieurs froids\n2) veine noire/bleue ou tache noire autour de ce point\n2. Hologramme : occiput '' zone du cerveau.\n3. Le traitement consume du yuan qi 元氣 en compensation, pas bon pour réguler le qi 調氣.\nL''un des principaux points utilisés pour soigner le président Lon Nol de la République Khmere');
INSERT INTO Remarques (description) VALUES ('Deux coins lumineux (Er Jiao Ming 11.12) est excellent pour la douleur de Yao Yan (3,5 cun latéral à L4) et la douleur de la crête supra-orbitaire. Surtout pour les patientes. (Lai, 1987)');
INSERT INTO Remarques (description) VALUES ('Cas du maitre Tung\nUne femme a fait une dépression schizophrénique suite à une querelle avec son mari. Maître Tung a piqué le Genou de Feu (Huo Xi 11.16) bilatéralement, après quoi elle a craché 2 intestins de glaires et a été guérie. (Lai, 1987)');
INSERT INTO Remarques (description) VALUES ('Cas du maitre Tung\npour traiter la transpiration nocturne, piquer à ras de Mu (11.17).');
INSERT INTO Remarques (description) VALUES ('MTC : Les aliments crus et les boissons froides blessent la rate. (Lee, 1992)');
INSERT INTO Remarques (description) VALUES ('Syndrome d''embrasement du feu du foie, sensation d''amertume et insomnie. (Lai, 1987)');
INSERT INTO Remarques (description) VALUES ('1. En cas de jaunisse aiguë, combinez avec la porte du foie (Gan Men 33.11) (Lai, 1987).\n2. Pour la jaunisse chronique, combinez avec les trois jaunes supérieurs (Shang San Huang Xue Zu 88.12,13,14) (Lai, 1987).');
INSERT INTO Remarques (description) VALUES ('Cas du maitre Tung\n1. Un garçon de 11 ans a été opéré de la jambe. Après l''opération, la plaie ne guérissait pas et suintait constamment du liquide. Maître Tung a piqué ces points sur la face dorsale du pouce du garçon vers 11 heures du matin. À 15 heures cet après-midi-là, le suintement avait cessé et le garçon a pu sortir de l''hôpital, alors qu''auparavant les infirmières devaient changer les pansements toutes les heures. (Chen, 1964)\n2. Hémorroïde, Saigner d''abord dans la zone postérieure de la jambe, puis piquez Contrôler la saleté (11.26).\n3. Otite moyenne, saigner Contrôler la saleté (Zhi Wu 11.26), puis piquez le Groupe des Quatre Chevaux (Si Ma Xue Zu 88.17-19).');
INSERT INTO Remarques (description) VALUES ('1. Wu Hu 2 & 3 traitent la douleur des orteils.\n2. Pour une entorse ou une crise de goutte aiguë : Wu Hu 2 & 3, plus Chrysanthème de feu (Huo Ju 66.11) (en controlatéral), pour soulager progressivement la douleur. (Liu)\n\nCas du maitre Tung\n1. Douleur dorsale du pied gauche (os métatarsien en saillie), Piquer Wu Hu du côté droit.\n2. Fracture de la troisième côte du côté gauche, Piquer Wu Hu à droite.\n3. Rhumatalgie du genou droit, piquer Wu Hu du côté droit.');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Protocoles (description) VALUES ('Formule Shan qi (c''est-à-dire hernie) : Crevasse externe, Grande crevasse, Petite crevasse et Crevasse centrale (Wai Jian 11.04, Da Jian 11.01, Xiao Jian 11.02, Zhong Jian 11.05).');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Indication (description, type_indication) VALUES ('La première fois, gardez l''aiguille pendant 5 minutes seulement, la deuxième fois (après 5 jours), gardez l''aiguille pendant 3 minutes seulement, la troisième fois (après 10 jours), gardez l''aiguille pendant 1 minute seulement.', 'false');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Technique_aiguille (description) VALUES ('aiguille de 5 fen, piquer 1 fen pour le zang du cœur, 2~2.5 fen pour le gros et l''intestin grêle.\nIl est interdit de piquer les deux côtés simultanément avec tous les points des Cinq Crevasses.');
INSERT INTO Technique_aiguille (description) VALUES ('1 fen de profondeur pour le zang du cœur, 2~2.5 fen pour le zang du poumon.\nIl est interdit de piquer les deux côtés simultanément avec tous les points des Cinq Crevasses.');
INSERT INTO Technique_aiguille (description) VALUES ('1 ~ 2 fen de profondeur.\nIl est interdit de piquer les deux côtés simultanément avec tous les points des Cinq Crevasses.');
INSERT INTO Technique_aiguille (description) VALUES ('1 ~ 2.5 fen de profondeur.\nIl est interdit de piquer les deux côtés simultanément avec tous les points des Cinq Crevasses.');
INSERT INTO Technique_aiguille (description) VALUES ('11.06 Retour au nid / Huan Chao : Piquez de 1-3 fen en profondeur, enfoncez l''aiguille à partir du bord dorsal de la phalange. Il est interdit de piquer les deux côtés simultanément.');
INSERT INTO Technique_aiguille (description) VALUES ('insérer l''aiguille à 0,5 fen de profondeur.');
INSERT INTO Technique_aiguille (description) VALUES ('insertion horizontale, 0,5 fen.');
INSERT INTO Technique_aiguille (description) VALUES ('insertion horizontale, 0,5 fen');
INSERT INTO Technique_aiguille (description) VALUES ('Saigner avec une aiguille à trois tranchants.');
INSERT INTO Technique_aiguille (description) VALUES ('insérer l''aiguille 0,5 fen.');
INSERT INTO Technique_aiguille (description) VALUES ('Insérez l''aiguille à 0,5 fen. Utilisez cet unité à trois points pour traiter les douleurs dorsales.');
INSERT INTO Technique_aiguille (description) VALUES ('insérer l''aiguille à une profondeur de 0,5 fen.');
INSERT INTO Technique_aiguille (description) VALUES ('insérer l''aiguille à 2 fen de profondeur sur les deux points.');
INSERT INTO Technique_aiguille (description) VALUES ('insérer l''aiguille à 2 fen de profondeur.');
INSERT INTO Technique_aiguille (description) VALUES ('saigner avec une aiguille à 3 tranchants pour faire sortir le sang noir.');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Division (id_division) VALUES ('11');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Sources (titre) VALUES ('INFOS_-_Chuan_Min_Wang_-_Introd');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('1', '1', '1', '1', '11', '1', '11.01', 'Grande Crevasse', 'Da Jian', '大間穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('2', '1', '1', '2', '11', '1', '11.02', 'Petite Crevasse', 'Xiao Jian', '小間穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('3', '1', '1', '3', '11', '1', '11.03', 'Fissure/crevasse flottante', 'Fu Jian', '浮間穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('4', '1', '1', '3', '11', '1', '11.04', 'Crevasse externe', 'Wai Jian', '外間穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('5', '1', '1', '4', '11', '1', '11.05', 'Crevasse centrale', 'Zhong Jian', '中間穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('6', '2', null, '5', '11', '1', '11.06', 'Retour au nid', 'Huan Chao', '還巢穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('7', '3', null, '6', '11', '1', '11.07', 'Quatre Chevaux du Doigt', 'Zhi Si Ma', '指駟馬穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('8', null, null, '6', '11', '1', '11.08', 'Cinq Métal du Doigt & Mille Métal du Doigt', 'Zhi Wu Jin & Zhi Qian Jin', '指五金，指千金穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('9', '4', null, '6', '11', '1', '11.09', 'Genou Cœur', 'Xin Xi', '心膝穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('10', '5', null, '7', '11', '1', '11.10', 'Feu de bois', 'Mu Huo', '木火穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('11', null, null, '7', '11', '1', '11.11', 'Cœur de poumon', 'Fei Xin 肺心穴', '肺心穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('12', '6', null, '8', '11', '1', '11.12', 'Deux coins lumineux', 'Er Jiao Ming', '二角明穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('13', null, null, '9', '11', '1', '11.13', 'Vésicule biliaire', 'Dan', '膽穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('14', null, null, '10', '11', '1', '11.14', 'Doigt à trois couches', 'Zhi San Chong', '指三重穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('15', null, null, '11', '11', '1', '11.15', 'Rein du doigt', 'Zhi Shen', '指腎穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('16', '7', null, '10', '11', '1', '11.16', 'Genou de feu', 'Huo Xi', '火膝穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('17', '8', null, '10', '11', '1', '11.17', 'Bois/Rhume', 'Mu', '木穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('18', '9', null, '10', '11', '1', '11.18', 'Gonflement de la rate', 'Pi Zhong', '脾腫穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('19', null, null, '10', '11', '1', '11.19', 'Cœur Normal', 'Xin Chang', '心常穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('20', '10', null, '12', '11', '1', '11.20', 'Inflammation bois', 'Mu Yan', '木炎穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('21', null, null, '12', '11', '1', '11.21', 'Trois yeux', 'San Yan', '三眼穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('22', null, null, '12', '11', '1', '11.22', 'Récupération', 'Fu Yuan', '復原穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('23', '11', null, '12', '11', '1', '11.23', 'Œil Jaune', 'Yan Huang', '眼黃穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('24', '2', null, '13', '11', '1', '11.24', 'Gynécologie', 'Fu Ke', '婦科穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('25', null, null, '14', '11', '1', '11.25', 'Arrêtez de cracher', 'Zhi Xian', '止涎穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('26', '12', null, '15', '11', '1', '11.26', 'Contrôler la saleté', 'Zhi Wu', '制污穴');
INSERT INTO Points (id_localisation, id_remarque, id_protocole, id_technique, id_division, id_sources, id_point, nom_francais, nom_pinyin_sans_accent, nom_chinois_traditionnel) VALUES ('27', '13', null, '14', '11', '1', '11.27', 'Cinq Tigres', 'Wu Hu', '五虎穴');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('1', '11.01', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('2', '11.02', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('3', '11.03', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('4', '11.04', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('5', '11.05', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('6', '11.06', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('7', '11.07', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('8', '11.08', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('9', '11.09', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('10', '11.10', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('11', '11.11', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('12', '11.12', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('13', '11.13', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('14', '11.14', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('15', '11.15', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('16', '11.16', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('17', '11.17', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('18', '11.18', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('19', '11.19', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('20', '11.20', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('21', '11.21', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('22', '11.22', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('23', '11.23', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('24', '11.24', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('25', '11.25', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('26', '11.26', '1');
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('27', '11.27', '1');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.01', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('13', '11.01', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.02', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('13', '11.02', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.03', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('13', '11.03', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.04', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('13', '11.04', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('2', '11.05', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.05', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('13', '11.05', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('3', '11.06', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('4', '11.06', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('2', '11.07', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('2', '11.08', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.09', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.10', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('3', '11.10', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.11', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('2', '11.11', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('4', '11.12', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('5', '11.13', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('3', '11.14', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('4', '11.14', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('3', '11.15', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('4', '11.15', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.16', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('2', '11.17', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('6', '11.18', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('1', '11.19', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('3', '11.20', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('3', '11.22', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('5', '11.23', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('7', '11.24', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('2', '11.25', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('6', '11.26', '1');
INSERT INTO Points__Meridien (id_meridien, id_point, id_sources) VALUES ('6', '11.27', '1');

-- INFOS_-_Chuan_Min_Wang_-_Introd
INSERT INTO Points__Indication (id_indication, id_point, id_sources) VALUES ('28', '11.10', '1');

select * from indication where id_indication not in (select id_indication from Points__indication) --doit ne rien retourner
