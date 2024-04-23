-- Uncomment variables and assign them the corresponding value for manual use.
-- :setvar DataBaseName "your_database_name"
-- :setvar FullScriptDir "C:\your_path\example-db"

use $(DataBaseName)
GO

:r $(FullScriptDir)\src\functions\drops_rn.sql
PRINT '> The functions have been deleted';
GO
