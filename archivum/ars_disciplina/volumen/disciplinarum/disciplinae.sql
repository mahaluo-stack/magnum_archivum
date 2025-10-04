USE ars_disciplina;

DROP TABLE IF EXISTS disciplinarum.disciplinae;
CREATE TABLE disciplinarum.disciplinae
(
    disciplinae_identitas INT IDENTITY PRIMARY KEY,
    nomen_disciplinae     VARCHAR(50)   NOT NULL,
    descriptio            VARCHAR(4000) NULL,
    creatio               DATETIME2(0) DEFAULT SYSDATETIME()
);