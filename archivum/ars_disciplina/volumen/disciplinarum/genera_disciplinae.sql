USE ars_disciplina;

DROP TABLE IF EXISTS disciplinarum.genera_disciplina;
CREATE TABLE disciplinarum.genera_disciplina
(
    genera_disciplina_identitas INT IDENTITY PRIMARY KEY,
    nomen_genus_disciplinae     VARCHAR(50)   NOT NULL,
    descriptio                  VARCHAR(4000) NULL,
    creatio                     DATETIME2(0) DEFAULT SYSDATETIME()
);