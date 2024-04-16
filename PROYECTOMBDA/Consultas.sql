--Consultas

--Consultar los empleados que su contrato es a termino indefinido 
SELECT nombre, id
FROM Empleados
WHERE finContrato IS NULL;


--Consultar los conductores de vehiculos electricos de la empresa que son para cargas peque�as
SELECT Empleados.nombre
FROM Empleados, Conductores, Vehiculos
WHERE Vehiculos.capacidad='P' AND Vehiculos.tipoCombustible='EL' AND Vehiculos.conductor=Conductores.id AND Conductores.id = Empleados.id;


--Consultar cuantos vehiculos movilizan productos pesados
SELECT COUNT(*) 
FROM Vehiculos
WHERE capacidad = 'P';

--Consultar el id y el nombre de los clientes con mas de 1 envio realizado
SELECT Clientes.id, Clientes.nombre
FROM Clientes
JOIN Envios ON Clientes.id = Envios.idCliente
GROUP BY Clientes.id, Clientes.nombre
HAVING COUNT(Envios.idEnvio) > 1;