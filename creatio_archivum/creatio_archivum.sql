USE master;
GO

SET NOCOUNT ON;

DECLARE @nomen SYSNAME;
DECLARE @delere NVARCHAR(MAX);
DECLARE @scriptum NVARCHAR(MAX);

DECLARE db_cursor CURSOR FAST_FORWARD FOR
    SELECT nomen_archivum
    FROM dbo.archivum_catalogus;

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @nomen;

WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @delere = N'IF EXISTS (SELECT 1 FROM sys.databases WHERE name = ''' + @nomen + ''')
                        BEGIN
                            ALTER DATABASE [' + @nomen + '] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                            DROP DATABASE [' + @nomen + '];
                        END';
        EXEC (@delere);

        SET @scriptum = N'CREATE DATABASE [' + @nomen + N'];';
        EXEC (@scriptum);

        FETCH NEXT FROM db_cursor INTO @nomen;
    END

CLOSE db_cursor;
DEALLOCATE db_cursor;
GO