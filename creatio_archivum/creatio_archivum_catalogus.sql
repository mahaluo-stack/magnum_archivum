USE master;
GO

IF OBJECT_ID('dbo.archivum_catalogus', 'U') IS NOT NULL
    DROP TABLE dbo.archivum_catalogus;
GO

CREATE TABLE dbo.archivum_catalogus
(
    nomen_archivum SYSNAME NOT NULL PRIMARY KEY,
);
GO

INSERT INTO dbo.archivum_catalogus (nomen_archivum)
VALUES ('ars_disciplina');
GO