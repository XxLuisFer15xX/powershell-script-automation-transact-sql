DECLARE
	@pnTypeResult			INT,
	@pcResult 				VARCHAR(MAX),
	@pcMessage 				VARCHAR(MAX)
;

EXEC sp_users
	1, -- @pnTipoOperacion
	'jdoe@example.com', -- @pcUser

	NULL, -- @pnIdUser
	NULL, -- @pcFirstName
	NULL, -- @pcLastName
	NULL, -- @pcEmail
	NULL, -- @pdBirthdate
	NULL, -- @pnIdRole
	NULL, -- @pnStatus

	@pnTypeResult OUTPUT,
	@pcResult OUTPUT,
	@pcMessage OUTPUT
;

SELECT @pnTypeResult AS pnTypeResult;
SELECT @pcResult AS pcResult;
SELECT @pcMessage AS pcMessage;

-- SELECT * FROM Users;
