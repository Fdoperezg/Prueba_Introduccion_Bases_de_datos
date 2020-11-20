-- PARTE 1 --: Referirse a archivo 'Modelo_logico_prueba.xml'

-- PARTE 2 --
--Crear base de datos Prueba 
CREATE DATABASE prueba;

--Crear tabla Cliente
CREATE TABLE clientes(
    id_cliente SERIAL, 
    nombre_cliente VARCHAR(255) NOT NULL, 
    rut_cliente INT NOT NULL UNIQUE, 
    direccion_cliente VARCHAR(255), 
    PRIMARY KEY(id_cliente)
);

--Crear tabla Categoría
CREATE TABLE categorias(
    id_categoria SERIAL, 
    nombre_categoria VARCHAR(255) NOT NULL, 
    descripcion_categoria VARCHAR(255), 
    PRIMARY KEY(id_categoria)
);

--Crear tabla Producto
CREATE TABLE productos(
    id_producto SERIAL, 
    nombre_producto VARCHAR(255) NOT NULL, 
    descripcion_producto VARCHAR(255), 
    valor_unitario FLOAT, 
    id_categoria INT, 
    PRIMARY KEY(id_producto), 
    FOREIGN KEY(id_categoria) REFERENCES categorias(id_categoria)
);

--Crear tabla Factura
CREATE TABLE facturas(
    numero_factura INT NOT NULL UNIQUE,
    fecha_factura DATE, 
    subtotal FLOAT, 
    iva FLOAT, 
    precio_total FLOAT,
    id_cliente INT,  
    PRIMARY KEY(numero_factura), 
    FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente)
);

--crear tabla Facturas_Productos
CREATE TABLE facturas_productos(
    numero_factura INT NOT NULL, 
    precio_unitario FLOAT NOT NULL,
    cantidad INT NOT NULL,  
    valor_total FLOAT NOT NULL,
    id_producto INT NOT NULL,  
    FOREIGN KEY(numero_factura) REFERENCES facturas(numero_factura), 
    FOREIGN KEY(id_producto) REFERENCES productos(id_producto)
);

--Insertar 5 clientes
--Aquí se usa SERIAL para el id_cliente, por lo que no es necesario ponerlo
INSERT INTO clientes (nombre_cliente, rut_cliente, direccion_cliente) 
VALUES ('Fernando', 18099564, 'Calle Montaña');
INSERT INTO clientes (nombre_cliente, rut_cliente, direccion_cliente)  
VALUES('Ignacio', 5022568, 'Calle Cerro');
INSERT INTO clientes (nombre_cliente, rut_cliente, direccion_cliente)  
VALUES('Julia', 11056866, 'Calle Cordillera'); 
INSERT INTO clientes (nombre_cliente, rut_cliente, direccion_cliente) 
VALUES('Alicia', 20568935, 'Calle Montículo'); 
INSERT INTO clientes (nombre_cliente, rut_cliente, direccion_cliente) 
VALUES('Nahuel', 19548563, 'Calle Cerrito');

-- Insertar 3 categorías
--Aquí se usa SERIAL para el id_categoria, por lo que no es necesario ponerlo
INSERT INTO categorias(nombre_categoria, descripcion_categoria) 
VALUES ('juegos', 'softwares para consolas'); 
INSERT INTO categorias(nombre_categoria, descripcion_categoria)
VALUES ('consolas', 'hardware para jugar videojuegos'); 
INSERT INTO categorias(nombre_categoria, descripcion_categoria)
VALUES ('controles', 'perifericos para consolas');

--Insertar 8 productos
--Aquí se usa SERIAL para el id_producto, por lo que no es necesario ponerlo
INSERT INTO productos(nombre_producto, descripcion_producto, valor_unitario, id_categoria) 
VALUES('The legend of Zelda: Ganon revenge', 'Nuevo juego de Zelda', 50, 1); 
INSERT INTO productos(nombre_producto, descripcion_producto, valor_unitario, id_categoria) 
VALUES('The last of us Part III', 'Tercera parte de la saga', 50, 1);
INSERT INTO productos(nombre_producto, descripcion_producto, valor_unitario, id_categoria) 
VALUES('Assasins Creed Toqui', 'Reciente entrega ubicada en el sur de Chile y Argentina', 50, 1);
INSERT INTO productos(nombre_producto, descripcion_producto, valor_unitario, id_categoria) 
VALUES('Nintendo Switch', 'La última consola de Nintendo', 200, 2); 
INSERT INTO productos(nombre_producto, descripcion_producto, valor_unitario, id_categoria) 
VALUES('PlayStation 5', 'La última consola de Sony', 300, 2);
INSERT INTO productos(nombre_producto, descripcion_producto, valor_unitario, id_categoria) 
VALUES('Xbox series X', 'La última consola de Microsoft', 300, 2); 
INSERT INTO productos(nombre_producto, descripcion_producto, valor_unitario, id_categoria) 
VALUES('JoyCon', 'Control de Nintendo Switch', 70, 3); 
INSERT INTO productos(nombre_producto, descripcion_producto, valor_unitario, id_categoria) 
VALUES('DualSense', 'Control de PlayStation 5', 90, 3);

-- Insertar 10 facturas
--2 para el cliente 1, con 2 y 3 productos
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (1, 1, '2020-11-17', 100, 19, 119);
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (2, 1, '2020-11-17', 210, 39.90, 249.90);
--3 para el cliente 2, con 3, 2 y 3 productos
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (3, 2, '2020-11-17', 150, 28.50, 178.50);
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (4, 2, '2020-11-18', 400, 76, 476);
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (5, 2, '2020-11-18', 800, 152, 952);
--1 para el cliente 3, con 1 producto
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (6, 3, '2020-11-19', 50, 9.50, 59.50);
--4 para el cliente 4, con 2, 3, 4 y 1 producto
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (7, 4, '2020-11-18', 100, 19, 119);
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (8, 4, '2020-11-19', 550, 104.50, 654.50);
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (9, 4, '2020-11-19', 870, 165.30, 1035.30);
INSERT INTO facturas(numero_factura, id_cliente, fecha_factura, subtotal, iva, precio_total)
VALUES (10, 4, '2020-11-19', 50, 9.50, 59.50);

-- PARTE 3 --

--Primera consulta: ¿Quién realizó la compra más cara?
SELECT clientes.nombre_cliente, facturas.precio_total FROM clientes 
INNER JOIN facturas 
ON clientes.id_cliente = facturas.id_cliente
WHERE precio_total IN
    (SELECT MAX(precio_total) FROM facturas);

--Segunda consulta: ¿Qué cliente pagó sobre 100 de monto?
SELECT nombre_cliente, facturas.precio_total FROM clientes 
INNER JOIN facturas
ON clientes.id_cliente = facturas.id_cliente
WHERE precio_total > 100;

--Tercera consulta: ¿Cuántos clientes han comprado el producto 6?
SELECT COUNT(DISTINCT clientes.id_cliente) FROM clientes 
INNER JOIN facturas ON clientes.id_cliente = facturas.id_cliente 
INNER JOIN Facturas_Productos ON facturas.numero_factura = Facturas_Productos.numero_factura 
WHERE Facturas_Productos.id_producto = 6;