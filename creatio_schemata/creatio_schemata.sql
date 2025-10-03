USE master;
GO

DECLARE @nomen_archivum SYSNAME, @nomen_schemata SYSNAME;
DECLARE db_cursor CURSOR FAST_FORWARD FOR
    SELECT nomen_archivum, nomen_schemata
    FROM dbo.schemata_catalogus;

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @nomen_archivum, @nomen_schemata;

WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @sql NVARCHAR(MAX) =
            N'USE [' + @nomen_archivum + N'];
          IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = ''' + @nomen_schemata + N''')
              EXEC(''CREATE SCHEMA [' + @nomen_schemata + N']'');';
        EXEC (@sql);
        FETCH NEXT FROM db_cursor INTO @nomen_archivum, @nomen_schemata;
    END;

CLOSE db_cursor;
DEALLOCATE db_cursor;
