-- Borrar todas las funciones escalares, en línea y de tabla
DECLARE @DropFunctionSQL NVARCHAR(MAX)
SET @DropFunctionSQL = ''

SELECT @DropFunctionSQL = @DropFunctionSQL + 'DROP FUNCTION ' + QUOTENAME(name) + ';' + CHAR(13)
FROM sys.objects
WHERE type IN ('FN', 'IF', 'TF');

EXEC sp_executesql @DropFunctionSQL;
