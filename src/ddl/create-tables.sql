CREATE TABLE [Users]
(
    [idUser]                          INTEGER IDENTITY(1,1) NOT NULL,
    [firstName]                       VARCHAR(100) NULL,
    [lastName]                        VARCHAR(100) NULL,
    [email]                           VARCHAR(50) NULL,
    [birthdate]                       DATETIME NULL,
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
