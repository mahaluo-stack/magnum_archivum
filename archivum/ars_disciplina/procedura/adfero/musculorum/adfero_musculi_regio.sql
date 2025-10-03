USE ars_disciplina
GO

CREATE OR ALTER PROCEDURE musculorum.adfero_musculi_regio @via_tabula VARCHAR(4000)
AS
BEGIN
    BEGIN TRANSACTION
        SET NOCOUNT ON;

        DECLARE @tabula VARCHAR(MAX) = @via_tabula + '\musculorum\musculi_regio.csv';
        DECLARE @scriptum NVARCHAR(MAX);

        DROP TABLE IF EXISTS #gradus_musculi_regio;
        CREATE TABLE #gradus_musculi_regio
        (
            nomen_musculi_regio VARCHAR(50)   NOT NULL,
            descriptio          VARCHAR(4000) NOT NULL
        )

        SET @scriptum = N'
        BULK INSERT #gradus_musculi_regio
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

        INSERT INTO musculorum.musculi_regio(nomen_musculi_regio,
                                             descriptio,
                                             creatio)
        SELECT gmr.nomen_musculi_regio,
               gmr.descriptio,
               SYSDATETIME() AS creatio
        FROM #gradus_musculi_regio gmr;

        DROP TABLE #gradus_musculi_regio;
    COMMIT TRANSACTION;
END
GO