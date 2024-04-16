--Atributos

--Se verifica que se ingrese una direccion valida en la tabla Clientes
ALTER TABLE Clientes ADD CONSTRAINT CK_Clientes_direccion
    CHECK ((LOWER(direccion) LIKE '%calle%' or LOWER(direccion) LIKE '%carrera%'
    OR LOWER(direccion) LIKE '%avenida%' OR LOWER(direccion) LIKE '%diagonal%' OR LOWER(direccion) LIKE '%transversal%') AND direccion LIKE '%#%');

--Se verifica que se ingrese un tipo de documento valido en la tabla Clientes
ALTER TABLE Clientes ADD CONSTRAINT CK_Clientes_tipoId
    CHECK(tipoId in ('CC','CE'));
    
--Se verifica que el numero de telefono sea valido en la tabla Clientes
ALTER TABLE Clientes ADD CONSTRAINT CK_Clientes_telefono
    CHECK (LENGTH(telefono) = 10);
    
--Se verifica el identificador de la tabla CLientes sea un numero positivo    
ALTER TABLE Clientes ADD CONSTRAINT CK_Clientes_id
    CHECK (id >0);
    
--Se verifica que el correo insertado en la tabla Clientes tenga un formato correcto    
ALTER TABLE Clientes ADD CONSTRAINT CK_Clientes_correo
    CHECK (correo LIKE '%@%' AND correo LIKE '%.%');

--Se verifica el identificador de la tabla Envios sea un numero positivo  
ALTER TABLE Envios ADD CONSTRAINT CK_Envios_idEnvio
    CHECK (idEnvio >0);
    
--Se verifica que el metodo de pago ingresado en la tabla Envios se valido
ALTER TABLE Envios ADD CONSTRAINT CK_Envios_metodoPago
    CHECK(LOWER(metodoPago) in ('efectivo','tarjeta','pse'));
    
--Se verifica que el formato de la direccion de origen ingresado en la tabla Envios sea valido    
ALTER TABLE Envios ADD CONSTRAINT CK_Envios_direccionOrigen
    CHECK ((LOWER(direccionOrigen) LIKE '%calle%' or LOWER(direccionOrigen) LIKE '%carrera%'
    OR LOWER(direccionOrigen) LIKE '%avenida%' OR LOWER(direccionOrigen) LIKE '%transversal%' OR LOWER(direccionOrigen) LIKE '%diagonal%') AND direccionOrigen LIKE '%#%');

----Se verifica que el formato de la direccion de destino ingresado en la tabla Envios sea valido  
ALTER TABLE Envios ADD CONSTRAINT CK_Envios_direccionDestino
    CHECK ((LOWER(direccionDestino) LIKE '%calle%' or LOWER(direccionDestino) LIKE '%carrera%'
    OR LOWER(direccionDestino) LIKE '%avenida%' OR LOWER(direccionDestino) LIKE '%transversal%' OR LOWER(direccionDestino) LIKE '%diagonal%') AND direccionOrigen LIKE '%#%');

-- Se verifica que el tamanio ingresado en la tabla Categorias este dentro de las opciones validas
ALTER TABLE Categorias ADD CONSTRAINT CK_Categorias_tamanio
    CHECK(tamanio in ('M','G','P'));
    
---- Se verifica que el peso ingresado en la tabla Categorias este dentro de las opciones validas
ALTER TABLE  Categorias ADD CONSTRAINT CK_Categorias_peso
    CHECK(peso in ('L','P','M'));

--Se verifica que la capacidad ingresada en la tabla Vehiculos este dentro de las opciones validas
ALTER TABLE Vehiculos ADD CONSTRAINT CK_Vehiculos_capacidad
    CHECK(capacidad in ('L','M','P'));
    
--Se verifica que el tipo de combustible ingresado en la tabla Vehiculos este dentro de las opciones validas
ALTER TABLE Vehiculos ADD CONSTRAINT CK_Vehiculos_tipoCombustible
    CHECK(tipoCombustible in ('GS','DS','GA','EL'));

--Se verifica que el identificador de la tabla Empleados sea positivo
ALTER TABLE Empleados ADD CONSTRAINT CK_Empleados_id
    CHECK (id >0);
    
