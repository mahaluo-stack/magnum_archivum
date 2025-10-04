USE ars_disciplina;

DROP TABLE IF EXISTS musculorum.musculi;
CREATE TABLE musculorum.musculi
(
    musculi_identitas       INT IDENTITY PRIMARY KEY,
    musculi_regio_identitas INT           NOT NULL,
    nomen_musculi           VARCHAR(50)   NOT NULL,
    descriptio              VARCHAR(4000) NULL,
    creatio                 DATETIME2(0) DEFAULT SYSDATETIME()
);