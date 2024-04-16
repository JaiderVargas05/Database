--ActoresE
CREATE OR REPLACE PACKAGE PA_Gerente IS
    PROCEDURE adEmpleado (
        v_id NUMBER,
        v_tipoId VARCHAR,
        v_nombre VARCHAR,
        v_eps VARCHAR,
        v_telefono NUMBER,
        v_finContrato DATE,
        v_sucursal NUMBER
        );
    PROCEDURE adEmpleadoLogistica (
        v_id NUMBER,
        v_nivelEducativo VARCHAR
        );
    PROCEDURE adConductor(
        v_id NUMBER,
        v_licencia VARCHAR,
        v_fechaExpiracion DATE,
        v_tipoLicencia VARCHAR
        );
    PROCEDURE adRepartidor(
        v_id NUMBER,
        v_estadoSalud VARCHAR,
        v_fechaNacimiento DATE
        );
    PROCEDURE upEmpleado(
        v_id NUMBER,
        v_eps VARCHAR,
        v_telefono NUMBER,
        v_finContrato DATE,
        v_sucursal NUMBER
        );
    PROCEDURE upEmpleadoLogistica(
        v_id NUMBER,
        v_nivelEducativo VARCHAR
        );
    PROCEDURE upConductor(
        v_id NUMBER,
        v_licencia VARCHAR,
        v_fechaExpiracion DATE,
        v_tipoLicencia VARCHAR
        );
    PROCEDURE upRepartidor(
        v_id NUMBER,
        v_estadoSalud VARCHAR,
        v_fechaNacimiento DATE
        );
    PROCEDURE del(
        v_id NUMBER
        );
    FUNCTION coEmpleado(
        v_id NUMBER)
        RETURN SYS_REFCURSOR;
END PA_Gerente;
/
CREATE OR REPLACE PACKAGE PA_Conductor IS
    FUNCTION conductorConsultarVehiculos(
        v_id NUMBER)
        RETURN SYS_REFCURSOR;
    FUNCTION consultarDireccionDestino (
        v_idEnvio NUMBER) 
        RETURN SYS_REFCURSOR;
END PA_Conductor;
/
CREATE OR REPLACE PACKAGE PA_Repartidor IS
    FUNCTION repartidorConsultarVehiculos(
        v_id NUMBER)
        RETURN SYS_REFCURSOR;
END PA_Repartidor;
/
--ActoresI
CREATE OR REPLACE PACKAGE BODY PA_Gerente AS

    PROCEDURE adEmpleado(
        v_id NUMBER,
        v_tipoId VARCHAR,
        v_nombre VARCHAR,
        v_eps VARCHAR,
        v_telefono NUMBER,
        v_finContrato DATE,
        v_sucursal NUMBER
        )
        IS
        BEGIN
            PC_Empleado.ad(v_id,v_tipoId,v_nombre,v_eps,v_telefono,v_finContrato,v_sucursal);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END adEmpleado;
    PROCEDURE adEmpleadoLogistica(
        v_id NUMBER,
        v_nivelEducativo VARCHAR
        )
        IS
        BEGIN
            PC_Empleado.adLogistica(v_id,v_nivelEducativo);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END adEmpleadoLogistica;
    PROCEDURE adConductor(
        v_id NUMBER,
        v_licencia VARCHAR,
        v_fechaExpiracion DATE,
        v_tipoLicencia VARCHAR
        )
        IS
        BEGIN
            PC_Empleado.adConductor(v_id,v_licencia,v_fechaExpiracion,v_tipoLicencia);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END adConductor;
    PROCEDURE adRepartidor(
        v_id NUMBER,
        v_estadoSalud VARCHAR,
        v_fechaNacimiento DATE
        )
        IS
        BEGIN
            PC_Empleado.adRepartidor(v_id,v_estadoSalud,v_fechaNacimiento);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END adRepartidor;
    PROCEDURE upEmpleado(
        v_id NUMBER,
        v_eps VARCHAR,
        v_telefono NUMBER,
        v_finContrato DATE,
        v_sucursal NUMBER
        )
        IS
        BEGIN
            PC_Empleado.up(v_id,v_eps,v_telefono,v_finContrato,v_sucursal);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END upEmpleado;
    PROCEDURE upEmpleadoLogistica(
        v_id NUMBER,
        v_nivelEducativo VARCHAR
        )
        IS
        BEGIN
            PC_Empleado.upLogistica(v_id,v_nivelEducativo);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END upEmpleadoLogistica;
    PROCEDURE upConductor(
        v_id NUMBER,
        v_licencia VARCHAR,
        v_fechaExpiracion DATE,
        v_tipoLicencia VARCHAR
        )
        IS
        BEGIN
            PC_Empleado.upConductor(v_id,v_licencia,v_fechaExpiracion,v_licencia);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END upConductor;
    PROCEDURE upRepartidor(
        v_id NUMBER,
        v_estadoSalud VARCHAR,
        v_fechaNacimiento DATE
        )
        IS
        BEGIN
            PC_Empleado.upRepartidor(v_id,v_estadoSalud,v_fechaNacimiento);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END upRepartidor;
    PROCEDURE del(v_id NUMBER)
    IS
    BEGIN
        PC_Empleado.del(v_id);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END del;

    FUNCTION coEmpleado(v_id NUMBER) RETURN SYS_REFCURSOR
    IS
    BEGIN
        RETURN PC_Empleado.co(v_id);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END coEmpleado;
