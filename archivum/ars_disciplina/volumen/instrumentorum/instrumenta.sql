USE ars_disciplina;

DROP TABLE IF EXISTS instrumentorum.instrumenta;
CREATE TABLE instrumentorum.instrumenta
(
    instrumenta_identitas INT IDENTITY PRIMARY KEY,
    nomen_instrumenti     VARCHAR(50)   NOT NULL,
    descriptio            VARCHAR(4000) NULL,
    creatio               DATETIME2(0) DEFAULT SYSDATETIME()
);