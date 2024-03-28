-- Sélectionner tous les points avec leurs familles et leurs localisations :

SELECT p.nom_point, f.nom_famille, l.desc_anatomique
FROM Points p
JOIN Familles_de_points f ON p.id_famille = f.id_famille
JOIN Localisation l ON p.id_localisation = l.id_localisation;

-- Trouver les points avec autorisation de saignée et qui sont utilisés dans une méthode d'équilibrage spécifique :

SELECT p.nom_point, m.id_methode_equilibre
FROM Points p
JOIN Methode_equilibre m ON p.id_methode_equilibre = m.id_methode_equilibre
WHERE p.autorisation_saignee = TRUE AND m.description_equilibrage = 'Méthode pour renforcer l''aspect Yang de l''organisme';

-- Obtenir les différents points pour une indication primaire spécifique :

SELECT nom_point, nom_indication_primaire, texte_indication_primaire
FROM Points
JOIN Indications_primaires ON Points.id_indication_primaire = Indications_primaires.id_indication_primaire
WHERE nom_indication_primaire = 'Insomnie';

-- Trouver les points situés dans une division particulière :

SELECT nom_point, nom_division
FROM Points
JOIN Division ON Points.id_division = Division.id_division
WHERE nom_division = 'Supérieure';

-- Trouver les points avec leur situation anatomique et leur efficacité sur les méridiens :

SELECT p.nom_point, sit.nom_muscles, e.efficacite
FROM Points p
JOIN Situation_anatomique sit ON p.id_situation = sit.id_situation
JOIN Efficacite_sur_les_meridiens e ON p.id_efficacite = e.id_efficacite;

-- Obtenir les contre-indications pour un point spécifique :

SELECT nom_point, nom_contre_indication, texte_contre_indication
FROM Points
JOIN Contre_indications ON Points.id_contre_indication = Contre_indications.id_contre_indication
WHERE nom_point = 'Point 5';

-- Trouver les points avec une utilisation spécifique, qui ne sont pas fixes et autorisés pour la saignée :

SELECT 
    p.nom_point,
    p.utilisation,
    l.desc_anatomique,
    ip.nom_indication_primaire
FROM 
    Points p
INNER JOIN 
    Localisation l ON p.id_localisation = l.id_localisation
LEFT JOIN 
    Indications_primaires ip ON p.id_indication_primaire = ip.id_indication_primaire
WHERE 
    p.utilisation LIKE '%Utilisation 1%' 
    AND p.point_nonfixe = TRUE 
    AND p.autorisation_saignee = TRUE 
ORDER BY 
    p.nom_point ASC; 