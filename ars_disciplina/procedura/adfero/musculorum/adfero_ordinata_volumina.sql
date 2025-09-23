USE musculorum
GO

CREATE OR ALTER PROCEDURE musculorum.adfero_ordinata_volumina
AS
BEGIN
    EXECUTE musculorum.adfero_musculi_regio;
    EXECUTE musculorum.adfero_musculi;
    EXECUTE musculorum.adfero_musculi_pars;
END
GO