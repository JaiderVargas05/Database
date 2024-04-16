CREATE TABLE Clientes(
    id NUMBER(10) NOT NULL,
    tipoId VARCHAR(2) NOT NULL,
    nombre VARCHAR(70) NOT NULL,
    direccion VARCHAR(250) NOT NULL,
    telefono NUMBER(10) NOT NULL,
    correo VARCHAR(100) NOT NULL
);

CREATE TABLE Envios(
    idEnvio NUMBER(20) NOT NULL,
    idCliente NUMBER(10) NOT NULL,
    idDestinatario NUMBER(10) NOT NULL,
    fecha DATE NOT NULL,
    direccionOrigen VARCHAR(250) NOT NULL,
    direccionDestino VARCHAR(250) NOT NULL,
    idLogistica NUMBER(10) NOT NULL,
    vehiculo VARCHAR(9) NOT NULL,   
    metodoPago VARCHAR(8) NOT NULL,
    pago NUMBER(20) NOT NULL
);
CREATE TABLE Contiene(
    producto NUMBER(10) NOT NULL,
    envio NUMBER(20) NOT NULL,
    cant NUMBER(3) 
    
);
CREATE TABLE Productos(
    idProducto NUMBER(20) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    categoria VARCHAR(20) NOT NULL,
    valorEstimado NUMBER(8) NOT NULL
);
CREATE TABLE Categorias(
    idCategoria  VARCHAR(20) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    tamanio VARCHAR(1) NOT NULL,
    peso VARCHAR(1) NOT NULL,
    descripcion VARCHAR(80));
CREATE TABLE Sucursales(
    id NUMBER(20) NOT NULL,
    direccion VARCHAR(250) NOT NULL
);
CREATE TABLE Vehiculos(
    conductor NUMBER(10) NOT NULL,
    placa VARCHAR(9) NOT NULL,
    soat VARCHAR(20) NOT NULL,
    capacidad VARCHAR(1) NOT NULL,
    tipoCombustible VARCHAR(2) NOT NULL,
    modelo VARCHAR(4)
    );

CREATE TABLE Destinatarios(
    id NUMBER(20) NOT NULL,
    tipoId VARCHAR(10) NOT NULL,
    nombre VARCHAR(70) NOT NULL,
    direccion VARCHAR(250),
    telefono NUMBER(10) NOT NULL,
    correo VARCHAR(100)
    );
CREATE TABLE Empleados(
    id NUMBER(10) NOT NULL,
    tipoId VARCHAR(2) NOT NULL,
    nombre VARCHAR(70) NOT NULL,
    salario NUMBER(8) NOT NULL,
    eps VARCHAR(30) NOT NULL,
    telefono NUMBER(10) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    fechaContratacion DATE NOT NULL,
    finContrato DATE,
    sucursal NUMBER(20) NOT NULL
);

CREATE TABLE Repartidores(
    id NUMBER(10) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    estadoSalud VARCHAR(20) NOT NULL
);
CREATE TABLE Asignaciones(
    placa VARCHAR(9) NOT NULL,
    idRepartidor NUMBER(10) NOT NULL
);
CREATE TABLE Conductores(
    id NUMBER(10) NOT NULL,
    licencia VARCHAR(20) NOT NULL,
    fechaExpiracion DATE NOT NULL,
    tipoLicencia VARCHAR(2) NOT NULL
);
CREATE TABLE Logistica(
    id NUMBER(10) NOT NULL,
    nivelEducativo VARCHAR(20) NOT NULL);
    
--XTablas

DROP TABLE Asignaciones;
DROP TABLE Contiene;
DROP TABLE Repartidores;
DROP TABLE Productos;
DROP TABLE Categorias;
DROP TABLE Envios;
DROP TABLE Clientes;
DROP TABLE Destinatarios;
DROP TABLE Vehiculos;
DROP TABLE Conductores;
DROP TABLE Logistica;
DROP TABLE Empleados;
DROP TABLE Sucursales;