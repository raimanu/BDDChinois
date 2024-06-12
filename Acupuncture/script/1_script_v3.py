import pandas as pd
import re
import subprocess

def extract_keys_values(text, allowed_keys):
    lines = text.split('\n')
    key_value_dict = {}
    current_key = None
    current_value = ''
    for line in lines:
        parts = line.split(':', 1)
        if len(parts) == 2:
            key = re.sub(r'\s+', ' ', parts[0].strip())
            value = parts[1].strip()
            key_found = False
            for allowed_key in allowed_keys:
                if re.match(allowed_key, key, re.IGNORECASE):
                    key_found = True
                    if current_key is not None:
                        key_value_dict[current_key] = current_value.strip() #TODO gérer cas où plusieurs fois même clés texte différents car écrase actuellement
                        current_value = ''
                    current_key = key
                    current_value += value + '\n'
                    break
            if not key_found:
                if current_key is not None:
                    current_value += line.strip() + '\n'
        elif current_key is not None:
            current_value += line.strip() + '\n'
    if current_key is not None:
        key_value_dict[current_key] = current_value.strip()
    return key_value_dict

def concatenate_fields(row):
    fields = row.drop(["point", "texte"])
    field_strings = [f"{field_name} : {field_value}" for field_name, field_value in fields.items() if not pd.isnull(field_value)]
    return '\n'.join(field_strings)
        
def count_characters(cell):
    return len(str(cell).strip()) #TODO replace \s by nothing for better check

def check_data(df):
    # text de verif
    dfn['verifTexte'] = dfn.apply(concatenate_fields, axis=1)
    # nb chars
    dfn['texte_nb_chars'] = dfn['texte'].apply(count_characters)
    dfn['verifTexte_nb_chars'] = dfn['verifTexte'].apply(count_characters)
    dfn['diff_chars'] = dfn['verifTexte_nb_chars'] - dfn['texte_nb_chars']
    return df

# Liste des clés autorisées (exprimées en regex, insensibles à la casse)
allowed_keys = {'INFOS_-_Chuan_Min_Wang_-_Introd' : 
            [ 
                "M.ridien\(s\) (des )?(cinq|five) zang de Tung",
                "Cas d.{0,2} Maître Tung",
                "Technique de l.aiguille",
                "Exp.rience clinique",
                "Localisation",
                "Indications?",
                "Protocole",
                "Attention"
            ],
                'INFOS_-_Lectures_sur_lacupunctu' :
            [ 
                "Localisation", #TODO
                "Indications?",
            ],
                'INFOS_-_Atlas_pratique_de_lacup' : 
            [ 
                "Actions",
                "Commentaires",
                "Correspondance de méridien",
                "Correspondance des méridiens",
                "Correspondance Images",
                "Correspondance tissu et Zang",
                "Correspondance Tissu et Zang Fu",
                "Correspondance Tissu\(s\) et Zang Fu",
                "Correspondance Tissu/Zang Fu",
                "Correspondance tissus et Zang",
                "Correspondance Tissus et Zang Fu",
                "Correspondant Image",
                "Fonctions",
                "Indications",
                "Indications spécifiques",
                "Localisation",
                "Note",
                "Poncture et manipulation",
                "Poncture et\s*/\s*ou manipulation",
                "Recommandations particulières",
                "Recommandations spéciales",
                "Zone de réaction",
                "Zones de réaction",
                "Contre-Indications"
            ]
            
            }

# Lire le fichier Excel
xls = pd.ExcelFile("data/extract_script_clean.xlsx")

# Créer un écrivain Excel pour écrire dans un fichier de sortie
with pd.ExcelWriter('out.xlsx') as writer :

    # Itérer sur chaque feuille dans le fichier Excel d'entrée
    for sheet_name in xls.sheet_names:
        # Lire la feuille Excel dans un DataFrame
        df = pd.read_excel(xls, sheet_name, header=None)
        df.columns = ["point", "texte"]
        # df['texte'] = df['texte'].str.replace(r'\[IMG_.*\]', '', regex=True)

        # Appliquer la fonction d'extraction à la colonne 'texte' pour créer de nouvelles colonnes
        dfn = pd.concat([df, df['texte'].apply(lambda x: pd.Series(extract_keys_values(x, allowed_keys[sheet_name])))], axis=1)

        # intégrité des données
        check_data(dfn)
        
        # Écrire le DataFrame transformé dans le fichier de sortie avec le nom de feuille d'origine
        dfn.to_excel(writer, sheet_name=sheet_name, index=False)

if True :        
    subprocess.call(['python', '2_clean.py'])
    print("2_clean.py exécuté !")