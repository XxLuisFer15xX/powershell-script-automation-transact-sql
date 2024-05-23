-- Borrar todos los procedimientos almacenados
DECLARE @DropProcedureSQL NVARCHAR(MAX)
SET @DropProcedureSQL = ''

SELECT @DropProcedureSQL = @DropProcedureSQL + 'DROP PROCEDURE ' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.procedures;

EXEC sp_executesql @DropProcedureSQL;
