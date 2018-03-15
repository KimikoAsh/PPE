DROP DATABASE IF EXISTS Auto_ecoleCa;

CREATE DATABASE IF NOT EXISTS Auto_ecoleCa;
USE Auto_ecoleCa;
# -----------------------------------------------------------------------------
#       TABLE : MONITEURS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS MONITEURS
 (
   IDM CHAR(32) NOT NULL  ,
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
#       TABLE : ETUDIANT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETUDIANT
 (
   ID_C VARCHAR(32) NOT NULL  ,
   ECOLE VARCHAR(20) NULL  ,
   NOM_ECOLE VARCHAR(128) NULL  ,
   ADRESSE_ETABLISSEMENT CHAR(128) NULL  ,
   REDUCTION SMALLINT NULL  ,
   NOM CHAR(32) NULL  ,
   PRENOM CHAR(32) NULL  ,
   DATENAISS DATE NULL  ,
   ADRESSE CHAR(32) NULL  
   , PRIMARY KEY (ID_C) 
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
   IDV CHAR(32) NOT NULL  ,
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
#       TABLE : SALARIÉ
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SALARIÉ
 (
   ID_C VARCHAR(32) NOT NULL  ,
   FONCTION CHAR(32) NULL  ,
   NOM CHAR(32) NULL  ,
   PRENOM CHAR(32) NULL  ,
   DATENAISS DATE NULL  ,
   ADRESSE CHAR(32) NULL  
   , PRIMARY KEY (ID_C) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : CANDIDATS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS CANDIDATS
 (
   ID_C VARCHAR(32) NOT NULL  ,
   NOM CHAR(32) NULL  ,
   PRENOM CHAR(32) NULL  ,
   DATENAISS DATE NULL  ,
   ADRESSE CHAR(32) NULL  
   , PRIMARY KEY (ID_C) 
 ) 
 comment = "";

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
#       TABLE : LEÇONS
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS LEÇONS
 (
   NUM_LEÇON CHAR(3) NOT NULL  ,
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
   ID_C VARCHAR(32) NOT NULL  ,
   REFERENCE_EXAM VARCHAR(32) NOT NULL  ,
   DATEH_EXAM CHAR(32) NULL  ,
   RESULTAT CHAR(32) NULL  
   , PRIMARY KEY (ID_C,REFERENCE_EXAM) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PASSER_CODE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PASSER_CODE_CANDIDATS
     ON PASSER_CODE (ID_C ASC);

CREATE  INDEX I_FK_PASSER_CODE_CODE
     ON PASSER_CODE (REFERENCE_EXAM ASC);

# -----------------------------------------------------------------------------
#       TABLE : PLANNING
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PLANNING
 (
   ID_C VARCHAR(32) NOT NULL  ,
   IDM CHAR(32) NOT NULL  ,
   NUM_LEÇON CHAR(3) NOT NULL  ,
   DATEHEURED CHAR(32) NOT NULL  ,
   DATEHEUREF DATETIME NULL  
   , PRIMARY KEY (ID_C,IDM,NUM_LEÇON,DATEHEURED) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PLANNING
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PLANNING_CANDIDATS
     ON PLANNING (ID_C ASC);

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
   ID_C VARCHAR(32) NOT NULL  ,
   TYPEP CHAR(32) NOT NULL  ,
   PRIX BIGINT(6) NULL  ,
   DATEEXAM DATE NULL  
   , PRIMARY KEY (ID_C,TYPEP) 
 ) 
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PASSER
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_PASSER_CANDIDATS
     ON PASSER (ID_C ASC);

CREATE  INDEX I_FK_PASSER_PERMIS
     ON PASSER (TYPEP ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE MONITEURS 
  ADD FOREIGN KEY FK_MONITEURS_VOITURE (IDV)
      REFERENCES VOITURE (IDV) ;


ALTER TABLE ETUDIANT 
  ADD FOREIGN KEY FK_ETUDIANT_CANDIDATS (ID_C)
      REFERENCES CANDIDATS (ID_C) ;


ALTER TABLE VOITURE 
  ADD FOREIGN KEY FK_VOITURE_MODELE (CODE_M)
      REFERENCES MODELE (CODE_M) ;


ALTER TABLE SALARIÉ 
  ADD FOREIGN KEY FK_SALARIÉ_CANDIDATS (ID_C)
      REFERENCES CANDIDATS (ID_C) ;


ALTER TABLE ROULER 
  ADD FOREIGN KEY FK_ROULER_MOIS (NUM)
      REFERENCES MOIS (NUM) ;


ALTER TABLE ROULER 
  ADD FOREIGN KEY FK_ROULER_VOITURE (IDV)
      REFERENCES VOITURE (IDV) ;


ALTER TABLE PASSER_CODE 
  ADD FOREIGN KEY FK_PASSER_CODE_CANDIDATS (ID_C)
      REFERENCES CANDIDATS (ID_C) ;


ALTER TABLE PASSER_CODE 
  ADD FOREIGN KEY FK_PASSER_CODE_CODE (REFERENCE_EXAM)
      REFERENCES CODE (REFERENCE_EXAM) ;


ALTER TABLE PLANNING 
  ADD FOREIGN KEY FK_PLANNING_CANDIDATS (ID_C)
      REFERENCES CANDIDATS (ID_C) ;


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
  ADD FOREIGN KEY FK_PASSER_CANDIDATS (ID_C)
      REFERENCES CANDIDATS (ID_C) ;


ALTER TABLE PASSER 
  ADD FOREIGN KEY FK_PASSER_PERMIS (TYPEP)
      REFERENCES PERMIS (TYPEP) ;

