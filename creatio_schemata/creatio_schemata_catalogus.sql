USE master;
GO

IF OBJECT_ID('dbo.schemata_catalogus', 'U') IS NOT NULL
    DROP TABLE dbo.schemata_catalogus;
GO

CREATE TABLE dbo.schemata_catalogus
(
    nomen_archivum SYSNAME NOT NULL,
    nomen_schemata SYSNAME NOT NULL,
    PRIMARY KEY (nomen_archivum, nomen_schemata)
);
GO

INSERT INTO dbo.schemata_catalogus (nomen_archivum, nomen_schemata)
VALUES ('ars_disciplina', 'musculorum'),
       ('ars_disciplina', 'instrumentorum'),
       ('ars_disciplina', 'disciplinarum'),
       ('ars_disciplina', 'actorum');
GO