-- -----------------------------------------------------------------------------
--             Génération d'une base de données pour
--                           PostgreSQL
--                        (15/1/2019 6:28:41)
-- -----------------------------------------------------------------------------
--      Nom de la base : CEF345DB
--      Projet : FE17A075S
--      Auteur : SONELF
--      Date de dernière modification : 15/1/2019 6:27:29
-- -----------------------------------------------------------------------------

--drop database CEF345DB;
-- -----------------------------------------------------------------------------
--       CREATION DE LA BASE 
-- -----------------------------------------------------------------------------

--CREATE DATABASE CEF345DB;

-- -----------------------------------------------------------------------------
--       TABLE : UV_TBL
-- -----------------------------------------------------------------------------

CREATE TABLE UV_TBL
   (
    CODE_UV varchar(128) NOT NULL  ,
    NAME_UV varchar(128) NOT NULL  ,
    NBR_OF_HOURS_UV int4 NOT NULL 
      DEFAULT 30    CHECK (NBR_OF_HOURS_UV BETWEEN 33 AND 45),
    CREDIT_UV int2 NOT NULL 
      DEFAULT 0    CHECK (CREDIT_UV BETWEEN 2 AND 9),
    TYPE_UV varchar(128) NOT NULL     CHECK (TYPE_UV IN ('O', 'R'))
,   CONSTRAINT PK_UV_TBL PRIMARY KEY (CODE_UV)
   );

-- -----------------------------------------------------------------------------
--       TABLE : TEACHER
-- -----------------------------------------------------------------------------

CREATE TABLE TEACHER
   (
    TEACHE_NAME char(32) NOT NULL  ,
    TEACHER_COURSE varchar(128) NOT NULL  ,
    TEACHER_HOURS int2 NOT NULL  
,   CONSTRAINT PK_TEACHER PRIMARY KEY (TEACHE_NAME)
   );

-- -----------------------------------------------------------------------------
--       TABLE : ROOM
-- -----------------------------------------------------------------------------

CREATE TABLE ROOM
   (
    ROOM_NBR varchar(128) NOT NULL  
,   CONSTRAINT PK_ROOM PRIMARY KEY (ROOM_NBR)
   );

-- -----------------------------------------------------------------------------
--       TABLE : STUDENTS_TBL
-- -----------------------------------------------------------------------------

CREATE TABLE STUDENTS_TBL
   (
    STD_MATRICULE varchar(128) NOT NULL  ,
    STD_NAME varchar(50) NOT NULL  ,
    STD_SEXE char(1) NOT NULL     CHECK (STD_SEXE IN ('M', 'F')),
    DATE_OF_BIRTH_STD date NOT NULL  
,   CONSTRAINT PK_STUDENTS_TBL PRIMARY KEY (STD_MATRICULE)
   );

-- -----------------------------------------------------------------------------
--       TABLE : REL_1
-- -----------------------------------------------------------------------------

CREATE TABLE REL_1
   (
    CODE_UV varchar(128) NOT NULL  ,
    ROOM_NBR varchar(128) NOT NULL  ,
    TEACHE_NAME char(32) NOT NULL  ,
    ROOM_NBR_1 varchar(128) NOT NULL  
,   CONSTRAINT PK_REL_1 PRIMARY KEY (CODE_UV, ROOM_NBR, TEACHE_NAME, ROOM_NBR_1)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE REL_1
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_REL_1_UV_TBL
     ON REL_1 (CODE_UV)
    ;

CREATE  INDEX I_FK_REL_1_ROOM
     ON REL_1 (ROOM_NBR)
    ;

CREATE  INDEX I_FK_REL_1_TEACHER
     ON REL_1 (TEACHE_NAME)
    ;

CREATE  INDEX I_FK_REL_1_ROOM1
     ON REL_1 (ROOM_NBR_1)
    ;

-- -----------------------------------------------------------------------------
--       TABLE : COMPOSE
-- -----------------------------------------------------------------------------

CREATE TABLE COMPOSE
   (
    STD_MATRICULE varchar(128) NOT NULL  ,
    CODE_UV varchar(128) NOT NULL  ,
    COMPOSE_DATE date NOT NULL  ,
    COMPOSE_NOTE varchar(128) NOT NULL  
,   CONSTRAINT PK_COMPOSE PRIMARY KEY (STD_MATRICULE, CODE_UV)
   );

-- -----------------------------------------------------------------------------
--       INDEX DE LA TABLE COMPOSE
-- -----------------------------------------------------------------------------

CREATE  INDEX I_FK_COMPOSE_STUDENTS_TBL
     ON COMPOSE (STD_MATRICULE)
    ;

CREATE  INDEX I_FK_COMPOSE_UV_TBL
     ON COMPOSE (CODE_UV)
    ;


-- -----------------------------------------------------------------------------
--       CREATION DES REFERENCES DE TABLE
-- -----------------------------------------------------------------------------


ALTER TABLE REL_1 ADD 
     CONSTRAINT FK_REL_1_UV_TBL
          FOREIGN KEY (CODE_UV)
               REFERENCES UV_TBL (CODE_UV);

ALTER TABLE REL_1 ADD 
     CONSTRAINT FK_REL_1_ROOM
          FOREIGN KEY (ROOM_NBR)
               REFERENCES ROOM (ROOM_NBR);

ALTER TABLE REL_1 ADD 
     CONSTRAINT FK_REL_1_TEACHER
          FOREIGN KEY (TEACHE_NAME)
               REFERENCES TEACHER (TEACHE_NAME);

ALTER TABLE REL_1 ADD 
     CONSTRAINT FK_REL_1_ROOM1
          FOREIGN KEY (ROOM_NBR_1)
               REFERENCES ROOM (ROOM_NBR);

ALTER TABLE COMPOSE ADD 
     CONSTRAINT FK_COMPOSE_STUDENTS_TBL
          FOREIGN KEY (STD_MATRICULE)
               REFERENCES STUDENTS_TBL (STD_MATRICULE);

ALTER TABLE COMPOSE ADD 
     CONSTRAINT FK_COMPOSE_UV_TBL
          FOREIGN KEY (CODE_UV)
               REFERENCES UV_TBL (CODE_UV);


-- -----------------------------------------------------------------------------
--                FIN DE GENERATION
-- -----------------------------------------------------------------------------