END PA_Gerente;
/
CREATE OR REPLACE PACKAGE BODY PA_Conductor IS
FUNCTION conductorConsultarVehiculos(v_id NUMBER) RETURN SYS_REFCURSOR
        IS
        BEGIN
            RETURN PC_Empleado.conductorConsultarVehiculos(v_id);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END conductorConsultarVehiculos;

    FUNCTION consultarDireccionDestino(v_idEnvio NUMBER) RETURN SYS_REFCURSOR
        IS
        BEGIN
            RETURN consultarDireccionDestino(v_idEnvio);
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END consultarDireccionDestino;

END PA_Conductor;
/
CREATE OR REPLACE PACKAGE BODY PA_Repartidor IS
    FUNCTION repartidorConsultarVehiculos(v_id NUMBER) RETURN SYS_REFCURSOR
    IS
    BEGIN
        RETURN repartidorConsultarVehiculos(v_id) ;
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END repartidorConsultarVehiculos;
END PA_Repartidor;
/
--Seguridad
--Crear el rol gerente y darle los permisos
CREATE ROLE PA_Gerente;
GRANT SELECT ON Empleados TO PA_Gerente;
GRANT SELECT ON Logistica TO PA_Gerente;
GRANT SELECT ON Conductores TO PA_Gerente;
GRANT SELECT ON Repartidores TO PA_Gerente;
GRANT INSERT ON Empleados TO PA_Gerente;
GRANT INSERT ON Logistica TO PA_Gerente;
GRANT INSERT ON Conductores TO PA_Gerente;
GRANT INSERT ON Repartidores TO PA_Gerente;
GRANT UPDATE ON Empleados TO PA_Gerente;
GRANT UPDATE ON Logistica TO PA_Gerente;
GRANT UPDATE ON Conductores TO PA_Gerente;
GRANT UPDATE ON Repartidores TO PA_Gerente;
GRANT DELETE ON Empleados TO PA_Gerente;
GRANT DELETE ON Logistica TO PA_Gerente;
GRANT DELETE ON Conductores TO PA_Gerente;
GRANT DELETE ON Repartidores TO PA_Gerente;
--Crear el rol conductor y darle los permisos
CREATE ROLE PA_Conductor;
GRANT SELECT ON Destinatarios TO PA_Conductor;
GRANT SELECT ON Vehiculos TO PA_Conductor;
GRANT SELECT ON Asignaciones TO PA_Conductor;
GRANT SELECT ON Repartidores TO PA_Conductor;
--Crear el rol repartidor y darle los permisos
CREATE ROLE PA_Repartidor;
GRANT SELECT ON Destinatarios TO PA_Repartidor;
GRANT SELECT ON Vehiculos TO PA_Repartidor;
GRANT SELECT ON Asignaciones TO PA_Repartidor;
GRANT SELECT ON Repartidores TO PA_Repartidor;

--Nos asignamos como un rol para hacer las pruebas correspondientes
GRANT PA_GERENTE TO bd1000096278;
GRANT PA_Conductor TO bd1000096413;
GRANT PA_Repartidor TO bd1000096413;

--SeguridadOK
--Se utiliza REVERT siempre para que no surtan cambios que perjudiquen la base de datos en las pruebas.

-- Un usuario con el rol PA_Gerente ejecuta operaciones que puede realizar

--Consultar en cualquier tabla, por ejemplo en la tabla Empleados:
EXECUTE AS USER = 'bd1000096278';
SELECT * FROM Empleados;
REVERT;

--Insertar en cualquiera de las tablas en las que tiene permiso, por ejemplo en logistica.
EXECUTE AS USER = 'bd1000096278';
INSERT INTO Logistica VALUES (1062,'Profesional');
REVERT;

--Actualizar informacion de un empleado, por ejemplo el estado de salud de un repartidor
EXECUTE AS USER = 'bd1000096278';
UPDATE Repartidores SER estadoSalud = 'Regular' WHERE id=1069;
REVERT;

-- Eliminar un empleado
EXECUTE AS USER = 'bd1000096278';
DELETE FROM Empleados WHERE id=1062;

-- Un usuario con el rol PA_Conductor, o PA_Repartidor realiza operaciones validas, puesto que ambos comparten los mismos permisos.

--Consultar en Destinatarios
EXECUTE AS USER = 'bd1000096413';
SELECT * FROM Destinatarios;
REVERT;

--Consultar en Vehiculos
EXECUTE AS USER = 'bd1000096413';
SELECT * FROM Vehiculos;
REVERT;

--Consultar en Asignaciones
EXECUTE AS USER = 'bd1000096413';
SELECT * FROM Asignaciones;
REVERT;

--Consultar en Repartidores
EXECUTE AS USER = 'bd1000096413';
SELECT * FROM Repartidores;
REVERT;




--XSeguridad
--Eliminar roles
DROP ROLE PA_Gerente;
DROP ROLE PA_Conductor;
DROP ROLE PA_Repartidor;
--Eliminar paquetes
DROP PACKAGE PA_Gerente;
DROP PACKAGE PA_Conductor;
DROP PACKAGE PA_Repartidor;