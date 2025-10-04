USE ars_disciplina;

DROP TABLE IF EXISTS instrumentorum.genus_instrumenti;
CREATE TABLE instrumentorum.genus_instrumenti
(
    genus_instrumenti_identitas INT IDENTITY PRIMARY KEY,
    nomen_genus_instrumenti     VARCHAR(50) NOT NULL,
    creatio                     DATETIME2(0) DEFAULT SYSDATETIME()
);