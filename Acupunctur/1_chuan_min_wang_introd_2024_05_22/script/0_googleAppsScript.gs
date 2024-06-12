/***
 * 0 = Zone x \n Points * [image]
 *   = 11.01 Da Jian (grande distance)
 */

// const DOC = "1wsz4lESiMJ9T0Dql6fWzQQ_gikgqMYlGgQ48yIEkTbg"   //1-COMPLET - Les meilleurs points de Tung Robert Chu
// const REGEX_TITRE = /.*(?!一)[\u4E00-\u9FFF].*/;

// const DOC = "1iUuZ5HVa72j55CEhiJum3j3f5wzOI5AihobhlL24ZVQ"   //2-Étude des points d’acupuncture hors canaux réguliers - Dongshi zhenjiu zhinan - Raphaël Gallo-Bona 
// const REGEX_TITRE = /^[\s]*[Zz]one.+–/;

// const DOC = "1My4dLb56DbdMyhtLLuTUouI6x6XR4iHprW18esl2KCE"    //3-COMPLET - Atlas pratique de l'acupuncture de Tung - Henri McCann
// const REGEX_TITRE = /^\s*\d+[\.\s]+\d+[\s\w]+[\(\w\s\)]+/;

// const DOC = "1o8PLE2EZOixVA-yqOf6do8E_LVMBTUW_0qG8YQj0vso"   //4-COMPLET - Lectures sur l'acupuncture de Tung - Etude des points 
// const REGEX_TITRE = /^\s*\d+[\.\s]+\d+[\s\w]+[\(\w\s\)]+/;

// const DOC = "1C2rXZF7Pc6SWNx9zNR8iW4lYTMFEj6QZmy2zRue4SZw"    //5-COMPLET - Chuan Min Wang - Introduction à l'acupuncture de Tung
// const REGEX_TITRE = /^\s*\d+[\.\s]+\d+[\s\w]+[\(\w\s\)]+/;

//  ---------

// const DOC = "18QD-JqRlEpdxX7o7h3N0Zz7lMnZd3aSIUFxDPF09q0k"   // INFOS_-_Chuan_Min_Wang_-_Introduction_a_lacupuncture_de_Tung
// const REGEX_TITRE = /^\d+\s*\.+\d+.*\(+.*\)*\s*[\u4E00-\u9FFF]+/;

const DOC = "1ZTxmkZIOFQl2Rg82os2BOQMCUEarS_STn3eIa7VWK3U"   // INFOS_-_Lectures_sur_lacupuncture_de_Tung_-_Etude_des_points_
const REGEX_TITRE = /^\s*.{1,5}\.+\d+[\s\w]+/;

// const DOC = "11_qPTQ-z867Q3ID2sRDIZ1IardLmx2MbcRHiKjJHLmI"   // INFOS_-_Atlas_pratique_de_lacupuncture_de_Tung_-_Henri_McCann.docx
// const REGEX_TITRE = /^\s*[\w\.\s]+[^:]{0,10}\(+.*\)+\s*$/;



const REGEX_IMG = /\[IMG_P?_?[0-9]+\]/g;
// const REGEX_TITRE = /[\w\s]+[\u4E00-\u9FFF]+.*/;               // OK début
// const REGEX_TITRE = /^[\w\s]+[\u4E00-\u9FFF]+.{0,2}[\w\s]*/i;  // a voir fin




// ===============
// remplacer / par | pour les texte bdd (car nom d'image pas de slash)
// ===============



// DEBUT DU PROGRAMME 


// 1-COMPLET - Les meilleurs points de Tung Robert Chu
// 2-Étude des points d’acupuncture hors canaux réguliers - Dongshi zhenjiu zhinan - Raphaël Gallo-Bona 

function main() {
  // imageNum()
  textRecup()
  // imageNumSheet()
  // imageNom()
  // imageRecup()
}

// ====================================================================================== 1- ajout texte image
function imageNum() {
  var body = DocumentApp.openById(DOC).getBody();
  var paragraphs = body.getParagraphs();
  var index = 1;
  
  for (var i = 0; i < paragraphs.length; i++) {
    var paragraph = paragraphs[i];
    var elements = paragraph.getNumChildren();
    
    for (var j = 0; j < elements; j++) {
      var element = paragraph.getChild(j);
      
      if (element.getType() == DocumentApp.ElementType.INLINE_IMAGE) {
        var text = "[IMG_" + index + "]";
        paragraph.appendText("\n" + text);
        index++;
        break; // Sortir de la boucle interne après avoir ajouté le texte sous l'image
      }
    }
  }
  positionedImage();
}
function positionedImage() {
  var doc = DocumentApp.openById(DOC);
  var body = doc.getBody();
  var index = 1;

  // Parcourir tous les éléments du document
  var paragraphs = body.getParagraphs();
  for (var i = 0; i < paragraphs.length; i++) {
    var paragraph = paragraphs[i];
    var images = paragraph.getPositionedImages();

    // Parcourir toutes les images ancrées au paragraphe
    for (var j = 0; j < images.length; j++) {
      // Insérer le texte de numérotation après l'image
      var text = "[IMG_P_" + index + "]";
      paragraph.appendText("\n" + text);
      index++;
    }
  }
}
// ======================================================================================





