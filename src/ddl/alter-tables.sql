ALTER TABLE [Users] ADD
CONSTRAINT [PK_User] PRIMARY KEY  CLUSTERED ([idUser] ASC)
GO
ALTER TABLE [Roles] ADD
CONSTRAINT [PK_Role] PRIMARY KEY  CLUSTERED ([idRole] ASC)
GO
ALTER TABLE [Users] ADD
    CONSTRAINT [FK_Users_Roles] FOREIGN KEY ([idRole]) REFERENCES [Roles]([idRole])
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
GO
