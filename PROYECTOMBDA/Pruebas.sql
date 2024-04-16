--- Se realizan 2 pruebas a nuestra base de datos

--Prueba 1

-- En un dia normal como cualquiera una persona llega a nuestra empresa de envios como un cliente e ingresa su informacion
-- Evidentemente la cedula de alguien no va a ser un numero de un digito pero ya que es nuestro primer cliente se tomara como tal
INSERT INTO Clientes (id, tipoId, nombre, direccion, telefono, correo) 
VALUES (1, 'CC', 'Farris Gercken', 'carrera 36 #13-92', '3195130968', 'fgercken0@nifty.com');
-- Al proveernos su informacion, sabemos el correo, el celular y demas informacion importante de Farris

-- Farris manifiesta tener un envio que quiere realizar, y por los medios correspondientes brinda la informacion de este y paga con tarjeta el monto total del envio.
--Con la informacion que nos provee farris podemos insertar el destinatario del producto en nuestra base de datos
INSERT INTO Destinatarios (id, tipoId, nombre, direccion, telefono, correo) 
VALUES (58, 'CE', 'Alexandra Trewett', 'transversal 89 #57-54', '3188584445', 'atrewett7@is.gd');
-- Esto es necesario dada la cantidad de productos que se manejan en nuestros envios.

--Luego le es asignada Adelice, una persona de logistica a su envio antes de por fin poderlo introducir dentro de la tabla Envios
-- Claro que por supuesto ella ya debia ser una empleada en nuestra base de datos la cual esta asignada a una sucursal

INSERT INTO Sucursales (id, direccion) 
VALUES (36, 'Transversal 34 #12-23');

INSERT INTO Empleados (id, tipoId, nombre, salario, eps, telefono, correo, fechaContratacion, finContrato, sucursal) 
VALUES (36, 'CE', 'Adelice Desport', 11557144, 'Colsubsidio', '3153235468', 'adesportz@soundcloud.com', '23/06/2023', '02/04/2024', 36);

INSERT INTO Logistica (id, nivelEducativo) 
VALUES (36, 'Bachillerato');

-- Con esta informacion ahora si el hace parte de nuestra tabla envios.
INSERT INTO Envios (idCliente, idEnvio, idDestinatario, fecha, direccionOrigen, direccionDestino, idLogistica, vehiculo, metodoPago, pago) 
VALUES (1, 185, 58, '01/01/2023', 'calle 45 #86-95', 'avenida 56 #29-27', 36, 'DYW-104', 'efectivo', 4318723);

-- Dentro de la base de datos se genera en la tabla Contiene una entrada por cada producto que este queriendo enviar Farris puesto que queremos saber que quiere llevar
INSERT INTO Contiene (producto, envio, cant) VALUES (117, 185, 111);

-- Este es un proceso que ya se habia realizado antes pero en la base de datos debia existir el producto y la categoria a la que pertenece.
INSERT INTO Productos (idProducto, nombre, categoria, valorEstimado) 
VALUES (117, 'Laptop', 5, 716585);

INSERT INTO Categorias (idCategoria, nombre, tamanio, peso, descripcion) 
VALUES (5, 'tecnologia', 'M', 'M', 'productos tecnologicos con los que se debe tener mayor cuidado');
-- Gracias a el enlace de la tabla Contiene sabemos que el envio de Farris consta de 111 Laptops los cuales al ser de la categoria tecnologia implican que el envio debe realizarse con cuidado.

--- Con esto toda la informacion de Farris y su envio esta dentro de nuestra base de datos, lo que muestra la sostenibilidad de esta, nos faltaria realizar el envio.
--- que tal ver lo demas desde la perspectiva del area de envios de nuestra base de datos, esto se vera en la prueba 2

--- Prueba 2

-- La empresa hace tiempo compro un vehiculo para los envios, junto con otros pero este es el que nos interesa 
INSERT INTO Vehiculos (conductor, placa, soat, capacidad, tipoCombustible, modelo) 
VALUES (23, 'DYW-104', '90624342', 'L', 'GA', 1987);

-- Ademas se habia contratado un conductor
INSERT INTO Empleados (id, tipoId, nombre, salario, eps, telefono, correo, fechaContratacion, finContrato, sucursal) 
VALUES (23, 'CE', 'Antonie Baus', 3389064, 'Salud Total', '3161478902', 'abausm@hc360.com', '21/06/2023', null, 23);

INSERT INTO Conductores (id, licencia, fechaExpiracion, tipoLicencia) 
VALUES (23, '594-73-81920', '17/10/2040', 'A2');

-- y algunos repartidores
INSERT INTO Empleados (id, tipoId, nombre, salario, eps, telefono, correo, fechaContratacion, finContrato, sucursal) 
VALUES (6, 'CE', 'Celestia Ducker', 7429697, 'Colsubsidio', '3196048106', 'cducker5@wordpress.com', '12/12/2022', '28/11/2024', 6);
INSERT INTO Empleados (id, tipoId, nombre, salario, eps, telefono, correo, fechaContratacion, finContrato, sucursal) 
VALUES (2, 'CE', 'Claire Skinner', 13287885, 'Colsubsidio', '3175086336', 'cskinner1@ask.com', '25/08/2023', '16/12/2023', 2);

-- los cuales fueron asignados a el vehiculo encargaa de llevar a cabo el envio hecho por Farris
INSERT INTO Asignaciones (placa, idRepartidor) 
VALUES ('DYW-104', 6);
INSERT INTO Asignaciones (placa, idRepartidor) 
VALUES ('DYW-104', 2);

-- Antonie, nuestro conductor se dispone a trabajar con su equipo, por tanto le llega el id del pedido de Farris el cual es el 185
-- el necesita saber a que direccion dirigirse a entregar el paquete por lo que la busca en la base de datos
SELECT direccionDestino
FROM Envios
WHERE idEnvio = 185;

-- Sabiendo la direccion se puede dirigir alli facilmente ya que se supone que el trabajo de logistica ya ha sido realizado
-- Lo que acontece es que al llegar al lugar con el equopo fragil, no encuentra a Alexandra quien se supone debe recibir el pedido.

-- Ni llamandola por telefono...
SELECT telefono 
FROM Destinatarios, Envios
WHERE idEnvio = 185 AND idDestinatario = id;

-- ni escribiendole un correo
SELECT correo 
FROM Destinatarios, Envios
WHERE idEnvio = 185 AND idDestinatario = id;

-- logra encontrarla en la que se supone es la direccion de destino, por lo tanto solo le queda entregarlo en la direccion de la persona encargada de recibir el paquete
-- por lo tanto busca donde vive Alexandra con ayuda de la base de datos
SELECT direccion 
FROM Destinatarios, Envios
WHERE idEnvio = 185 AND idDestinatario = id;

-- y deja el paquete en la porteria del conjunto residencial donde ella habita, mandando una notificacion de la entrega del paqeute a este lugar al correo de Alexandra

--- Asi otro envio mas finaliza para Antonie el cual debera junto con su equipo entregar algunos pedidos mas el dia de hoy...

--FIN
