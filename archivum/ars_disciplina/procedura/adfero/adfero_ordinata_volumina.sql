USE ars_disciplina
GO

CREATE OR ALTER PROCEDURE dbo.adfero_ordinata_volumina @via_tabula VARCHAR(4000)
AS
BEGIN
    EXECUTE musculorum.adfero_musculi_regio @via_tabula = @via_tabula;
    EXECUTE musculorum.adfero_musculi @via_tabula = @via_tabula;
    EXECUTE musculorum.adfero_musculi_pars @via_tabula = @via_tabula;

    EXECUTE instrumentorum.adfero_instrumenta @via_tabula = @via_tabula;
    EXECUTE instrumentorum.adfero_genus_instrumenti @via_tabula = @via_tabula;
END
GO