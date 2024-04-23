-- Uncomment variables and assign them the corresponding value for manual use.
-- :setvar DataBaseName "your_database_name"
-- :setvar FullScriptDir "C:\your_path\example-db"

use $(DataBaseName)
GO

:r $(FullScriptDir)\src\sp\sp_roles.sql
GO
:r $(FullScriptDir)\src\sp\sp_users.sql
GO
PRINT '> The stored procedures were created.';
GO
