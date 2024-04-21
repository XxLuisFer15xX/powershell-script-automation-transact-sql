CREATE OR ALTER PROCEDURE [dbo].[sp_users] (
    -- Parámetros de operación
    @pnTipoOperacion INT, -- Parámetro del tipo de operación a realizar en el SP [1: Lectura | 2: Lectura Unitaria | 3: Creación | 4: Modificación | 5: Inactivación | 6: Eliminación]
    @pcUser VARCHAR(50) = NULL, -- Usuario quien realiza la operación

    -- Parámetros que indican el valor de una columna en un registro
    @pnIdUser INT = NULL,
    @pcFirstName VARCHAR(100) = NULL,
    @pcLastName VARCHAR(100) = NULL,
    @pcEmail VARCHAR(100) = NULL,
    @pdBirthdate DATETIME = NULL,
    @pnIdRole INT = NULL,
    @pnStatus INT = NULL,

    --  Parámetros de salida
    @pnTypeResult INT OUT, -- Parámetro que retorna el estado de la ejecución del SP [0: Exitoso | 1: Error Controlado | 2: Error no controlado]
    @pcResult VARCHAR(MAX) OUT, -- Parámetro que retorna el resultado del Stored Procedure
    @pcMessage VARCHAR(MAX) OUT -- Parámetro que retorna un mensaje de tipo informativo, error o éxito
)
AS 
    -- Variables de utilidad
    DECLARE @cctkNombreProcedimiento        VARCHAR(200) = 'dbo.sp_users';
    DECLARE @vcTempError                    VARCHAR(4000);

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
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        -- Validaciónd de parámetros
        SET @vcTempError = 'Error en validar los parámetros';
        SET @pcMessage = '';

        /*SET @pcResult = dbo.rn_tipos_generos_01(
            -- Parámetros de operación
            @pnTipoOperacion,
            @pcUser,
            -- Parámetros que indican el valor de una columna en un registro
            @pnIdGenero,
            @pcNombre,
            @pcDescripcion,
            @pnEstadoRegistro
        );
        IF @pcResult <> '' AND @pcResult IS NOT NULL BEGIN
            ROLLBACK TRANSACTION;
            SET @pnTypeResult = @cnResultadErrorControlado;
            SET @vcTempError = NULL;
            RETURN;
        END;*/

        -- Lectura
        IF @pnTipoOperacion = @cnOperacionLectura BEGIN
            SET @vcTempError = 'Error al obtener la información de la tabla';
            SELECT
                U.idUser,
                U.firstName,
                U.lastName,
                U.email,
                (
                    SELECT name FROM Roles R
                    WHERE R.idRole = U.idRole
                ) AS Role,
                U.status
            FROM Users U;
            SET @pnTypeResult = @cnResultadoExitoso;
            SET @pcResult = 'BD_SUCCESS_GET';
        END;

        -- Lectura Unitaria
        IF @pnTipoOperacion = @cnOperacionLecturaUnitaria BEGIN
            SET @vcTempError = 'Error al obtener la información del registro';
            SELECT
                U.idUser,
                U.firstName,
                U.lastName,
                U.birthdate,
                U.email,
                U.idRole,
                U.createdBy,
                U.createdAt,
                U.modifiedBy,
                U.modifiedAt,
                U.status
            FROM Users U
            WHERE U.idUser = @pnIdUser;
            SELECT
                R.idRole,
                R.name,
                R.description
            FROM Roles R;
            SET @pnTypeResult = @cnResultadoExitoso;
            SET @pcResult = 'BD_SUCCESS_GET';
        END;
        
        -- Creación
        IF @pnTipoOperacion = @cnOperacionCreacion BEGIN
            SET @vcTempError = 'Error al crear un nuevo registro';
            INSERT INTO Users (
                firstName,
                lastName,
                email,
                birthdate,
                idRole,
                createdBy,
                createdAt,
                status
            ) VALUES (
                @pcFirstName,
                @pcLastName,
                @pcEmail,
                @pdBirthdate,
                @pnIdRole,
                @pcUser,
                GETDATE(),
                @pnStatus
            );
            SET @pnTypeResult = @cnResultadoExitoso;
            SET @pcResult = 'BD_SUCCESS_CREATE';
        END;
        
        -- Modificación
        IF @pnTipoOperacion = @cnOperacionModificacion BEGIN
            SET @vcTempError = 'Error al modificar los datos del registro';
            UPDATE Users SET
                firstName = @pcFirstName,
                lastName = @pcLastName,
                email = @pcEmail,
                birthdate = @pdBirthdate,
                idRole = @pnIdRole,
                modifiedBy = @pcUser,
                modifiedAt = GETDATE(),
                status = @pnStatus
            WHERE idUser = @pnIdUser;
            SET @pnTypeResult = @cnResultadoExitoso;
            SET @pcResult = 'BD_SUCCESS_UPDATE';
        END;

        -- Inactivación
        IF @pnTipoOperacion = @cnOperacionInactivacion BEGIN 
            SET @vcTempError = 'Error al inactivar el registro';
            UPDATE Users SET
                modifiedBy = @pcUser,
                modifiedAt = GETDATE(),
                status = @cnRegistroInactivo
            WHERE idUser = @pnIdUser;
            SET @pnTypeResult = @cnResultadoExitoso;
            SET @pcResult = 'BD_SUCCESS_DISABLE';
        END;

        -- Eliminación
        IF @pnTipoOperacion = @cnOperacionEliminacion BEGIN 
            SET @vcTempError = 'Error al eliminar el registro';
            DELETE Users WHERE idUser = @pnIdUser;
            SET @pnTypeResult = @cnResultadoExitoso;
            SET @pcResult = 'BD_SUCCESS_DELETE';
        END;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @pnTypeResult = @cnResultadErrorNoControlado;
        SET @pcResult = 'BD_SUCCESS_ERROR'
        SET @pcMessage = CONCAT(@pcMessage, ' - ',@vcTempError, ' - ErrorMessage:', ERROR_MESSAGE(),' - ErrorLine:', ERROR_LINE());
    END CATCH
END

