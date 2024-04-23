CREATE OR ALTER FUNCTION [dbo].[rn_users] (
    -- Parámetros de operación
    @pnTipoOperacion INT, -- Parámetro del tipo de operación a realizar en el SP [1: Lectura | 2: Lectura Unitaria | 3: Creación | 4: Modificación | 5: Inactivación | 6: Eliminación]
    @pcUser VARCHAR(50) = NULL,

    -- Parámetros que indican el valor de una columna en un registro
    @pnIdUser INT = NULL,
    @pcFirstName VARCHAR(100) = NULL,
    @pcLastName VARCHAR(100) = NULL,
    @pcEmail VARCHAR(100) = NULL,
    @pdBirthdate DATETIME = NULL,
    @pnIdRole INT = NULL,
    @pnStatus INT = NULL
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    -- Mensaje de salida
    DECLARE @vcMessage                      VARCHAR(MAX) = '';
    DECLARE @vnConteo		                INT = 0;

    -- Códigos de operación
    DECLARE @cnOperacionLectura             INT = 1;
    DECLARE @cnOperacionLecturaUnitaria     INT = 2;
    DECLARE @cnOperacionCreacion            INT = 3;
    DECLARE @cnOperacionModificacion        INT = 4;
    DECLARE @cnOperacionInactivacion        INT = 5;
    DECLARE @cnOperacionEliminacion         INT = 6;

    -- Códigos de resultado
    DECLARE @cnResultadoExitoso             INT = 0;
    DECLARE @cnResultadErrorControlado      INT = 1;
    DECLARE @cnResultadErrorNoControlado    INT = 2;

    -- Códigos de estado de registros
    DECLARE @cnRegistroInactivo             INT = 0;
    DECLARE @cnRegistroActivo               INT = 1;

    -- Validaciónd de parámetros principales
    IF(@pnTipoOperacion IS NULL) BEGIN
        SET @vcMessage = @vcMessage + '@pnTipoOperacion, ';
    END;
    IF(@pcUser IS NULL) BEGIN
        SET @vcMessage = @vcMessage + '@pcUser, ';
    END;
    IF @vcMessage <> '' BEGIN
        RETURN 'BD_WARNING_EMPTY_PRINCIPAL_PARAMETERS';
    END;

    -- Validación del tipo de operación
    IF
        @pnTipoOperacion <> @cnOperacionLectura
        AND @pnTipoOperacion <> @cnOperacionLecturaUnitaria
        AND @pnTipoOperacion <> @cnOperacionCreacion
        AND @pnTipoOperacion <> @cnOperacionModificacion
        AND @pnTipoOperacion <> @cnOperacionInactivacion
        AND @pnTipoOperacion <> @cnOperacionEliminacion
    BEGIN
        RETURN 'BD_WARNING_INVALID_OPERATION';
    END;

    SELECT @vnConteo = COUNT(*) FROM Users U
    WHERE U.idUser = @pnIdUser;

    -- Lectura Unitaria
    IF @pnTipoOperacion = @cnOperacionLecturaUnitaria BEGIN
        IF @pnIdUser IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pnIdUser, ';
        END;
        IF @vcMessage <> '' BEGIN
            RETURN 'BD_WARNING_EMPTY_PARAMETERS';
        END;
        IF @vnConteo = 0 BEGIN
            RETURN 'BD_USERS_INVALID_ID';
        END;
    END;

    -- Creación
    IF @pnTipoOperacion = @cnOperacionCreacion BEGIN
        IF @pcFirstName IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pcFirstName, ';
        END;
        IF @pcLastName IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pcLastName, ';
        END;
        IF @pcEmail IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pcEmail, ';
        END;
        IF @pdBirthdate IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pdBirthdate, ';
        END;
        IF @pnIdRole IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pnIdRole, ';
        END;
        IF @pnStatus IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pnStatus, ';
        END;
        IF @vcMessage <> '' BEGIN
            RETURN 'BD_WARNING_EMPTY_PARAMETERS';
        END;
        SELECT @vnConteo = COUNT(*) FROM Roles R
        WHERE R.idRole = @pnIdRole
        AND R.status = @cnRegistroActivo;
        IF @vnConteo = 0 BEGIN
            RETURN 'BD_ROLES_INVALID_ID';
        END;
    END;

    -- Modificación
    IF @pnTipoOperacion = @cnOperacionModificacion BEGIN
        IF @pnIdUser IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pnIdUser, ';
        END;
        IF @pcFirstName IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pcFirstName, ';
        END;
        IF @pcLastName IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pcLastName, ';
        END;
        IF @pcEmail IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pcEmail, ';
        END;
        IF @pdBirthdate IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pdBirthdate, ';
        END;
        IF @pnIdRole IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pnIdRole, ';
        END;
        IF @pnStatus IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pnStatus, ';
        END;
        IF @vcMessage <> '' BEGIN
            RETURN 'BD_WARNING_EMPTY_PARAMETERS';
        END;
        IF @vnConteo = 0 BEGIN
            RETURN 'BD_USERS_INVALID_ID';
        END;
        SELECT @vnConteo = COUNT(*) FROM Roles R
        WHERE R.idRole = @pnIdRole
        AND R.status = @cnRegistroActivo;
        IF @vnConteo = 0 BEGIN
            RETURN 'BD_ROLES_INVALID_ID';
        END;
    END;

    -- Inactivación
    IF @pnTipoOperacion = @cnOperacionInactivacion BEGIN
        IF @pnIdUser IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pnIdUser, ';
        END;
        IF @vcMessage <> '' BEGIN
            RETURN 'BD_WARNING_EMPTY_PARAMETERS';
        END;
        IF @vnConteo = 0 BEGIN
            RETURN 'BD_USERS_INVALID_ID';
        END;
    END;

    -- Eliminación
    IF @pnTipoOperacion = @cnOperacionEliminacion BEGIN
        IF @pnIdUser IS NULL BEGIN
            SET @vcMessage = @vcMessage + '@pnIdUser, ';
        END;
        IF @vcMessage <> '' BEGIN
            RETURN 'BD_WARNING_EMPTY_PARAMETERS';
        END;
        IF @vnConteo = 0 BEGIN
            RETURN 'BD_USERS_INVALID_ID';
        END;
    END;

    RETURN '';
END;
