-- =========================================
-- BASE DE DATOS: intercambio_libros
-- =========================================
CREATE DATABASE IF NOT EXISTS intercambio_libros;
USE intercambio_libros;

-- =========================================
-- TABLA: usuario
-- =========================================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dni VARCHAR(15) NOT NULL UNIQUE,
    correo VARCHAR(120) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    url_foto_perfil VARCHAR(500),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado ENUM('activo','suspendido') DEFAULT 'activo'
);

-- =========================================
-- TABLA: ubicacion
-- =========================================
CREATE TABLE ubicacion (
    id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    latitud DECIMAL(10,8),
    longitud DECIMAL(11,8),
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- =========================================
-- TABLA: categoria
-- =========================================
CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE
);

-- =========================================
-- TABLA: libro
-- =========================================
CREATE TABLE libro (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_categoria INT,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(150),
    descripcion TEXT,
    estado ENUM('nuevo','muy bueno','bueno','aceptable'),
    ubicacion VARCHAR(255),
    disponible BOOLEAN DEFAULT TRUE,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- =========================================
-- TABLA: imagen_libro
-- =========================================
CREATE TABLE imagen_libro (
    id_imagen INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT NOT NULL,
    url_imagen VARCHAR(500),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
);

-- =========================================
-- TABLA: disponibilidad_libro
-- =========================================
CREATE TABLE disponibilidad_libro (
    id_disponibilidad INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT NOT NULL,
    tipo ENUM('intercambio','prestamo','ambos'),
    precio_prestamo DECIMAL(8,2) DEFAULT 0,
    tiempo_max_prestamo INT,
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
);

-- =========================================
-- TABLA: solicitud
-- =========================================
CREATE TABLE solicitud (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
    id_solicitante INT NOT NULL,
    id_receptor INT NOT NULL,
    tipo ENUM('intercambio','prestamo'),
    estado ENUM('pendiente','aceptado','rechazado','finalizado','cancelado') DEFAULT 'pendiente',
    fecha_solicitud DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_solicitante) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_receptor) REFERENCES usuario(id_usuario)
);

-- =========================================
-- TABLA: detalle_solicitud
-- =========================================
CREATE TABLE detalle_solicitud (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_solicitud INT NOT NULL,
    id_libro INT NOT NULL,
    propietario ENUM('solicitante','receptor'),
    FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
);

-- =========================================
-- TABLA: encuentro
-- =========================================
CREATE TABLE encuentro (
    id_encuentro INT AUTO_INCREMENT PRIMARY KEY,
    id_solicitud INT NOT NULL,
    latitud DECIMAL(10,8),
    longitud DECIMAL(11,8),
    direccion VARCHAR(255),
    fecha_hora DATETIME,
    estado ENUM('pendiente','realizado','cancelado'),
    FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud)
);

-- =========================================
-- TABLA: resena
-- =========================================
CREATE TABLE resena (
    id_resena INT AUTO_INCREMENT PRIMARY KEY,
    id_solicitud INT NOT NULL,
    id_evaluador INT NOT NULL,
    id_evaluado INT NOT NULL,
    puntuacion INT CHECK (puntuacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud),
    FOREIGN KEY (id_evaluador) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_evaluado) REFERENCES usuario(id_usuario)
);

-- =========================================
-- TABLA: mensaje
-- =========================================
CREATE TABLE mensaje (
    id_mensaje INT AUTO_INCREMENT PRIMARY KEY,
    id_solicitud INT NOT NULL,
    id_emisor INT NOT NULL,
    contenido TEXT,
    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE,
    INDEX idx_mensaje_solicitud (id_solicitud),
    INDEX idx_mensaje_emisor (id_emisor),
    FOREIGN KEY (id_solicitud) REFERENCES solicitud(id_solicitud),
    FOREIGN KEY (id_emisor) REFERENCES usuario(id_usuario)
);
