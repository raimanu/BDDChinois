from docx import Document
import csv

# List of attributes
attributes = [
    "Nom piyin sans accent",
    "Nom latin",
    "Nom botanique", 
    "Partie employée", 
    "Saveur", 
    "Nature", 
    "Tropisme", 
    "Fonctions", 
    "Indications", 
    "Combinaisons", 
    "Mode d’emploi et dosage", 
    "Toxicité", 
    "Précautions et contre-indications", 
    "Recherche clinique", 
    "Formules de référence", 
    "Commentaires",
]

attributes_for = [
    "Nom botanique", 
    "Partie employée", 
    "Saveur", 
    "Nature", 
    "Tropisme", 
    "Fonctions", 
    "Indications", 
    "Combinaisons", 
    "Mode d’emploi et dosage", 
    "Toxicité", 
    "Précautions et contre-indications", 
    "Recherche clinique", 
    "Formules de référence", 
    "Commentaires",
]

def extract_plant_data(document):
    # Initialize variables
    last_paragraph = ""
    second_last_paragraph = ""
    plant_data_list = []
    current_plant_data = {}
    current_attribute = None
    current_data = []
    ignore_paragraphs = False  # Flag to ignore paragraphs
    paragraphe_précédent = ""

    # Loop through each paragraph in the document
    for paragraph in document.paragraphs:
        # Check if the paragraph contains any attribute
        if paragraph.text == "BIBLIOGRAPHIE (*)":
            break

        if "Comparaisons" in paragraph.text or "LES HERBES" in paragraph.text or "INTRODUCTION" in paragraph.text or "Les herbes" in paragraph.text :
            ignore_paragraphs = True  # Set flag to ignore paragraphs after "Comparaisons"
            continue  # Skip paragraphs with "Comparaisons

        if ignore_paragraphs:
            if (paragraph.text == "" and paragraphe_précédent == "") or ("LES HERBES" not in paragraph.text and "INTRODUCTION" not in paragraph.text and "Les herbes" not in paragraph.text and ("Titre" in paragraph.style.name or "Comp" in paragraph.style.name) and paragraphe_précédent == ""):
                ignore_paragraphs = False
            else :
                paragraphe_précédent = paragraph.text
                continue
            
        for attribute in attributes_for:
            if attribute in paragraph.text:
                if attribute == "Nom botanique":
                    if current_plant_data:  # Check if there is data to append
                        # Add the current plant data to the list of plant data
                        current_plant_data[current_attribute] = " / ".join(current_data)
                        current_data = []
                        plant_data_list.append(current_plant_data)
                        # Start a new plant data dictionary for the next plant
                        current_plant_data = {}
                    current_plant_data["Nom piyin sans accent"] = second_last_paragraph
                    current_plant_data["Nom latin"] = last_paragraph

                # If we were extracting data for another attribute and found the first attribute, save it and start a new one
                if current_attribute:
                    current_plant_data[current_attribute] = " / ".join(current_data)
                    current_data = []
                
                current_attribute = attribute
                break  # Exit the loop once we found the attribute

        # If we are currently extracting data for an attribute
        if current_attribute:
            if ":" in paragraph.text:
                value = paragraph.text.split(":", 1)[1]
                value = value.strip()
                if value == "":
                    continue
                current_data = [value]
            elif not paragraph.text.strip():
                continue
            elif paragraph.text not in attributes and ("Titre" in paragraph.style.name or "Comp" in paragraph.style.name) :
                pass
            else:
                # Append the text to the current data.
                current_data.append(paragraph.text.strip())
        
        second_last_paragraph = last_paragraph
        last_paragraph = paragraph.text.strip()

    # Add the last plant data after the loop ends
    if current_plant_data:
        if current_data:
            current_plant_data[current_attribute] = " / ".join(current_data)
        plant_data_list.append(current_plant_data)


    return plant_data_list

def write_to_csv(plant_data_list, csv_file_path):
    with open(csv_file_path, mode="w", newline="", encoding="utf-8-sig") as file:
        writer = csv.DictWriter(file, fieldnames=attributes)
        writer.writeheader()
        for plant_data in plant_data_list:
            writer.writerow(plant_data)

# Example usage
document = Document("COMPLET - Les herbes communes - P Sterckx.docx")
plant_data_list = extract_plant_data(document)

csv_file_path = "plantes.csv"
write_to_csv(plant_data_list, csv_file_path)
print("Les données ont été enregistrées dans le fichier CSV avec succès !")