USE musculorum
GO

CREATE OR ALTER PROCEDURE musculorum.adfero_musculi_pars @via_tabula VARCHAR(4000)
AS
BEGIN
    BEGIN TRANSACTION
        SET NOCOUNT ON;

        DECLARE @tabula VARCHAR(MAX) = @via_tabula + '\musculi_pars.csv';
        DECLARE @scriptum NVARCHAR(MAX);

        DROP TABLE IF EXISTS #gradus_musculi_pars;
        CREATE TABLE #gradus_musculi_pars
        (
            nomen_musculi      VARCHAR(50)   NOT NULL,
            nomen_musculi_pars VARCHAR(50)   NOT NULL,
            descriptio         VARCHAR(4000) NULL
        )

        SET @scriptum = N'
        BULK INSERT #gradus_musculi_pars
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

        INSERT INTO musculorum.musculi_pars(musculi_identitas,
                                            nomen_musculi_pars,
                                            descriptio,
                                            creatio)
        SELECT m.musculi_identitas,
               gmp.nomen_musculi_pars,
               gmp.descriptio,
               SYSDATETIME()
        FROM #gradus_musculi_pars gmp
                 INNER JOIN musculorum.musculi m
                            ON gmp.nomen_musculi = m.nomen_musculi;

        DROP TABLE #gradus_musculi_pars;
    COMMIT TRANSACTION;
END
GO