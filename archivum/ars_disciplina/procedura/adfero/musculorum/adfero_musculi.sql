USE ars_disciplina
GO

CREATE OR ALTER PROCEDURE musculorum.adfero_musculi @via_tabula VARCHAR(4000)
AS
BEGIN
    BEGIN TRANSACTION
        SET NOCOUNT ON;

        DECLARE @tabula VARCHAR(MAX) = @via_tabula + '\musculorum\musculi.csv';
        DECLARE @scriptum NVARCHAR(MAX);

        DROP TABLE IF EXISTS #gradus_musculi;
        CREATE TABLE #gradus_musculi
        (
            nomen_musculi_regio VARCHAR(50)  NOT NULL,
            nomen_musculi       VARCHAR(50)  NOT NULL,
            descriptio          VARCHAR(MAX) NULL
        );

        SET @scriptum = N'
        BULK INSERT #gradus_musculi
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

        INSERT INTO musculorum.musculi(musculi_regio_identitas,
                                       nomen_musculi,
                                       descriptio,
                                       creatio)
        SELECT mr.musculi_regio_identitas,
               gm.nomen_musculi,
               gm.descriptio,
               SYSDATETIME() AS creatio
        FROM #gradus_musculi gm
                 INNER JOIN musculorum.musculi_regio mr
                            ON gm.nomen_musculi_regio = mr.nomen_musculi_regio;

        DROP TABLE #gradus_musculi;
    COMMIT TRANSACTION;
END
GO