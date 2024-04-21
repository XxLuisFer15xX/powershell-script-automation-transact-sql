CREATE TABLE [Users]
(
    [idUser]                          INTEGER IDENTITY(1,1) NOT NULL,
    [firstName]                       VARCHAR(100) NULL,
    [lastName]                        VARCHAR(100) NULL,
    [email]                           VARCHAR(100) NULL,
    [birthdate]                       DATETIME NULL,
    [idRole]                          INTEGER NULL,
)
GO
CREATE TABLE [Roles]
(
    [idRole]                          INTEGER IDENTITY(1,1) NOT NULL,
    [name]                            VARCHAR(100) NULL,
    [description]                     VARCHAR(500) NULL,
)
GO
