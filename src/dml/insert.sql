INSERT INTO Roles (
    name,
    description
) VALUES
('Super Usuario', 'Usuario que por defecto, cuenta con todos los privilegios para acceder al sistema.'),
('Administrador de Usuarios', 'Usuario tiene acceso a la visualización y gestión de todos los usuarios del sistema.');

INSERT INTO Users (
    firstName,
    lastName,
    email,
    birthdate,
    idRole
) VALUES
('John', 'Doe', 'jdoe@example.com', '2000-01-01', 1);