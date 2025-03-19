
CREATE TABLE clientes(
    id_cliente int primary key auto_increment, 
    nombre varchar(100) not null, 
    telefono varchar(15) not null, 
    email varchar(100) not null,
    direccion text not null
);


CREATE TABLE prendas(
    id_prenda int primary key auto_increment,
    nombre varchar(100) NOT NULL,
    descripcion text NOT NULL,
    precio decimal(10,2) NOT NULL,
    tipo ENUM('traje', 'camisa', 'pantalon', 'chaleco', 'abrigo') NOT NULL
);


CREATE TABLE ordenes (
    id_orden int primary key auto_increment,
    id_cliente INT NOT NULL,
    fecha date,
    total DECIMAL(10,2) NOT NULL,
    estado ENUM('pendiente', 'en proceso', 'terminado', 'entregado'),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);


CREATE TABLE detalles_orden (
    id_detalles int primary key auto_increment,
    id_orden INT NOT NULL,
    id_prenda INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden),
    FOREIGN KEY (id_prenda) REFERENCES prendas(id_prenda)
);


CREATE TABLE medidas (
    id_medidas int primary key auto_increment,
    id_cliente INT NOT NULL,
    pecho DECIMAL(5,2),
    cintura DECIMAL(5,2),
    cadera DECIMAL(5,2),
    largo_manga DECIMAL(5,2),
    largo_pantalon DECIMAL(5,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);


INSERT INTO clientes (nombre, telefono, email, direccion) VALUES
('Carlos Pérez', '3111234567', 'carlos.perez@email.com', 'Cra 10 #15-20, Bogotá'),
('María Gómez', '3207654321', 'maria.gomez@email.com', 'Cl 45 #7-89, Bogotá'),
('Luis Rodríguez', '3159876543', 'luis.rodriguez@email.com', 'Av. Caracas #30-25, Bogotá'),
('Ana Torres', '3126789012', 'ana.torres@email.com', 'Cl 8 #20-10, Bogotá'),
('José Fernández', '3143456789', 'jose.fernandez@email.com', 'Cra 50 #12-45, Bogotá');


INSERT INTO prendas (nombre, descripcion, precio, tipo) VALUES
('Traje Ejecutivo', 'Traje formal para oficina, color negro.', 850000.00, 'traje'),
('Camisa de Algodón', 'Camisa blanca de algodón, manga larga.', 150000.00, 'camisa'),
('Pantalón de Vestir', 'Pantalón de vestir color gris, slim fit.', 220000.00, 'pantalon'),
('Chaleco Elegante', 'Chaleco de lino color azul marino.', 180000.00, 'chaleco'),
('Abrigo de Invierno', 'Abrigo de lana para invierno, color beige.', 700000.00, 'abrigo');


INSERT INTO ordenes (id_cliente, total, estado) VALUES
(1, 1000000.00, 'pendiente'),
(2, 850000.00, 'en proceso'),
(3, 400000.00, 'terminado'),
(4, 150000.00, 'entregado'),
(5, 180000.00, 'pendiente');


INSERT INTO detalles_orden (id_orden, id_prenda, cantidad, precio_unitario) VALUES
(1, 1, 1, 850000.00),  -- Traje Ejecutivo
(1, 2, 1, 150000.00),  -- Camisa de Algodón
(2, 1, 1, 850000.00),  -- Traje Ejecutivo
(3, 3, 1, 220000.00),  -- Pantalón de Vestir
(3, 4, 1, 180000.00);  -- Chaleco Elegante


INSERT INTO medidas (id_cliente, pecho, cintura, cadera, largo_manga, largo_pantalon) VALUES
(1, 105.0, 90.0, 100.0, 65.0, 105.0),
(2, 98.0, 85.0, 96.0, 63.0, 102.0),
(3, 110.0, 95.0, 110.0, 68.0, 108.0),
(4, 100.0, 88.0, 98.0, 64.0, 104.0),
(5, 103.0, 92.0, 105.0, 66.0, 107.0);



DELETE FROM detalles_orden 
WHERE id_orden IN (SELECT id_orden FROM ordenes WHERE id_cliente=3);


DELETE FROM ordenes WHERE id_cliente = 3;


DELETE FROM medidas WHERE id_cliente = 3;


DELETE FROM clientes WHERE id_cliente = 3;



UPDATE clientes 
SET telefono = '3109998888' 
WHERE id_cliente = 1;


UPDATE ordenes 
SET estado = 'entregado' 
WHERE id_orden = 2;



SELECT ordenes.id_orden AS id_ord, clientes.nombre, ordenes.total, ordenes.estado
FROM ordenes
INNER JOIN clientes ON ordenes.id_orden = clientes.id_cliente;


SELECT detalles_orden.id_orden, prendas.nombre AS prenda, detalles_orden.cantidad, detalles_orden.precio_unitario
FROM detalles_orden
INNER JOIN prendas ON detalles_orden.id_prenda = prendas.id_prenda;



SELECT clientes.nombre, ordenes.id_orden AS id_ord, ordenes.total, ordenes.estado
FROM clientes
LEFT JOIN ordenes ON clientes.id_cliente = ordenes.id_cliente;


SELECT ordenes.id_orden AS id_ord, detalles_orden.id_prenda, detalles_orden.cantidad
FROM ordenes
LEFT JOIN detalles_orden ON ordenes.id_orden = detalles_orden.id_orden;


SELECT clientes.nombre, medidas.pecho, medidas.cintura, medidas.cadera
FROM clientes
LEFT JOIN medidas ON clientes.id_cliente = medidas.id_cliente;



SELECT prendas.nombre AS prenda, detalles_orden.id_orden, detalles_orden.cantidad
FROM detalles_orden
RIGHT JOIN prendas ON detalles_orden.id_prenda = prendas.id_prenda;


SELECT prendas.nombre AS prenda, detalles_orden.id_orden, detalles_orden.cantidad
FROM detalles_orden
RIGHT JOIN prendas ON detalles_orden.id_prenda = prendas.id_prenda;
