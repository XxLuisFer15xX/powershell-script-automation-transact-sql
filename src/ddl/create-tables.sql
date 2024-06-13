CREATE TABLE [Users]
(
    [idUser]                          INTEGER IDENTITY(1,1) NOT NULL,
    [firstName]                       VARCHAR(100) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (ENCRYPTION_TYPE = DETERMINISTIC, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256', COLUMN_ENCRYPTION_KEY = CEK_EXAMPLE) NULL,
    [lastName]                        VARCHAR(100) COLLATE Latin1_General_BIN2 ENCRYPTED WITH (ENCRYPTION_TYPE = DETERMINISTIC, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256', COLUMN_ENCRYPTION_KEY = CEK_EXAMPLE) NULL,
    [email]                           VARCHAR(50) NULL,
    [birthdate]                       DATETIME ENCRYPTED WITH (ENCRYPTION_TYPE = DETERMINISTIC, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256', COLUMN_ENCRYPTION_KEY = CEK_EXAMPLE) NULL,
    [idRole]                          INTEGER NULL,
    -- Auditoría
    [createdBy]                       VARCHAR(50) NULL,
    [createdAt]                       DATETIME NULL,
    [modifiedBy]                      VARCHAR(50) NULL,
    [modifiedAt]                      DATETIME NULL,
    [status]                          INTEGER NULL
)
GO
CREATE TABLE [Roles]
(
    [idRole]                          INTEGER IDENTITY(1,1) NOT NULL,
    [name]                            VARCHAR(100) NULL,
    [description]                     VARCHAR(500) NULL,
    -- Auditoría
    [createdBy]                       VARCHAR(50) NULL,
    [createdAt]                       DATETIME NULL,
    [modifiedBy]                      VARCHAR(50) NULL,
    [modifiedAt]                      DATETIME NULL,
    [status]                          INTEGER NULL
)
GO
