-- Uncomment variables and assign them the corresponding value for manual use.
-- :setvar DataBaseName "your_database_name"
-- :setvar FullScriptDir "C:\your_path\example-db"

use $(DataBaseName)
GO

:r $(FullScriptDir)\src\ddl\create-tables.sql
GO
PRINT '> The tables have been created.';
GO
:r $(FullScriptDir)\src\ddl\alter-tables.sql
GO
PRINT '> The primary and foreign keys have been assigned to the tables.';
GO
