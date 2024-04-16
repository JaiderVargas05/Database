---Restricciones declarativas y procedimentales

---Tuplas

-- En caso de existir, la fecha de fin de contrato debe ser posterior a la fecha de contratacion.
ALTER TABLE Empleados
ADD CONSTRAINT CK_Empleados_FechaCont_FechaCierre
CHECK (finContrato IS NULL OR finContrato > fechaContratacion);

--La direccion origen debe ser diferente a la direccion destino.
ALTER TABLE Envios
ADD CONSTRAINT CK_Envios_DirOrigen_DirDestino
CHECK (direccionOrigen <> direccionDestino);

--TuplasOK

INSERT INTO Empleados (id, tipoId, nombre, salario, eps, telefono, correo, fechaContratacion, finContrato, sucursal) VALUES (49, 'CC', 'Emmett Rewan', 8329618, 'Famisanar', '3128303210', 'erewan1c@freewebs.com', '08/02/2023', null, 49);
INSERT INTO Empleados (id, tipoId, nombre, salario, eps, telefono, correo, fechaContratacion, finContrato, sucursal) VALUES (50, 'CE', 'Bab Benazet', 12924884, 'Colsubsidio', '3166518047', 'bbenazet1d@weibo.com', '21/04/2023', null, 50);

INSERT INTO Envios (idCliente, idEnvio, idDestinatario, fecha, direccionOrigen, direccionDestino, idLogistica, vehiculo, metodoPago, pago) VALUES (49, 198, 52, '07/01/2023', 'avenida 21 #14-05', 'calle 96 #54-22', 50, 'KDH-765', 'efectivo', 1724401);
INSERT INTO Envios (idCliente, idEnvio, idDestinatario, fecha, direccionOrigen, direccionDestino, idLogistica, vehiculo, metodoPago, pago) VALUES (34, 199, 55, '03/05/2023', 'transversal 38 #62-25', 'avenida 95 #62-16', 40, 'DRA-185', 'efectivo', 3153093);

--TuplasNoOK

--En caso de existir, la fecha de fin de contrato debe ser posterior a la fecha de contratacion.
INSERT INTO Empleados (id, tipoId, nombre, salario, eps, telefono, correo, fechaContratacion, finContrato, sucursal) VALUES (37, 'CC', 'Frederick Dudney', 9841960, 'Coomeva', '3156622382', 'fdudney10@yellowpages.com', '11/07/2024', '31/08/2023', 37);
INSERT INTO Empleados (id, tipoId, nombre, salario, eps, telefono, correo, fechaContratacion, finContrato, sucursal) VALUES (38, 'CE', 'Brantley D''Alesio', 8189123, 'Nueva EPS', '3181011529', 'bdalesio11@reddit.com', '11/03/2024', '04/02/2023', 38);
--La direccion origen debe ser diferente a la direccion destino.
INSERT INTO Envios (idCliente, idEnvio, idDestinatario, fecha, direccionOrigen, direccionDestino, idLogistica, vehiculo, metodoPago, pago) VALUES (49, 198, 52, '07/01/2023', 'avenida 21 #14-05', 'avenida 21 #14-05', 50, 'KDH-765', 'efectivo', 1724401);
INSERT INTO Envios (idCliente, idEnvio, idDestinatario, fecha, direccionOrigen, direccionDestino, idLogistica, vehiculo, metodoPago, pago) VALUES (34, 199, 55, '03/05/2023', 'transversal 38 #62-25', 'transversal 38 #62-25', 40, 'DRA-185', 'efectivo', 3153093);


---Acciones

--Eliminar

--Al eliminar una categoria, se elimina los productos que hagan parte de esta.

ALTER TABLE Productos
    DROP CONSTRAINT FK_Productos_Categorias;
ALTER TABLE Productos
    ADD CONSTRAINT FK_Productos_Categorias FOREIGN KEY(categoria) REFERENCES Categorias(idCategoria)
    ON DELETE CASCADE;
--  Al eliminar cualquiera de los 3 tipos de empleados, se debe eliminar este de su tabla correspondiente.

--Tabla conductores
ALTER TABLE Conductores
    DROP CONSTRAINT FK_Conductores_Empleados;
ALTER TABLE Conductores
    ADD CONSTRAINT FK_Conductores_Empleados FOREIGN KEY(id) REFERENCES Empleados(id)
    ON DELETE CASCADE;

--Tabla repartidores   
ALTER TABLE Repartidores
    DROP CONSTRAINT FK_Repartidores_Empleados;
