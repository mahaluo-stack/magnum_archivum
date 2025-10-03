USE ars_disciplina
GO

CREATE OR ALTER PROCEDURE instrumentorum.adfero_genus_instrumenti @via_tabula VARCHAR(4000)
AS
BEGIN
    BEGIN TRANSACTION
        SET NOCOUNT ON;

        DECLARE @tabula VARCHAR(MAX) = @via_tabula + '\instrumentorum\genus_instrumenti.csv';
        DECLARE @scriptum NVARCHAR(MAX);

        DROP TABLE IF EXISTS #gradus_genus_instrumenti;
        CREATE TABLE #gradus_genus_instrumenti
        (
            nomen_genus_instrumenti VARCHAR(50) NOT NULL
        );

        SET @scriptum = N'
        BULK INSERT #gradus_genus_instrumenti
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

        INSERT INTO instrumentorum.genus_instrumenti(nomen_genus_instrumenti,
                                                     creatio)
        SELECT ggi.nomen_genus_instrumenti,
               SYSDATETIME() AS creatio
        FROM #gradus_genus_instrumenti ggi;

        DROP TABLE #gradus_genus_instrumenti;
    COMMIT TRANSACTION;
END
GO