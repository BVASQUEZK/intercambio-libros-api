-- =========================================
-- SEMILLAS DE DATOS: intercambio_libros
-- =========================================
USE intercambio_libros;

-- =========================================
-- CATEGORIAS
-- =========================================
INSERT IGNORE INTO categoria (nombre) VALUES
('Realismo Mágico'),
('Novela'),
('Ficción');

-- =========================================
-- USUARIOS
-- =========================================
INSERT INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil)
SELECT 'Ana M.', 'García', '70010010', 'ana.m@example.com', '600111222', 'demo123', 'https://cdn.example.com/perfiles/ana.jpg'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE correo = 'ana.m@example.com');

INSERT INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil)
SELECT 'Carlos R.', 'López', '70010020', 'carlos.r@example.com', '600333444', 'demo123', 'https://cdn.example.com/perfiles/carlos.jpg'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE correo = 'carlos.r@example.com');

INSERT INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil)
SELECT 'Lucía P.', 'Martín', '70010030', 'lucia.p@example.com', '600555666', 'demo123', 'https://cdn.example.com/perfiles/lucia.jpg'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE correo = 'lucia.p@example.com');

-- =========================================
-- UBICACIONES
-- =========================================
INSERT INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 40.416775, -3.703790, 'Calle Mayor 1', 'Madrid'
FROM usuario u
WHERE u.correo = 'ana.m@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM ubicacion x
      WHERE x.id_usuario = u.id_usuario AND x.direccion = 'Calle Mayor 1'
  );

INSERT INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 41.387015, 2.170047, 'Carrer de la Boqueria 5', 'Barcelona'
FROM usuario u
WHERE u.correo = 'carlos.r@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM ubicacion x
      WHERE x.id_usuario = u.id_usuario AND x.direccion = 'Carrer de la Boqueria 5'
  );

INSERT INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 39.469907, -0.376288, 'Carrer de la Pau 12', 'Valencia'
FROM usuario u
WHERE u.correo = 'lucia.p@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM ubicacion x
      WHERE x.id_usuario = u.id_usuario AND x.direccion = 'Carrer de la Pau 12'
  );

-- =========================================
-- LIBROS (SINCRONIZADOS CON MOCKUPS)
-- =========================================
INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario,
       (SELECT c.id_categoria FROM categoria c WHERE c.nombre = 'Realismo Mágico'),
       'Cien años de soledad',
       'Gabriel García Márquez',
       'Edición en excelente estado para intercambio.',
       'muy bueno'
FROM usuario u
WHERE u.correo = 'ana.m@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM libro l
      WHERE l.titulo = 'Cien años de soledad' AND l.id_usuario = u.id_usuario
  );

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario,
       (SELECT c.id_categoria FROM categoria c WHERE c.nombre = 'Novela'),
       'La sombra del viento',
       'Carlos Ruiz Zafón',
       'Libro con ligeros signos de uso.',
       'bueno'
FROM usuario u
WHERE u.correo = 'carlos.r@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM libro l
      WHERE l.titulo = 'La sombra del viento' AND l.id_usuario = u.id_usuario
  );

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario,
       (SELECT c.id_categoria FROM categoria c WHERE c.nombre = 'Ficción'),
       'El Alquimista',
       'Paulo Coelho',
       'Listo para intercambio o préstamo.',
       'bueno'
FROM usuario u
WHERE u.correo = 'lucia.p@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM libro l
      WHERE l.titulo = 'El Alquimista' AND l.id_usuario = u.id_usuario
  );

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario,
       (SELECT c.id_categoria FROM categoria c WHERE c.nombre = 'Novela'),
       'Rayuela',
       'Julio Cortázar',
       'Edición clásica en buen estado.',
       'aceptable'
FROM usuario u
WHERE u.correo = 'lucia.p@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM libro l
      WHERE l.titulo = 'Rayuela' AND l.id_usuario = u.id_usuario
  );