ALTER TABLE Repartidores
    ADD CONSTRAINT FK_Repartidores_Empleados FOREIGN KEY(id) REFERENCES Empleados(id)
    ON DELETE CASCADE;

--Tabla logistica
ALTER TABLE Logistica
    DROP CONSTRAINT FK_Logistica_Empleados;
ALTER TABLE Logistica
    ADD CONSTRAINT FK_Logistica_Empleados FOREIGN KEY(id) REFERENCES Empleados(id)
    ON DELETE CASCADE;

--Si se elimina un envio, se eliminan los productos asociados a el.
ALTER TABLE Contiene
    DROP CONSTRAINT FK_Contiene_Envios;
ALTER TABLE Contiene
    ADD CONSTRAINT FK_Contiene_Envios FOREIGN KEY(envio) REFERENCES Envios(idEnvio)
    ON DELETE CASCADE;

-- AccionesOK

--Eliminar una categoria
DELETE FROM Categorias WHERE idCategoria = 1;

--Eliminar un condutor
DELETE FROM Empleados WHERE id = 21;

--Eliminar un repartidor
DELETE FROM Empleados WHERE id = 1;

--Eliminar un empleado de logistica
DELETE FROM Empleados WHERE id = 36;

--Eliminar un envio
DELETE FROM Envios WHERE idEnvio = 150;

-- Acciones NoOK no se definirian en este caso


--Disparadores
--Insertar
--El empleado de logistica tiene un salario de 4000000
CREATE OR REPLACE TRIGGER TR_Logistica_AI
AFTER INSERT ON Logistica
FOR EACH ROW
BEGIN
UPDATE Empleados SET salario=4000000 WHERE id=:NEW.id;
END;
/
--Insertar
--Los conductores tiene un salario de 2000000
CREATE OR REPLACE TRIGGER TR_Conductores_AI
AFTER INSERT ON Conductores
FOR EACH ROW
BEGIN 
UPDATE Empleados SET salario=2000000 WHERE id=:NEW.id;
END;
/
--Insertar
--Los repartidores tienen un salario de 1200000
CREATE OR REPLACE TRIGGER TR_Repartidores_AI
AFTER INSERT ON Repartidores
FOR EACH ROW
BEGIN
UPDATE Empleados SET salario=1200000 WHERE id=:NEW.id;
END;
/

--Modificar
-- En Clientes los unicos datos que se pueden actualizar son el telefono, correo y direccion.
CREATE OR REPLACE TRIGGER TR_Clientes_BU
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF :OLD.id<>:NEW.id OR :OLD.tipoId<>:NEW.tipoId OR :OLD.nombre<>:NEW.nombre THEN
    RAISE_APPLICATION_ERROR(-20001,'Solo se puede modificar la direccion, el telefono o el correo de un cliente.');
    END IF;
END;
/

--Eliminar
-- La informacion de los clientes no se puede eliminar si ha hecho almenos un envio.

CREATE OR REPLACE TRIGGER TR_Clientes_BD
BEFORE DELETE ON Clientes
FOR EACH ROW
DECLARE
    env_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO env_count FROM Envios WHERE idCliente = :OLD.id;
    IF env_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar informacion sobre clientes que han realizado envios.');
    END IF;
END;
/
--Insertar
-- Si no se especifica la cantidad de un producto al enviarse se toma como 1.
CREATE OR REPLACE TRIGGER TR_Producto_BI
BEFORE INSERT ON Contiene
FOR EACH ROW
BEGIN
    IF :NEW.cant IS NULL THEN
        :NEW.cant := 1;
    END IF;
END;
/
--Insertar
-- La fecha de contratacion se genera automaticamente.
--Si no especifica la eps se define como Salud Total
--El correo es autogenerado
--Al insertar un empleado el salario por defecto es 0
CREATE OR REPLACE TRIGGER TR_Empleados_BI
BEFORE INSERT ON Empleados
FOR EACH ROW
BEGIN
    :NEW.salario:=0;
    :NEW.fechaContratacion := TRUNC(SYSDATE);
    :NEW.correo := :NEW.tipoId||:NEW.id||SUBSTR(:NEW.nombre,1,3)||'@envios.com';
    IF :NEW.eps IS NULL THEN
        :NEW.eps:='Salud Total';
    END IF;
