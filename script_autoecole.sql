DROP DATABASE IF EXISTS ppe_autoecole;

CREATE DATABASE IF NOT EXISTS ppe_autoecole;
USE ppe_autoecole;
# -----------------------------------------------------------------------------
#       TABLE : MONITEURS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS MONITEURS
 (
   IDM CHAR(32) NOT NULL auto_increment ,
   IDV CHAR(32) NOT NULL  ,
   NOM CHAR(32) NULL  ,
   PRENOM CHAR(32) NULL  ,
   DATEEMB DATE NULL  ,
   ADRESSE CHAR(32) NULL  
   , PRIMARY KEY (IDM) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE MONITEURS
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_MONITEURS_VOITURE
     ON MONITEURS (IDV ASC);

# -----------------------------------------------------------------------------
#       TABLE : DATEL
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS DATEL
 (
   DATEHEURED CHAR(32) NOT NULL  
   , PRIMARY KEY (DATEHEURED) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : MOIS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS MOIS
 (
   NUM SMALLINT NOT NULL  ,
   ANNÉE SMALLINT NULL  
   , PRIMARY KEY (NUM) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CODE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CODE
 (
   REFERENCE_EXAM VARCHAR(32) NOT NULL  ,
   INTITULE CHAR(32) NULL  ,
   DESCRIPTION CHAR(32) NULL  
   , PRIMARY KEY (REFERENCE_EXAM) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : VOITURE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS VOITURE
 (
   IDV CHAR(32) NOT NULL auto_increment ,
   CODE_M SMALLINT NOT NULL  ,
   NB_MATRICUL CHAR(32) NULL  ,
   DATEACHAT DATE NULL  ,
   KILOMETRE_INI SMALLINT NULL  
   , PRIMARY KEY (IDV) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE VOITURE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_VOITURE_MODELE
     ON VOITURE (CODE_M ASC);

# -----------------------------------------------------------------------------
#       TABLE : CANDIDATS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CANDIDATS
 (
   CODE_CAT SMALLINT NOT NULL  ,
   ID_C VARCHAR(32) NOT NULL auto_increment ,
   NOM CHAR(32) NULL  ,
   PRENOM CHAR(32) NULL  ,
   DATENAISS DATE NULL  ,
   ADRESSE CHAR(32) NULL  
   , PRIMARY KEY (CODE_CAT,ID_C) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE CANDIDATS
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_CANDIDATS_CATEGORIE
     ON CANDIDATS (CODE_CAT ASC);

# -----------------------------------------------------------------------------
#       TABLE : PERMIS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PERMIS
 (
   TYPEP CHAR(32) NOT NULL  ,
   MODE CHAR(32) NULL  
   , PRIMARY KEY (TYPEP) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : MODELE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS MODELE
 (
   CODE_M SMALLINT NOT NULL  ,
   NOM_MODELE CHAR(32) NULL  ,
   ANNEE DATE NULL  
   , PRIMARY KEY (CODE_M) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CATEGORIE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CATEGORIE
 (
   CODE_CAT SMALLINT NOT NULL  ,
   FONCTION CHAR(32) NULL  
   , PRIMARY KEY (CODE_CAT) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : LEÇONS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LEÇONS
 (
   NUM_LEÇON CHAR(3) NOT NULL auto_increment ,
   LIBELLE CHAR(32) NULL  
   , PRIMARY KEY (NUM_LEÇON) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ROULER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ROULER
 (
   NUM SMALLINT NOT NULL  ,
   IDV CHAR(32) NOT NULL  ,
   NB_KILO INTEGER NULL  
   , PRIMARY KEY (NUM,IDV) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ROULER
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ROULER_MOIS
     ON ROULER (NUM ASC);

CREATE  INDEX I_FK_ROULER_VOITURE
     ON ROULER (IDV ASC);

# -----------------------------------------------------------------------------
#       TABLE : PASSER_CODE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PASSER_CODE
 (
   CODE_CAT SMALLINT NOT NULL  ,
   ID_C VARCHAR(32) NOT NULL  ,
   REFERENCE_EXAM VARCHAR(32) NOT NULL  ,
   DATEH_EXAM CHAR(32) NULL  ,
   RESULTAT CHAR(32) NULL  
   , PRIMARY KEY (CODE_CAT,ID_C,REFERENCE_EXAM) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PASSER_CODE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PASSER_CODE_CANDIDATS
     ON PASSER_CODE (CODE_CAT ASC,ID_C ASC);

CREATE  INDEX I_FK_PASSER_CODE_CODE
     ON PASSER_CODE (REFERENCE_EXAM ASC);

# -----------------------------------------------------------------------------
#       TABLE : PLANNING
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PLANNING
 (
   CODE_CAT SMALLINT NOT NULL  ,
   ID_C VARCHAR(32) NOT NULL  ,
   IDM CHAR(32) NOT NULL  ,
   NUM_LEÇON CHAR(3) NOT NULL  ,
   DATEHEURED CHAR(32) NOT NULL  ,
   DATEHEUREF DATETIME NULL  
   , PRIMARY KEY (CODE_CAT,ID_C,IDM,NUM_LEÇON,DATEHEURED) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PLANNING
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PLANNING_CANDIDATS
     ON PLANNING (CODE_CAT ASC,ID_C ASC);

CREATE  INDEX I_FK_PLANNING_MONITEURS
     ON PLANNING (IDM ASC);

CREATE  INDEX I_FK_PLANNING_LEÇONS
     ON PLANNING (NUM_LEÇON ASC);

CREATE  INDEX I_FK_PLANNING_DATEL
     ON PLANNING (DATEHEURED ASC);

# -----------------------------------------------------------------------------
#       TABLE : PASSER
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PASSER
 (
   CODE_CAT SMALLINT NOT NULL  ,
   ID_C VARCHAR(32) NOT NULL  ,
   TYPEP CHAR(32) NOT NULL  ,
   PRIX BIGINT(6) NULL  ,
   DATEEXAM DATE NULL  
   , PRIMARY KEY (CODE_CAT,ID_C,TYPEP) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PASSER
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PASSER_CANDIDATS
     ON PASSER (CODE_CAT ASC,ID_C ASC);

CREATE  INDEX I_FK_PASSER_PERMIS
     ON PASSER (TYPEP ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE MONITEURS 
  ADD FOREIGN KEY FK_MONITEURS_VOITURE (IDV)
      REFERENCES VOITURE (IDV) ;


ALTER TABLE VOITURE 
  ADD FOREIGN KEY FK_VOITURE_MODELE (CODE_M)
      REFERENCES MODELE (CODE_M) ;


ALTER TABLE CANDIDATS 
  ADD FOREIGN KEY FK_CANDIDATS_CATEGORIE (CODE_CAT)
      REFERENCES CATEGORIE (CODE_CAT) ;


ALTER TABLE ROULER 
  ADD FOREIGN KEY FK_ROULER_MOIS (NUM)
      REFERENCES MOIS (NUM) ;


ALTER TABLE ROULER 
  ADD FOREIGN KEY FK_ROULER_VOITURE (IDV)
      REFERENCES VOITURE (IDV) ;


ALTER TABLE PASSER_CODE 
  ADD FOREIGN KEY FK_PASSER_CODE_CANDIDATS (CODE_CAT,ID_C)
      REFERENCES CANDIDATS (CODE_CAT,ID_C) ;


ALTER TABLE PASSER_CODE 
  ADD FOREIGN KEY FK_PASSER_CODE_CODE (REFERENCE_EXAM)
      REFERENCES CODE (REFERENCE_EXAM) ;


ALTER TABLE PLANNING 
  ADD FOREIGN KEY FK_PLANNING_CANDIDATS (CODE_CAT,ID_C)
      REFERENCES CANDIDATS (CODE_CAT,ID_C) ;


ALTER TABLE PLANNING 
  ADD FOREIGN KEY FK_PLANNING_MONITEURS (IDM)
      REFERENCES MONITEURS (IDM) ;


ALTER TABLE PLANNING 
  ADD FOREIGN KEY FK_PLANNING_LEÇONS (NUM_LEÇON)
      REFERENCES LEÇONS (NUM_LEÇON) ;


ALTER TABLE PLANNING 
  ADD FOREIGN KEY FK_PLANNING_DATEL (DATEHEURED)
      REFERENCES DATEL (DATEHEURED) ;


ALTER TABLE PASSER 
  ADD FOREIGN KEY FK_PASSER_CANDIDATS (CODE_CAT,ID_C)
      REFERENCES CANDIDATS (CODE_CAT,ID_C) ;


ALTER TABLE PASSER 
  ADD FOREIGN KEY FK_PASSER_PERMIS (TYPEP)
      REFERENCES PERMIS (TYPEP) ;

