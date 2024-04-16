---Componentes

--CRUDE
--Se define el paquete de empleado

CREATE OR REPLACE PACKAGE PC_Empleado AS
    PROCEDURE ad (
        v_id NUMBER,
        v_tipoId VARCHAR,
        v_nombre VARCHAR,
        v_eps VARCHAR,
        v_telefono NUMBER,
        v_finContrato DATE,
        v_sucursal NUMBER
        );
    PROCEDURE adLogistica (
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
    PROCEDURE up(
        v_id NUMBER,
        v_eps VARCHAR,
        v_telefono NUMBER,
        v_finContrato DATE,
        v_sucursal NUMBER
        );
    PROCEDURE upLogistica(
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
    FUNCTION co(
        v_id NUMBER)
        RETURN SYS_REFCURSOR;
    
    FUNCTION repartidorConsultarVehiculos(
        v_id NUMBER)
        RETURN SYS_REFCURSOR;
    
    FUNCTION conductorConsultarVehiculos(
        v_id NUMBER)
        RETURN SYS_REFCURSOR;
    
    FUNCTION consultarDireccionDestino (
        v_idEnvio NUMBER) 
        RETURN SYS_REFCURSOR;
END PC_Empleado;
/

--CRUDI

CREATE OR REPLACE PACKAGE BODY PC_Empleado AS

    PROCEDURE ad(
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
            INSERT INTO Empleados(id, tipoId, nombre, salario, eps, telefono, correo, fechaContratacion, finContrato, sucursal) 
            VALUES (v_id, v_tipoId, v_nombre, NULL, v_eps, v_telefono, NULL , NULL, v_finContrato, v_sucursal);
            DBMS_OUTPUT.PUT_LINE('El empleado ' ||v_id||' se agrego correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END ad;
    PROCEDURE adLogistica(
        v_id NUMBER,
        v_nivelEducativo VARCHAR
        )
        IS
        BEGIN
            INSERT INTO logistica(id,nivelEducativo) VALUES (v_id,v_nivelEducativo);
            DBMS_OUTPUT.PUT_LINE('El empleado de logistica ' ||v_id||' se agrego correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END adLogistica;
    PROCEDURE adConductor(
        v_id NUMBER,
        v_licencia VARCHAR,
        v_fechaExpiracion DATE,
        v_tipoLicencia VARCHAR
        )
        IS
        BEGIN
            INSERT INTO Conductores(id,licencia,fechaExpiracion,tipoLicencia)
            VALUES (v_id,v_licencia,v_fechaExpiracion,v_tipoLicencia);
            DBMS_OUTPUT.PUT_LINE('El conductor ' ||v_id||' se agrego correctamente');
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
            INSERT INTO Repartidores(id,estadoSalud,fechaNacimiento) VALUES (v_id,v_estadoSalud,v_fechaNacimiento);
            DBMS_OUTPUT.PUT_LINE('El repartidor ' ||v_id||' se agrego correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END adRepartidor;
    PROCEDURE up(
        v_id NUMBER,
        v_eps VARCHAR,
        v_telefono NUMBER,
        v_finContrato DATE,
        v_sucursal NUMBER
        )
        IS
        v_count NUMBER;
        BEGIN
            UPDATE Empleados
            SET
                eps = v_eps,
                telefono = v_telefono,
                -- COALESCE Hace que si la antigua o la nueva fecha fin del contrato es nula, se actualice con el valor no nulo.
                finContrato = COALESCE(v_finContrato, finContrato),
                sucursal = v_sucursal
            WHERE id = v_id;
            SELECT COUNT(*) INTO v_count FROM Empleados WHERE id=v_id;
            IF v_count=0
            THEN RAISE_APPLICATION_ERROR(-20007,'No existe el empleado');
            END IF;
            DBMS_OUTPUT.PUT_LINE('El empleado ' ||v_id||' se modifico correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END up;
    PROCEDURE upLogistica(
        v_id NUMBER,
        v_nivelEducativo VARCHAR
        )
        IS
        v_count NUMBER;
        BEGIN
            UPDATE Logistica
            SET 
                nivelEducativo = v_nivelEducativo
            WHERE id=v_id;
            SELECT COUNT(*) INTO v_count FROM Logistica WHERE id=v_id;
            IF v_count=0
            THEN RAISE_APPLICATION_ERROR(-20007,'No existe el empleado de logistica');
            END IF;
            DBMS_OUTPUT.PUT_LINE('El empleado de logistica ' ||v_id||' se modifico correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END upLogistica;
    PROCEDURE upConductor(
        v_id NUMBER,
        v_licencia VARCHAR,
        v_fechaExpiracion DATE,
        v_tipoLicencia VARCHAR
        )
        IS
        v_count NUMBER;
        BEGIN
            UPDATE Conductores
            SET
                licencia=v_licencia,
                fechaExpiracion=v_fechaExpiracion,
                tipoLicencia=v_tipoLicencia
            WHERE id=v_id;
            SELECT COUNT(*) INTO v_count FROM Conductores WHERE id=v_id;
            IF v_count=0
            THEN RAISE_APPLICATION_ERROR(-20007,'No existe el conductor');
            DBMS_OUTPUT.PUT_LINE('El conductor ' ||v_id||' se modifico correctamente');
            END IF;
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
        v_count NUMBER;
        BEGIN
            UPDATE Repartidores
            SET
                estadoSalud=v_estadoSalud,
                fechaNacimiento=v_fechaNacimiento
            WHERE id=v_id;
            SELECT COUNT(*) INTO v_count FROM Repartidores WHERE id=v_id;
            IF v_count=0
            THEN RAISE_APPLICATION_ERROR(-20007,'No existe el repartidor');
            END IF;
            DBMS_OUTPUT.PUT_LINE('El repartidor ' ||v_id||' se modifico correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END upRepartidor;
    PROCEDURE del(v_id NUMBER)
    IS
    v_count NUMBER;
    BEGIN
            SELECT COUNT(*) INTO v_count FROM Empleados WHERE id=v_id;
            IF v_count=0
            THEN RAISE_APPLICATION_ERROR(-20007,'No existe el empleado');
            END IF;
        DELETE FROM Empleados WHERE id = v_id;

            DBMS_OUTPUT.PUT_LINE('El empleado ' ||v_id||' se elimino correctamente');
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END del;

    FUNCTION co(v_id NUMBER) RETURN SYS_REFCURSOR
    IS
        emp_cursor SYS_REFCURSOR;
    BEGIN
        OPEN emp_cursor FOR
            SELECT *
            FROM Empleados
            WHERE id = v_id;

        RETURN emp_cursor;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END co;

    FUNCTION repartidorConsultarVehiculos(v_id NUMBER) RETURN SYS_REFCURSOR
    IS
        vehiculo_cursor SYS_REFCURSOR;
    BEGIN
        OPEN vehiculo_cursor FOR
            SELECT v.placa
            FROM Vehiculos v
            JOIN Asignaciones a ON v.placa = a.placa
            WHERE a.idRepartidor = v_id;

            RETURN vehiculo_cursor;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END repartidorConsultarVehiculos;

    FUNCTION conductorConsultarVehiculos(v_id NUMBER) RETURN SYS_REFCURSOR
        IS
            vehiculo_cursor SYS_REFCURSOR;
        BEGIN
            OPEN vehiculo_cursor FOR
                SELECT placa
                FROM Vehiculos
                WHERE conductor = v_id;

                RETURN vehiculo_cursor;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END conductorConsultarVehiculos;

    FUNCTION consultarDireccionDestino(v_idEnvio NUMBER) RETURN SYS_REFCURSOR
        IS
            direccion_cursor SYS_REFCURSOR;
        BEGIN
            OPEN direccion_cursor FOR
                SELECT direccionDestino
                FROM Envios
                WHERE idEnvio = v_idEnvio;

            RETURN direccion_cursor;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20006,SQLERRM);
    END consultarDireccionDestino;

END PC_Empleado;
/
--XCrud
DROP PACKAGE PC_Empleado;
--CrudOk
SET SERVEROUTPUT ON;
--Agregar tres nuevos empleados
BEGIN
    PC_Empleado.ad(1062,'CC','Kevin Ramos','Colsanitas',3176664193,NULL,1);
    PC_Empleado.ad(1066,'CC','Camilo Villa',NULL,3176664231,NULL,1);
    PC_Empleado.ad(1069,'CC','Duvan Miranda',NULL,3176664984,NULL,1);
END;
/
--Agregar un empleado de logistica
BEGIN
    PC_Empleado.adLogistica(1062,'Profesional');
end;
/
--Agegar un conductor 
BEGIN
    PC_Empleado.adConductor(1066,'124-83-92833','23/09/2027','B1');
END;
/
--Agregar un repartidor
BEGIN
    PC_Empleado.adRepartidor(1069,'Excelente','21/03/2005');
END;
/
--Modificar un empleado
BEGIN
    PC_Empleado.up(1062,'Colsanitas',3158698763,NULL,2);
END;
/
--Modificar un empleado de logistica
BEGIN
    PC_Empleado.upLogistica(1062,'Maestria');
END;
/
--Modificar un conductor
BEGIN
    PC_Empleado.upConductor(1066,'124-83-92833','23/09/2027','A1');
END;
/
--Modificar un repartidor
BEGIN
    PC_Empleado.adRepartidor(1069,'Regular','21/03/2005');
END;
/
--Eliminar un empleado
BEGIN
    PC_Empleado.del(1069);
END;
/
--CRUDNoOk
--Modificar un empleado que no existe
BEGIN
    PC_Empleado.up(10621,'Colsanitas',3158698763,NULL,2);
END;
/
--Modificar un empleado de logistica que no existe
BEGIN
    PC_Empleado.upLogistica(10621,'Maestria');
END;
/
--Modificar un conductor que no existe
BEGIN
    PC_Empleado.upConductor(10661,'124-83-92833','23/09/2027','A1');
END;
/
--Modificar un repartidor que no existe
BEGIN
    PC_Empleado.adRepartidor(10691,'Regular','21/03/2005');
END;
/



