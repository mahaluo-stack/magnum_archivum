USE ars_disciplina;

DROP TABLE IF EXISTS musculorum.musculi_regio;
CREATE TABLE musculorum.musculi_regio
(
    musculi_regio_identitas INT IDENTITY PRIMARY KEY,
    nomen_musculi_regio     VARCHAR(50)   NOT NULL,
    descriptio              VARCHAR(4000) NULL,
    creatio                 DATETIME2(0) DEFAULT SYSUTCDATETIME()
);