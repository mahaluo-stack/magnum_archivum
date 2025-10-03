USE ars_disciplina;

DROP TABLE IF EXISTS musculorum.musculi_pars;
CREATE TABLE musculorum.musculi_pars
(
    musculi_pars_identitas INT IDENTITY PRIMARY KEY,
    musculi_identitas      INT          NOT NULL,
    nomen_musculi_pars     VARCHAR(50)  NOT NULL,
    descriptio             VARCHAR(4000) NULL,
    creatio                DATETIME2(0) DEFAULT SYSUTCDATETIME()
);