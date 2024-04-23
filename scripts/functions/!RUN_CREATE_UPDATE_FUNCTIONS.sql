-- Uncomment variables and assign them the corresponding value for manual use.
-- :setvar DataBaseName "your_database_name"
-- :setvar FullScriptDir "C:\your_path\example-db"

use $(DataBaseName)
GO

:r $(FullScriptDir)\src\functions\rn_roles.sql
GO
:r $(FullScriptDir)\src\functions\rn_users.sql
GO
PRINT '> The functions have been created';
GO
