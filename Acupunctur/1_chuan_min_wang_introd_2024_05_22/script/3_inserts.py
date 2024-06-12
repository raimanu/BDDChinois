import pandas as pd
import json
import psycopg2
import os
import numpy as np


INSERTS_FILE = "inserts.sql"
CONNECTION_URL = f"postgresql://ptut:ptut@localhost:5432/acu_10_mai?application_name=psyco"

EXCLUDED_COL = {
    "INFOS_-_Chuan_Min_Wang_-_Introd" : ["texte", "verifTexte", "texte_nb_chars", "verifTexte_nb_chars", "diff_chars", "numero", "nom_francais1", "nom_pinyin_sans_accent", "nom_chinois_TODO"],
    "INFOS_-_Lectures_sur_lacupunctu" : [],
    "INFOS_-_Atlas_pratique_de_lacup" : []
}

POINTS_COL = {
    "INFOS_-_Chuan_Min_Wang_-_Introd" : {
        'all' : {
            "Localisation" : "id_localisation",
            "Experience clinique" : "id_remarque",
            "Protocole" : "id_protocole",
            "_Technique de l'aiguille" : "id_technique",
            "zone" : "id_division",
            "source" : "id_sources",
            "numero" : "id_point",
            "nom_francais1" : "nom_francais",
            "nom_pinyin_sans_accent" : "nom_pinyin_sans_accent",
            "nom_chinois_TODO" : "nom_chinois_traditionnel"
            },
        'referencesID' : ["Localisation","Experience clinique","Protocole","_Technique de l'aiguille", "zone", "source"]
        },
    "INFOS_-_Lectures_sur_lacupunctu" : [],
    "INFOS_-_Atlas_pratique_de_lacup" : []   
}

MTM_TABLES = {
    "INFOS_-_Chuan_Min_Wang_-_Introd" : {
        'ManyToManyTables' : {
            "Points__Indication" : { #TODO ne pas oublier le point de Attention
                "Indication" : {
                    "Indications" : {"description" : "id_indication"},
                },
                "Points" : {
                    "numero" : {"id_point" : "id_point"},
                },
                "Sources" : {
                    "source" : {"titre" : "id_sources"},
                }
            }
        }
    },
    "INFOS_-_Lectures_sur_lacupunctu" : [],
    "INFOS_-_Atlas_pratique_de_lacup" : []
}


MTM_TABLES_SPLIT = {
    "INFOS_-_Chuan_Min_Wang_-_Introd" : {
        'ManyToManyTables' : {
            "Points__Meridien" : {
                "Meridien" : {
                    "_Meridien(s) des cinq zang de Tung" : {("organe", "nom_meridien") : "id_meridien"}, #attention: limiter a 2 dans la liste
                },
                "Points" : {
                    "numero" : {"id_point" : "id_point"},
                },
                "Sources" : {
                    "source" : {"titre" : "id_sources"},
                }
            }
        }
    },
    "INFOS_-_Lectures_sur_lacupunctu" : [],
    "INFOS_-_Atlas_pratique_de_lacup" : []
}


def get_bdd_df():
    conn = psycopg2.connect(CONNECTION_URL)
    cur = conn.cursor()
    cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';")
    tables = cur.fetchall()
    cur.close()
    tables_data = {}
    for table_name in tables:
        table_name = table_name[0]  # Les noms de table sont retournés sous forme de tuple
        query = f"SELECT * FROM {table_name};"
        df = pd.read_sql_query(query, CONNECTION_URL)
        tables_data[table_name] = df
    conn.close()
    return tables_data
BDD_TABLES = get_bdd_df()       #pas propre de mettre var ici
def get_bdd_id(df, table, col_db):
    df = df.astype(str)
    df = df.map(lambda x: x.lower() if isinstance(x, str) else x)
    
    bdd = BDD_TABLES[table.lower()].astype(str)
    bdd = bdd.map(lambda x: x.lower() if isinstance(x, str) else x)
    bdd = bdd.map(lambda x: x.replace("\\n", '\n') if isinstance(x, str) else x)
    
    result = pd.merge(df, bdd, left_on=df.columns[0], right_on=bdd[col_db], how='left', indicator=True)
    result.to_csv(f"temp/result_{table}.csv",sep=';')
    return result.iloc[:,1]

