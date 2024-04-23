DECLARE
	@pnTypeResult			INT,
	@pcResult 				VARCHAR(MAX),
	@pcMessage 				VARCHAR(MAX)
;

EXEC sp_roles
	1, -- @pnTipoOperacion
	'jdoe@example.com', -- @pcUser

	NULL, -- @pnIdRole
	NULL, -- @pcName
	NULL, -- @pcDescription
	NULL, -- @pnStatus

	@pnTypeResult OUTPUT,
	@pcResult OUTPUT,
	@pcMessage OUTPUT
;

SELECT @pnTypeResult AS pnTypeResult;
SELECT @pcResult AS pcResult;
SELECT @pcMessage AS pcMessage;

-- SELECT * FROM Roles;
