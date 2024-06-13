-- Uncomment variables and assign them the corresponding value for manual use.
-- :setvar DataBaseName "your_database_name"

use $(DataBaseName)
GO

-- DROP COLUMN KEY
DROP COLUMN ENCRYPTION KEY CEK_EXAMPLE;
GO
PRINT '> The COLUMN MASTER KEY has been removed.';
GO
DROP COLUMN MASTER KEY CMK_EXAMPLE;
GO
PRINT '> The COLUMN ENCRYPTION KEY has been removed.';
GO
