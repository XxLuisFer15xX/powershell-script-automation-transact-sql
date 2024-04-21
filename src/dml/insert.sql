INSERT INTO Roles (
    name,
    description,
    createdBy,
    createdAt,
    status
) VALUES
('Super Usuario', 'Usuario que por defecto, cuenta con todos los privilegios para acceder al sistema.', 'system', GETDATE(), 1),
('Administrador de Usuarios', 'Usuario tiene acceso a la visualización y gestión de todos los usuarios del sistema.', 'system', GETDATE(), 1);

INSERT INTO Users (
    firstName,
    lastName,
    email,
    birthdate,
    idRole,
    createdBy,
    createdAt,
    status
) VALUES
('John', 'Doe', 'jdoe@example.com', '2000-01-01', 1, 'system', GETDATE(), 1);