-- Deshabilitar todas las restricciones de clave externa
EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';

-- Borrar todas las tablas
DECLARE @DropTableSQL NVARCHAR(MAX)
SET @DropTableSQL = ''

SELECT @DropTableSQL = @DropTableSQL + 'DROP TABLE ' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.tables;

EXEC sp_executesql @DropTableSQL;

-- Habilitar nuevamente todas las restricciones de clave externa
EXEC sp_msforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL';
