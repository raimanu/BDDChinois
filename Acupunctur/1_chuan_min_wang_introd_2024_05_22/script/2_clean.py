
import pandas as pd
import numpy as np
import unicodedata
import re


def remove_accents(text):
    normalized_text = unicodedata.normalize('NFD', text)
    text_without_accents = re.sub(r'[\u0300-\u036f]', '', normalized_text)
    return text_without_accents


# Fonction pour fusionner deux colonnes en une troisième colonne
def fusionner_colonnes(df, colonne1, colonne2, colonneresult, delold=False):
    def fusionner(row):
        if pd.notna(row[colonne1]) and pd.isna(row[colonne2]):
            return row[colonne1]
        elif pd.isna(row[colonne1]) and pd.notna(row[colonne2]):
            return row[colonne2]
        elif pd.isna(row[colonne1]) and pd.isna(row[colonne2]):
            return np.nan
        else:
            return "[DEV_CONFLIT]"
    df[colonneresult] = df.apply(fusionner, axis=1)
    if delold :
        df.drop([colonne1, colonne2], axis=1, inplace=True)

def point_split(df):
    df[['numéro', 'nom_francais1', 'nom_pinyin_sans_accent', 'nom_chinois_TODO']] = df['point'].str.extract(r'^(\d+\.\d+)\s+([^\(]+)\s+\((.*)\)\s*(.*)\s*')

def commun(df, sheet_name):
    df['source'] = sheet_name
    df = df.map(lambda x: x.replace("’", "'") if isinstance(x, str) else x)
    df = df.map(lambda x: x.replace("–", "'") if isinstance(x, str) else x)
    df = df.map(lambda x: re.sub(r'\t+', ' ', x) if isinstance(x, str) else x)
    df.columns = [remove_accents(col) for col in df.columns]
    return df

# Lire le fichier Excel
xls = pd.ExcelFile("out.xlsx")

# Créer un écrivain Excel pour écrire dans un fichier de sortie
with pd.ExcelWriter('out_clean.xlsx') as writer :

    # Itérer sur chaque feuille dans le fichier Excel d'entrée
    for sheet_name in xls.sheet_names:
        # Lire la feuille Excel dans un DataFrame
        df = pd.read_excel(xls, sheet_name)
        match sheet_name :
            case "INFOS_-_Chuan_Min_Wang_-_Introd":                
                fusionner_colonnes(df, 'Méridien(s) des cinq zang de Tung', 'Méridien(s) des Cinq Zang de Tung', '_temp_Méridien(s) des cinq zang de Tung', True)
                fusionner_colonnes(df, '_temp_Méridien(s) des cinq zang de Tung', 'Méridien(s) Five Zang de Tung', '_Méridien(s) des cinq zang de Tung', True)
                fusionner_colonnes(df, 'Cas de Maître Tung', 'Cas du Maître Tung', '_Cas du Maître Tung', True)
                fusionner_colonnes(df, "Technique de l'aiguille", "Technique de l’aiguille", "_Technique de l'aiguille", True)
                point_split(df)
                df['zone'] = df['numéro'].astype(str).str.split('.').str[0]
                df = commun(df, sheet_name)
            
            case "INFOS_-_Lectures_sur_lacupunctu":
                df = commun(df, sheet_name)
                                
            case "INFOS_-_Atlas_pratique_de_lacup":
                fusionner_colonnes(df, 'Correspondance de méridien', 'Correspondance des méridiens', '_Correspondance des méridiens', True)
                fusionner_colonnes(df, 'Correspondance Images', 'Correspondant Image', '_Correspondance Image', True)
                fusionner_colonnes(df, 'Note', 'Notes', '_Note', True)
                fusionner_colonnes(df, 'Recommandations particulières', 'Recommandations spéciales', '_Recommandations particulières', True)
                fusionner_colonnes(df, 'Zone de réaction', 'Zones de réaction', '_Zones de réaction', True)
                fusionner_colonnes(df, 'Poncture et manipulation', 'Poncture et Manipulation', '_temp_Poncture et Manipulation', True)
                fusionner_colonnes(df, 'Poncture et/ou manipulation', '_temp_Poncture et Manipulation', '_Poncture et Manipulation', True)
                fusionner_colonnes(df, 'Correspondance tissu et Zang', 'Correspondance Tissu et Zang Fu', '_c1', True)
                fusionner_colonnes(df, 'Correspondance tissu et Zang Fu', '_c1', '_c2', True)
                fusionner_colonnes(df, 'Correspondance tissu et ZangFu', '_c2', '_c3', True)
                fusionner_colonnes(df, 'Correspondance Tissu/Zang Fu', '_c3', '_c4', True)
                fusionner_colonnes(df, 'Correspondance tissus et Zang', '_c4', '_c5', True)
                fusionner_colonnes(df, 'Correspondance Tissus et Zang Fu', '_c5', '_c6', True)
                fusionner_colonnes(df, 'Correspondance tissus et Zang Fu', '_c6', '_Correspondance tissus et Zang Fu', True)
                df = commun(df, sheet_name)
                
                    
        # Écrire le DataFrame transformé dans le fichier de sortie avec le nom de feuille d'origine
        df.to_excel(writer, sheet_name=sheet_name, index=False)