// ====================================================================================== 2- recup text pour sheet
function textRecup() {
  var doc = DocumentApp.openById(DOC);
  var body = doc.getBody();
  var nomDuDocument = doc.getName(); // Obtenir le nom du document
  
  // Expression régulière pour le délimiteur
  var regexDelimiteur = REGEX_TITRE;
  
  var blocs = [];
  var currentBlocName = '';
  var currentBlocContent = [];

  var numElements = body.getNumChildren();
  for (var i = 0; i < numElements; i++) {
    var element = body.getChild(i);

    // Vérifier le type de l'élément
    if (element.getType() === DocumentApp.ElementType.PARAGRAPH) {
      var text = element.getText();
      if (regexDelimiteur.test(text)) {
        // Si le texte correspond au délimiteur, c'est le début d'un nouveau bloc
        if (currentBlocName !== '') {
          // Enregistrer le bloc précédent s'il existe
          blocs.push({ name: currentBlocName, content: currentBlocContent.join('\n') });
        }
        // Réinitialiser les variables pour le nouveau bloc
        currentBlocName = text;
        currentBlocContent = [];
      } else {
        // Ajouter le texte à contenu du bloc actuel
        currentBlocContent.push(text);
      }
    }
  }

  // Enregistrer le dernier bloc
  if (currentBlocName !== '') {
    blocs.push({ name: currentBlocName, content: currentBlocContent.join('\n') });
  }

  // Enregistrer les blocs dans Google Sheets
  var classeur = SpreadsheetApp.getActiveSpreadsheet();
  var feuille = classeur.getSheetByName(nomDuDocument);  
  if (!feuille) {
    feuille = classeur.insertSheet(nomDuDocument);
  } else {
    feuille.clear(); // Effacer la feuille si elle existe déjà
  }

  // Écrire les blocs dans la feuille de calcul
  blocs.forEach(function(bloc, index) {
    // Vérifier la longueur du contenu avant de l'insérer dans la feuille de calcul
    // var contentToInsert = bloc.content.substring(0, 1); // Tronquer le contenu à 50000 caractères maximum
    feuille.getRange('A' + (index + 1)).setValue(bloc.name);
    feuille.getRange('B' + (index + 1)).setValue(bloc.content);
    // feuille.getRange('B' + (index + 1)).setValue(contentToInsert);
  });

  // imageNum();
  // extraireTexteSpecifique();
}
// ======================================================================================




// ====================================================================================== 3- img colonne sheet
function imageNumSheet() {
  var feuille = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var plageDonnees = feuille.getRange("B1:B" + feuille.getLastRow());
  var donnees = plageDonnees.getValues();
  var valeursACopier = [];
  
  // Boucle à travers toutes les valeurs de la colonne B
  for (var i = 0; i < donnees.length; i++) {
    var valeurB = donnees[i][0]; // Valeur dans la colonne B
    
    // Utilisation d'une expression régulière pour trouver les valeurs désirées
    var regex = REGEX_IMG; // Remplacez "votre_regex" par votre expression régulière
    var correspondances = valeurB.match(regex);
    
    if (correspondances != null) {
      var valeursCorrespondantes = correspondances.join(", "); // Joindre les valeurs correspondantes avec des virgules
      valeursACopier.push([valeursCorrespondantes]);
    } else {
      valeursACopier.push([""]); // Ajouter une chaîne vide si aucune correspondance
    }
  }
  
  // Définir les valeurs dans la colonne C
  feuille.getRange(1, 3, valeursACopier.length, 1).setValues(valeursACopier);
}
// ====================================================================================== 




// ====================================================================================== 3.5 sheet nom image
function imageNom() {
  var feuille = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var plageA = feuille.getRange("A1:A"); // Sélectionne toute la colonne A
  var valeursA = plageA.getValues(); // Obtient les valeurs de la colonne A
  
  var valeursD = []; // Tableau pour stocker les valeurs à copier dans la colonne D
  
  for (var i = 0; i < valeursA.length; i++) {
    var valeur = valeursA[i][0]; // Obtient la valeur de la cellule dans la colonne A
    var valeurCopiee = valeur.slice(0, 100); // Récupère les 100 premiers caractères de la valeur
    valeursD.push([valeurCopiee]); // Ajoute la valeur copiée au tableau valeursD
  }
  
  var plageD = feuille.getRange(1, 4, valeursD.length, 1); // Sélectionne la plage dans la colonne D
  plageD.setValues(valeursD); // Copie les valeurs dans la colonne D
}
// ====================================================================================== 