--Se verifica que el tipo de identificacion del empleado este dentro de las opciones validas    
ALTER TABLE Empleados ADD CONSTRAINT CK_Empleados_tipoId
    CHECK(tipoId in ('CC','CE'));
    
--Se verifica que el numero de telefono ingresado en la tabla Empleados tenga 10 digitos y sea positivo    
ALTER TABLE Empleados ADD CONSTRAINT CK_Empleados_telefono
    CHECK (LENGTH(telefono) = 10
       AND telefono >0);
       

--Se verifica que el identificador de la tabla Logistica sea positivo
ALTER TABLE Logistica ADD CONSTRAINT CK_Logistica_id
    CHECK (id >0);

--Se verifica que el identificador de la tabla Conductores sea positivo    
ALTER TABLE Conductores ADD CONSTRAINT CK_Conductores_id
    CHECK (id >0);
    
--Se verifica que el tipo de licencia ingresado en la tabla Conductores este dentro de las validas para operar
ALTER TABLE Conductores ADD CONSTRAINT CK_Conductores_tipoLicencia
    CHECK (tipoLicencia IN ('A1','A2','B1'));

--Se verifica que el identificador de la tabla Repartidores sea positivo
ALTER TABLE Repartidores ADD CONSTRAINT CK_Repartidores_id
    CHECK (id >0);

--Se verifica que el identificador de la tabla Destinatarios sea positivo
ALTER TABLE Destinatarios ADD CONSTRAINT CK_Destinatarios_id
    CHECK (id >0);
    
--Se verifica que el tipo de identificacion ingresado en la tabla Destinatarios este dentro de las opciones validas    
ALTER TABLE Destinatarios ADD CONSTRAINT CK_Destinatarios_tipoId
    CHECK(tipoId in ('CC','CE'));
    
--Se verifica que el telefono ingresado en la tabla Destinatarios es positivo y de longitud 10    
ALTER TABLE Destinatarios ADD CONSTRAINT CK_Destinatarios_telefono
    CHECK (LENGTH(telefono) = 10
       AND telefono >0);
       
--Se verifica que la direccion ingresada en la tabla Destinatarios cumpla con el formato valido
ALTER TABLE Destinatarios ADD CONSTRAINT CK_Destinatarios_direccion
    CHECK ((LOWER(direccion) LIKE '%calle%' or LOWER(direccion) LIKE '%carrera%'
    OR LOWER(direccion) LIKE '%avenida%' OR LOWER(direccion) LIKE '%diagonal%' OR LOWER(direccion) LIKE '%transversal%') AND direccion LIKE '%#%');

----Se verifica que la direccion ingresada en la tabla Destinatarios cumpla con el formato valido
ALTER TABLE Destinatarios ADD CONSTRAINT CK_Destinatarios_correo
    CHECK(correo LIKE '%@%' AND correo LIKE '%.%');

----Se verifica que la direccion ingresada en la tabla Sucursales cumpla con el formato valido
ALTER TABLE Sucursales ADD CONSTRAINT CK_Sucursales_direccion
    CHECK ((LOWER(direccion) LIKE '%calle%' or LOWER(direccion) LIKE '%carrera%'
    OR LOWER(direccion) LIKE '%avenida%' OR LOWER(direccion) LIKE '%transversal%' OR LOWER(direccion) LIKE '%transversal%' ) AND direccion LIKE '%#%');

--Primarias

ALTER TABLE Clientes
    ADD CONSTRAINT PK_Clientes PRIMARY KEY(id);

ALTER TABLE Envios
    ADD CONSTRAINT PK_Envios PRIMARY KEY(idEnvio);

ALTER TABLE Contiene 
    ADD CONSTRAINT Pk_Contiene PRIMARY KEY(Producto,envio);

ALTER TABLE Productos
    ADD CONSTRAINT PK_Productos PRIMARY KEY(idProducto);

ALTER TABLE Categorias
    ADD CONSTRAINT PK_Categorias PRIMARY KEY(idCategoria);

ALTER TABLE Vehiculos
    ADD CONSTRAINT PK_Vehiculos PRIMARY KEY(placa);

ALTER TABLE Empleados
    ADD CONSTRAINT PK_Empleados PRIMARY KEY(id);

ALTER TABLE Repartidores
    ADD CONSTRAINT PK_Repartidores PRIMARY KEY(id);