# ------ points    
def p_create_inserts(dfsrc, sheet_name):
    df = dfsrc.copy()
    df = df[list(POINTS_COL[sheet_name]["all"].keys())]
    for col in POINTS_COL[sheet_name]["referencesID"]:
        table = find_table_from_colname(COLUMN_MAPPING[sheet_name], col)
        col_db = list(COLUMN_MAPPING[sheet_name][table].keys())[0]       # warning: il faut que une clé seulement dans le mapping json
        len_val_notnull = len(df[col].dropna())
        df[col] = get_bdd_id(pd.DataFrame(df[col]), table, col_db)
        len_val_notnull_after = len(df[col].dropna())
        if len_val_notnull_after != len_val_notnull :
            print(f"{len_val_notnull_after}/{len_val_notnull} trouvé : {sheet_name}.{table}.{col}")
    
    df.to_csv(f"temp/points.csv",sep=';')
    df = df.rename(columns=POINTS_COL[sheet_name]["all"])
    inserts_duplicates(df, "Points", sheet_name)
            
def p_manytomany_table(dfsrc, dictionnaire, sheet_name):
    for table, val in dictionnaire[sheet_name]['ManyToManyTables'].items() :
        df = dfsrc.copy()
        for soustable, val2 in val.items():
            table_src = soustable
            for col_df, val3 in val2.items():
                col_db_src = list(val3.keys())[0]
                len_val_notnull = len(df[col_df].dropna())
                key_comp = list(val3.keys())[0] if isinstance(list(val3.keys())[0], tuple) else ''
                if len(key_comp) > 1:
                    df_temp = df.copy()
                    df_temp['a'] = get_bdd_id(pd.DataFrame(df[col_df]), table_src, key_comp[0])
                    df_temp['b'] = get_bdd_id(pd.DataFrame(df[col_df]), table_src, key_comp[1])
                    df[col_df] = fusionner_colonnes(df_temp, 'a', 'b', '_')
                elif len(key_comp) > 2 :
                    print('attention: le cas ou plus de 2 valeurs dans la liste de clé composé est pas géré')
                else:
                    df[col_df] = get_bdd_id(pd.DataFrame(df[col_df]), table_src, col_db_src)
                len_val_notnull_after = len(df[col_df].dropna())
                if len_val_notnull_after != len_val_notnull :
                        print(f"{len_val_notnull_after}/{len_val_notnull} trouvé : {sheet_name}.{table}.{soustable}:{col_df}")
        keys = [key for v in val.values() for key in v.keys()]
        keys_new = [v3 for v in val.values() for v2 in v.values() for v3 in v2.values()]
        col_all_dict = dict(zip(keys,keys_new))
        df = df.rename(columns=col_all_dict)
        df = df[keys_new]
        inserts_duplicates(df, table, sheet_name)
        

def fusionner_colonnes(df, colonne1, colonne2, colonneresult, delold=False):
    def fusionner(row):
        if pd.notna(row[colonne1]) and pd.isna(row[colonne2]):
            return row[colonne1]
        elif pd.isna(row[colonne1]) and pd.notna(row[colonne2]):
            return row[colonne2]
        elif pd.isna(row[colonne1]) and pd.isna(row[colonne2]):
            return np.nan
        else:
            print("fusionner_colonnes: conflit 2 valeurs non null")
            return "[DEV_CONFLIT]"
    df[colonneresult] = df.apply(fusionner, axis=1)
    if delold :
        df.drop([colonne1, colonne2], axis=1, inplace=True)
    return df[colonneresult]

def p_mtm_split_df(df, col, sep):
    df[col] = df[col].str.split(sep)
    df = df.explode(col).reset_index(drop=True)
    df[col] = df[col].str.strip()
    return df

def find_table_from_colname(dictionnaire, valeur_recherchee):
    for table, valeurs in dictionnaire.items():
                for col_db, col_df in valeurs.items():
                    if isinstance(col_df, list):
                        if valeur_recherchee in col_df:
                            return table
                    elif valeur_recherchee == col_df:
                        return table

def inserts_duplicates(SOURCE, TARGET, SRCNAME):
    df = SOURCE.copy()
    df = df.replace("'", "''", regex=True)
    df = df.fillna('null')
    df = df.astype(str)

    sql_texts = []
    for index, row in df.iterrows():       
        sql_texts.append('INSERT INTO '+TARGET+' ('+ str(', '.join(df.columns))+ ') VALUES '+ str(tuple(row.values)))
    
    sql_texts = [sql_text.replace('",', "',").replace('("', "('") for sql_text in sql_texts]        # res: transformer car passe pas pour le SGBD si "" + car special '
    
    with open(INSERTS_FILE, 'a', encoding='utf-8') as f:
        f.write(f'-- {SRCNAME}\n')
        f.write(';\n'.join(sql_texts))
        f.write(";\n\n")

