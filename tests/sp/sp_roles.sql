DECLARE
	@pnTypeResult			INT,
	@pcResult 				VARCHAR(MAX),
	@pcMessage 				VARCHAR(MAX)
;

EXEC sp_roles
	-- Parámetros de operación
	1, -- @pnTipoOperacion
	'jdoe@example.com', -- @pcUser

	-- Parámetros que indican el valor de una columna en un registro
	NULL, -- @pnIdRole
	NULL, -- @pcName
	NULL, -- @pcDescription
	NULL, -- @pnStatus

	--  Parámetros de salida
	@pnTypeResult OUTPUT,
	@pcResult OUTPUT,
	@pcMessage OUTPUT
;

SELECT @pnTypeResult AS pnTypeResult;
SELECT @pcResult AS pcResult;
SELECT @pcMessage AS pcMessage;

-- SELECT * FROM Roles;