ALTER TABLE Asignaciones
    ADD CONSTRAINT PK_Asignaciones PRIMARY KEY(placa, idRepartidor);

ALTER TABLE Conductores
    ADD CONSTRAINT PK_Conductores PRIMARY KEY(id);

ALTER TABLE Logistica
    ADD CONSTRAINT PK_Logisticas PRIMARY KEY(id);

ALTER TABLE Destinatarios
    ADD CONSTRAINT PK_Destinatarios PRIMARY KEY(id);

ALTER TABLE Sucursales
    ADD CONSTRAINT PK_Sucursales PRIMARY KEY(id);

--Unicas

ALTER TABLE Vehiculos
    ADD CONSTRAINT UK_Vehiculos_soat UNIQUE(soat);

ALTER TABLE Conductores
    ADD CONSTRAINT UK_Conductores_licencia UNIQUE(licencia);

ALTER TABLE Productos 
    ADD CONSTRAINT UK_Productos_nombre UNIQUE(nombre);
    
ALTER TABLE Categorias
    ADD CONSTRAINT UK_Categorias_nombre UNIQUE(nombre);

--Foraneas

ALTER TABLE Envios
    ADD CONSTRAINT FK_Envio_Clientes FOREIGN KEY(idCliente) REFERENCES Clientes(id);

ALTER TABLE Envios
    ADD CONSTRAINT FK_Envios_Logistica FOREIGN KEY(idLogistica) REFERENCES Logistica(id);

ALTER TABLE Envios
    ADD CONSTRAINT FK_Envios_Destinatarios FOREIGN KEY(idDestinatario) REFERENCES Destinatarios(id);

ALTER TABLE Envios
    ADD CONSTRAINT FK_Envios_Vehiculos FOREIGN KEY(vehiculo) REFERENCES Vehiculos(placa);

ALTER TABLE Contiene
    ADD CONSTRAINT FK_Contiene_Envios FOREIGN KEY(envio) REFERENCES Envios(idEnvio);

ALTER TABLE Contiene 
    ADD CONSTRAINT FK_Contiene_Producto FOREIGN KEY(producto) REFERENCES Productos(idProducto);

ALTER TABLE Productos
    ADD CONSTRAINT FK_Productos_Categorias FOREIGN KEY(categoria) REFERENCES Categorias(idCategoria);

ALTER TABLE Vehiculos
    ADD CONSTRAINT FK_Vehiculos_Conductores FOREIGN KEY(conductor) REFERENCES Conductores(id);

ALTER TABLE Asignaciones
    ADD CONSTRAINT FK_Asignaciones_Repartidores FOREIGN KEY(idRepartidor) REFERENCES Repartidores(id);

ALTER TABLE Asignaciones
    ADD CONSTRAINT FK_Asignaciones_Vehiculos FOREIGN KEY(placa) REFERENCES Vehiculos(placa);

ALTER TABLE Conductores
    ADD CONSTRAINT FK_Conductores_Empleados FOREIGN KEY(id) REFERENCES Empleados(id);

ALTER TABLE Repartidores
    ADD CONSTRAINT FK_Repartidores_Empleados FOREIGN KEY(id) REFERENCES Empleados(id);

ALTER TABLE Logistica
    ADD CONSTRAINT FK_Logistica_Empleados FOREIGN KEY(id) REFERENCES Empleados(id);

ALTER TABLE Empleados
    ADD CONSTRAINT FK_Empleado_Sucursales FOREIGN KEY(sucursal) REFERENCES Sucursales(id);


--XForaneas

ALTER TABLE Envios
    DROP CONSTRAINT FK_Envio_Clientes;
ALTER TABLE Envios
    DROP CONSTRAINT FK_Envios_Logistica;
ALTER TABLE Envios
    DROP CONSTRAINT FK_Envios_Destinatarios;
ALTER TABLE Envios
    DROP CONSTRAINT FK_Envios_Vehiculos;
ALTER TABLE Contiene 
    DROP CONSTRAINT FK_Contiene_Producto;
ALTER TABLE Productos
    DROP CONSTRAINT FK_Productos_Categorias;
ALTER TABLE Vehiculos
    DROP CONSTRAINT FK_Vehiculos_Conductores;
ALTER TABLE Asignaciones
    DROP CONSTRAINT FK_Asignaciones_Repartidores;