END;
/
--Modificar
--Del empleado se puede modificar el telefono, la eps, el salario, la sucursal y el fin de contrato.
CREATE OR REPLACE TRIGGER TR_Empleados_BU
BEFORE UPDATE ON Empleados
FOR EACH ROW
BEGIN
    IF :NEW.id<>:OLD.id OR :NEW.tipoId<>:OLD.tipoId OR :NEW.nombre<>:OLD.nombre 
        OR :NEW.correo<>:OLD.correo OR :NEW.fechaContratacion<>:OLD.fechaContratacion THEN
        RAISE_APPLICATION_ERROR(-20005,'No se pueden modificar estos datos');
    END IF;
END;
/
--Insertar-Modificar
-- La licencia de los conductores debe estar al dia (Fecha de expiracion debe ser menor a la fecha actual)
CREATE OR REPLACE TRIGGER TR_Conductores_BI_BU
BEFORE INSERT OR UPDATE ON Conductores
FOR EACH ROW
BEGIN
  IF TRUNC(SYSDATE) > :NEW.fechaExpiracion THEN
    RAISE_APPLICATION_ERROR(-20003, 'La licencia del conductor est� vencida.');
  END IF;
END;
/
--Modificar
--No se puede modifcar la direccion de destino de un envio

CREATE OR REPLACE TRIGGER TR_Envios_BU
BEFORE UPDATE ON Envios
FOR EACH ROW
BEGIN
    IF :NEW.direccionDestino<>:OLD.direccionDestino THEN
        RAISE_APPLICATION_ERROR(-20004,'No se puede modificar la direccion de destino');
    END IF;
END;
/

--DisparadoresOK
--El salario de un empleado de logistica es de 4000000
INSERT INTO Logistica (id,nivelEducativo) VALUES (39,'Profesional');
--El salario de un conductor es de 2000000
INSERT INTO Conductores (id,licencia,fechaNacimiento,

--Se puede cambiar el numero de un cliente
UPDATE Clientes SET telefono = 3765134521 WHERE id = 1;

--Licencia valida
INSERT INTO Conductores (id, licencia, fechaExpiracion, tipoLicencia) VALUES (21, '516-45-72429', '04/10/2025', 'B1');
INSERT INTO Conductores (id, licencia, fechaExpiracion, tipoLicencia) VALUES (22, '676-25-72742', '09/02/2029', 'B1');

--Borrar informacion de un cliente que no ha hecho envios.

DELETE FROM Clientes WHERE id = 3;

--DisparadoresNoOK

--No se puede cambiar el nombre de un cliente
UPDATE Clientes SET nombre = 'Pepito' WHERE id = 1;

--Licencia invalida
INSERT INTO Conductores (id, licencia, fechaExpiracion, tipoLicencia) VALUES (21, '516-45-72429', '04/10/2020', 'B1');
INSERT INTO Conductores (id, licencia, fechaExpiracion, tipoLicencia) VALUES (22, '676-25-72742', '09/02/2019', 'B1');

--Borrar informacion de un cliente que ha hecho envios.

DELETE FROM Clientes WHERE id = 40;

--Licencia vencida
INSERT INTO Conductores (id, licencia, fechaExpiracion, tipoLicencia) VALUES (21, '516-45-72429', '04/10/2022', 'B1');
INSERT INTO Conductores (id, licencia, fechaExpiracion, tipoLicencia) VALUES (22, '676-25-72742', '09/02/2019', 'B1');

--Cambio dirrecion destino
UPDATE Envios SET direccionDestino = 'calle 46 #24-68' WHERE idEnvio = 151;

--XTuplas

ALTER TABLE Empleados DROP CONSTRAINT CK_Empleados_FechaCont_FechaCierre;
ALTER TABLE Envios DROP CONSTRAINT CK_Envios_DirOrigen_DirDestino;

--XAcciones
ALTER TABLE Productos DROP CONSTRAINT FK_Productos_Categorias;
ALTER TABLE Conductores DROP CONSTRAINT FK_Conductores_Empleados;
ALTER TABLE Repartidores DROP CONSTRAINT FK_Repartidores_Empleados;
ALTER TABLE Logistica DROP CONSTRAINT FK_Logistica_Empleados;
ALTER TABLE Contiene DROP CONSTRAINT FK_Contiene_Envios;

--XDisparadores

DROP TRIGGER TR_Clientes_BU;
DROP TRIGGER TR_Clientes_BD;
DROP TRIGGER TR_Producto_BI;
DROP TRIGGER TR_Empleados_BI;
DROP TRIGGER TR_Conductores_BI_BU;
DROP TRIGGER TR_Envios_BU;