// ====================================================================================== 4- recup images
function imageRecup() {
  // Récupérer la feuille de calcul active
  var feuille = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var nomsImages = feuille.getRange("C1:C" + feuille.getLastRow()).getValues();
  var valeursColonneD = feuille.getRange("D1:D" + feuille.getLastRow()).getValues();

  // Récupérer le document Google Docs
  var doc = DocumentApp.openById(DOC);
  var body = doc.getBody();
  var nomDoc = doc.getName();

  var dossierImages = createDirectory();
  var dossierImagesBlob = []; // Tableau pour stocker les blobs des images

  // Parcourir chaque paragraphe du document
  var paragraphs = body.getParagraphs();
  for (var i = 0; i < paragraphs.length; i++) {
    var paragraph = paragraphs[i];
    var text = paragraph.getText().trim();
    if (text.match(REGEX_IMG)) {
      if (paragraph) {
        var nbChildren = paragraph.getNumChildren();
        for (var j = 0; j < nbChildren; j++) {
          var child = paragraph.getChild(j);
          if (child.getType() === DocumentApp.ElementType.INLINE_IMAGE) {
            var image = child.asInlineImage();
            var imageBlob = image.getBlob().setName(genererNomImage(text, nomsImages, valeursColonneD) + ".png");
            dossierImagesBlob.push(imageBlob); // Stocker le blob de l'image dans le tableau
            break; // Sortir de la boucle une fois que l'image a été trouvée
          }
        }
      }
    }
  }

  // Positionned images recup

  dossierImagesBlob =  dossierImagesBlob.concat(imageRecupPositionned())
  // Créer un seul blob contenant toutes les images
  var blobToutesImages = Utilities.zip(dossierImagesBlob, nomDoc + ".zip");
  // Créer un seul fichier contenant toutes les images dans le dossier
  dossierImages.createFile(blobToutesImages);
}

function imageRecupPositionned() {
  // Récupérer la feuille de calcul active
  var feuille = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  var nomsImages = feuille.getRange("C1:C" + feuille.getLastRow()).getValues();
  var valeursColonneD = feuille.getRange("D1:D" + feuille.getLastRow()).getValues();

  // Récupérer le document Google Docs
  var doc = DocumentApp.openById(DOC);
  var body = doc.getBody();
  var nomDoc = doc.getName();

  var dossierImages = createDirectory();
  var dossierImagesBlob = []; // Tableau pour stocker les blobs des images

  // Parcourir chaque paragraphe du document
  var paragraphs = body.getParagraphs();
  for (var i = 0; i < paragraphs.length; i++) {
    var paragraph = paragraphs[i];
    var text = paragraph.getText().trim();
    if (text.match(REGEX_IMG)) {
      if (paragraph) {
        var positionedImages = paragraph.getPositionedImages();
        for (var j = 0; j < positionedImages.length; j++) {
          var positionedImage = positionedImages[j];
          var imageBlob = positionedImage.getBlob().setName(genererNomImage(text, nomsImages, valeursColonneD) + ".png");
          dossierImagesBlob.push(imageBlob); // Stocker le blob de l'image dans le tableau
        }
      }
    }
  }

  return dossierImagesBlob;
}

function genererNomImage(text, nomsImages, valeursColonneD) {
  for (var i = 0; i < nomsImages.length; i++) {
    if (nomsImages[i][0].includes(text)) {
      var nomPoint = valeursColonneD[i][0].replace(/\/+/g, '|'); // Retirer les crochets du nom de l'image
      return text + "_" + nomPoint;
    }
  }
  return text; // Retourner le texte d'origine si aucune correspondance trouvée
}

function createDirectory() {
  // Obtenir le dossier parent du script
  var parentFolder = DriveApp.getFileById(SpreadsheetApp.getActiveSpreadsheet().getId()).getParents().next();

  // Définir le nom du dossier
  var nomDossierImages = "Images";

  // Rechercher le dossier par son nom
  var dossiers = parentFolder.getFoldersByName(nomDossierImages);

  var dossier;
  // Vérifier si le dossier existe
  if (dossiers.hasNext()) {
    // Le dossier existe déjà, obtenir sa référence
    dossier = dossiers.next();
  } else {
    // Le dossier n'existe pas, le créer
    dossier = parentFolder.createFolder(nomDossierImages);
  }

  return dossier;
}
// ====================================================================================== 