# ------ table de reference principalement
def inserts_drop(SOURCE, DF_COL_OLD, TARGET, SRCNAME):
    df = SOURCE.copy()
    df = df.replace("'", "''", regex=True)
    df = df.dropna()
    df['dev'] = df.map(lambda x: x.lower() if isinstance(x, str) else x)
    df = df.drop_duplicates(subset='dev')
    df = df.drop(columns=['dev'])
    
    match DF_COL_OLD:
        case "Attention":
            df['type_indication'] = 'false'
        case "Indications":
            df['type_indication'] = 'true'
    
    sql_texts = []
    for index, row in df.iterrows():       
        sql_texts.append('INSERT INTO '+TARGET+' ('+ str(', '.join(df.columns))+ ') VALUES '+ str(tuple(row.values)))
    
    sql_texts = [sql_text.replace('",', "',").replace('("', "('") for sql_text in sql_texts]        # res: transformer car passe pas pour le SGBD si "" + car special '
    if len(df.columns) == 1:                                                                   # res: tuple() met une virgule à la fin si 1 seul valeur pb
        sql_texts = [sql_text.replace(',)', ")") for sql_text in sql_texts]
    
    with open(INSERTS_FILE, 'a', encoding='utf-8') as f:
        f.write(f'-- {SRCNAME}\n')
        f.write(';\n'.join(sql_texts))
        f.write(";\n\n")


def TRT(df, colonne, col_db, table, sheet_name):
            dfm = df.copy()
            dfm.rename(columns={colonne: col_db}, inplace=True)
            inserts_drop(pd.DataFrame(dfm[col_db]), colonne, table, sheet_name)


# Lecture du fichier JSON contenant le mapping des colonnes
mapping_file = 'mapping.json'
with open(mapping_file, 'r') as f:
    COLUMN_MAPPING = json.load(f)

os.remove(INSERTS_FILE) if os.path.exists(INSERTS_FILE) else None

with pd.ExcelWriter('inserts.xlsx') as writer :
    xls = pd.ExcelFile("out_clean.xlsx")
    for sheet_name in xls.sheet_names:
        df = pd.read_excel(xls, sheet_name, dtype=str)
        col_map = COLUMN_MAPPING[sheet_name]
        
        print(sheet_name)
        # pas opti mais fonctionne si plusieurs champs à mettre même table
        for colonne in df.columns:
            trouve = False
            for table, valeurs in col_map.items():
                for col_db, col_df in valeurs.items():
                    if isinstance(col_df, list):
                        if colonne in col_df:
                            trouve = True
                            TRT(df, colonne, col_db, table, sheet_name)
                            break
                    elif colonne == col_df:
                        trouve = True
                        TRT(df, colonne, col_db, table, sheet_name)
                        break
            if not trouve and colonne not in EXCLUDED_COL[sheet_name]:
                print("\tColonne non mappée bdd :", colonne)
        
        match sheet_name:
            case "INFOS_-_Chuan_Min_Wang_-_Introd": 
                p_create_inserts(df, sheet_name)
                p_manytomany_table(df, MTM_TABLES, sheet_name)
                df_meridien = p_mtm_split_df(df, '_Meridien(s) des cinq zang de Tung', ',')
                p_manytomany_table(df_meridien, MTM_TABLES_SPLIT, sheet_name) #meridien
                df_attention = df.dropna(subset=['Attention']).reset_index(drop=True)
                indication_attention_manquante = {
                "INFOS_-_Chuan_Min_Wang_-_Introd" : {
                    'ManyToManyTables' : {
                        "Points__Indication" : { #TODO ne pas oublier le point de Attention à faire manuellement
                            "Indication" : {
                                "Attention" : {"description" : "id_indication"},
                            },
                            "Points" : {
                                "numero" : {"id_point" : "id_point"},
                            },
                            "Sources" : {
                                "source" : {"titre" : "id_sources"}}}}}}
                p_manytomany_table(df_attention, indication_attention_manquante, sheet_name)
                
                
                
            
        exit() #TODO à enlever si plusieurs feuilles Excel à traiter (ici ca ne traite que la première feuille)
        
