USE ars_disciplina
GO

CREATE OR ALTER PROCEDURE instrumentorum.adfero_instrumenta @via_tabula VARCHAR(4000)
AS
BEGIN
    BEGIN TRANSACTION
        SET NOCOUNT ON;

        DECLARE @tabula VARCHAR(MAX) = @via_tabula + '\instrumentorum\instrumenta.csv';
        DECLARE @scriptum NVARCHAR(MAX);

        DROP TABLE IF EXISTS #gradus_instrumenta;
        CREATE TABLE #gradus_instrumenta
        (
            nomen_instrumenti VARCHAR(50)   NOT NULL,
            descriptio        VARCHAR(4000) NULL
        );

        SET @scriptum = N'
        BULK INSERT #gradus_instrumenta
        FROM ''' + @tabula + N'''
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = '';'',
            ROWTERMINATOR = ''\n'',
            TABLOCK,
            KEEPNULLS
        );';

        EXEC sp_executesql @scriptum;

        INSERT INTO instrumentorum.instrumenta(nomen_instrumenti,
                                               descriptio,
                                               creatio)
        SELECT gi.nomen_instrumenti,
               gi.descriptio,
               SYSDATETIME() AS creatio
        FROM #gradus_instrumenta gi;

        DROP TABLE #gradus_instrumenta;
    COMMIT TRANSACTION;
END
GO