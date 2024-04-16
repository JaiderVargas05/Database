
---Indices y Vistas

-- Indices

-- Origen y destino de envio
CREATE INDEX idx_Clientes_Envios_Destinatarios
ON Envios(direccionOrigen, direccionDestino);

CREATE INDEX idx_Vehiculos_Conductores
ON Vehiculos(conductor);

-- 

--- Vistas

--Consultas operativas

-- Consulta 1 (Conductor): Direccion del destinatario
CREATE OR REPLACE VIEW VConductor AS
SELECT id, direccion
FROM Destinatarios;

-- Consulta 2 (Conductor y repartidor): Placa del veh�culo asignado
CREATE OR REPLACE VIEW VPlaca AS
SELECT A.placa, idRepartidor, conductor 
FROM Asignaciones A, Vehiculos V
WHERE A.placa = V.placa;


-- Consulta 3 (Organizador): Productos de un envio
CREATE OR REPLACE VIEW V1Organizador AS
SELECT C.producto AS idProducto, E.idEnvio, C.cant
FROM Contiene C
JOIN Envios E ON C.envio = E.idEnvio;

-- Consulta 4 (Organizador): Categorias
CREATE OR REPLACE VIEW V2Organizador AS
SELECT idProducto AS producto,idCategoria AS categoria,descripcion
FROM Categorias C,Productos P
WHERE C.idCategoria=P.Categoria;


-- Consultas gerenciales


-- Consulta 5 : Cantidad de envios por sucursal
CREATE OR REPLACE VIEW V1ELogistica AS
SELECT emp.sucursal AS idSucursal, COUNT(e.idEnvio) AS cantidadEnvios
FROM Envios e
JOIN Empleados emp ON e.idLogistica = emp.id
GROUP BY emp.sucursal;


-- Consulta 6: Cantidad total de envios
CREATE OR REPLACE VIEW V2ELogistica AS
SELECT COUNT(idEnvio) AS cantidadEnvios
FROM Envios;

--IndicesVistasOK

--Consultar la direccion de origen y la direccion de destino del envio 150
SELECT direccionOrigen,direccionDestino  FROM Envios
WHERE idEnvio=150;
--Consultar el conductor responsable del vehiculo con placa YDE-684-QQP
SELECT conductor FROM Vehiculos
WHERE placa='DYW-104';
--Consultar la direccion de los destinatarios en caso de que estos no recojan el envio en la sucursal
SELECT * FROM VConductor;
--Consultar los conductores y repartidores asignados a los vehiculos
SELECT * FROM VPlaca;
--Consultar los productos de cada envio
SELECT * FROM V1Organizador;
--Consultar las categorias y la correspondiente descipcion de los productos
SELECT * FROM V2Organizador;
--Consultar la cantidad de envios por sucursal
SELECT * FROM V1ELogistica;
--Consultar el total de envios
SELECT * FROM V2ELogistica;

--XIndicesVistas
DROP INDEX idx_Clientes_Envios_Destinatarios;
DROP INDEX idx_Vehiculos_Conductores;
DROP VIEW VConductor;
DROP VIEW VPlaca;
DROP VIEW V1Organizador;
DROP VIEW V2Organizador;
DROP VIEW V1ELogistica;
DROP VIEW V2ELogistica;