ALTER TABLE Asignaciones
    DROP CONSTRAINT FK_Asignaciones_Vehiculos;
ALTER TABLE Empleados
    DROP CONSTRAINT FK_Empleado_Sucursales;

--XUnicas

ALTER TABLE Vehiculos
    DROP CONSTRAINT UK_Vehiculos_soat;
ALTER TABLE Conductores
    DROP CONSTRAINT UK_Conductores_licencia;
ALTER TABLE Productos 
    DROP CONSTRAINT UK_Productos_nombre; 
ALTER TABLE Categorias
    DROP CONSTRAINT UK_Categorias_nombre;

--XPrimarias
ALTER TABLE Clientes
    DROP CONSTRAINT PK_Clientes;
ALTER TABLE Envios
    DROP CONSTRAINT PK_Envios;
ALTER TABLE Contiene 
    DROP CONSTRAINT Pk_Contiene;
ALTER TABLE Productos
    DROP CONSTRAINT PK_Productos;
ALTER TABLE Categorias
    DROP CONSTRAINT PK_Categorias;
ALTER TABLE Vehiculos
    DROP CONSTRAINT PK_Vehiculos;
ALTER TABLE Empleados
    DROP CONSTRAINT PK_Empleados;
ALTER TABLE Repartidores
    DROP CONSTRAINT PK_Repartidores;
ALTER TABLE Asignaciones
    DROP CONSTRAINT PK_Asignaciones;
ALTER TABLE Conductores
    DROP CONSTRAINT PK_Conductores;
ALTER TABLE Logistica
    DROP CONSTRAINT PK_Logisticas;
ALTER TABLE Destinatarios
    DROP CONSTRAINT PK_Destinatarios;
ALTER TABLE Sucursales
    DROP CONSTRAINT PK_Sucursales;

--XConstraints

ALTER TABLE Clientes DROP CONSTRAINT CK_Clientes_direccion;
ALTER TABLE Clientes DROP CONSTRAINT CK_Clientes_tipoId;
ALTER TABLE Clientes DROP CONSTRAINT CK_Clientes_telefono;
ALTER TABLE Clientes DROP CONSTRAINT CK_Clientes_id;
ALTER TABLE Clientes DROP CONSTRAINT CK_Clientes_correo;
ALTER TABLE Envios DROP CONSTRAINT CK_Envios_idEnvio;
ALTER TABLE Envios DROP CONSTRAINT CK_Envios_metodoPago;
ALTER TABLE Envios DROP CONSTRAINT CK_Envios_direccionOrigen;
ALTER TABLE Envios DROP CONSTRAINT CK_Envios_direccionDestino;
ALTER TABLE Categorias DROP CONSTRAINT CK_Categorias_tamanio;
ALTER TABLE  Categorias DROP CONSTRAINT CK_Categorias_peso;
ALTER TABLE Vehiculos DROP CONSTRAINT CK_Vehiculos_capacidad;
ALTER TABLE Vehiculos DROP CONSTRAINT CK_Vehiculos_tipoCombustible;
ALTER TABLE Empleados DROP CONSTRAINT CK_Empleados_id;
ALTER TABLE Empleados DROP CONSTRAINT CK_Empleados_tipoId;
ALTER TABLE Empleados DROP CONSTRAINT CK_Empleados_telefono;
ALTER TABLE Logistica DROP CONSTRAINT CK_Logistica_id;
ALTER TABLE Conductores DROP CONSTRAINT CK_Conductores_id;
ALTER TABLE Conductores DROP CONSTRAINT CK_Conductores_tipoLicencia;
ALTER TABLE Repartidores DROP CONSTRAINT CK_Repartidores_id;
ALTER TABLE Destinatarios DROP CONSTRAINT CK_Destinatarios_id;
ALTER TABLE Destinatarios DROP CONSTRAINT CK_Destinatarios_tipoId;
ALTER TABLE Destinatarios DROP CONSTRAINT CK_Destinatarios_telefono;
ALTER TABLE Destinatarios DROP CONSTRAINT CK_Destinatarios_direccion;
ALTER TABLE Destinatarios DROP CONSTRAINT CK_Destinatarios_correo;
ALTER TABLE Sucursales DROP CONSTRAINT CK_Sucursales_direccion;