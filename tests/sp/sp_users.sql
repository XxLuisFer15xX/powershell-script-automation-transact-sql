DECLARE
	@pnTypeResult			INT,
	@pcResult 				VARCHAR(MAX),
	@pcMessage 				VARCHAR(MAX)
;

EXEC sp_users
	-- Parámetros de operación
	1, -- @pnTipoOperacion
	'jdoe@example.com', -- @pcUser

	-- Parámetros que indican el valor de una columna en un registro
	NULL, -- @pnIdUser
	NULL, -- @pcFirstName
	NULL, -- @pcLastName
	NULL, -- @pcEmail
	NULL, -- @pdBirthdate
	NULL, -- @pnIdRole
	NULL, -- @pnStatus

	--  Parámetros de salida
	@pnTypeResult OUTPUT,
	@pcResult OUTPUT,
	@pcMessage OUTPUT
;

SELECT @pnTypeResult AS pnTypeResult;
SELECT @pcResult AS pcResult;
SELECT @pcMessage AS pcMessage;

-- SELECT * FROM Users;
