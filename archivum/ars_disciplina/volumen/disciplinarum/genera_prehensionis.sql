USE ars_disciplina;

DROP TABLE IF EXISTS disciplinarum.genera_prehensionis;
CREATE TABLE disciplinarum.genera_prehensionis
(
    genera_prehensionis_identitas INT IDENTITY PRIMARY KEY,
    nomen_genus_prehensionis      VARCHAR(50)   NOT NULL,
    descriptio                    VARCHAR(4000) NULL,
    creatio                       DATETIME2(0) DEFAULT SYSDATETIME()
);