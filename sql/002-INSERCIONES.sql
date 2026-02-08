-- =========================================
-- INSERCIONES (SOLO INSERT)
-- =========================================
USE intercambio_libros;

-- =========================================
-- CATEGORIAS
-- =========================================
INSERT IGNORE INTO categoria (nombre) VALUES
('Terror'),
('Ciencia Ficción'),
('Romántico'),
('Fantasía'),
('Historia'),
('Realismo Mágico'),
('Novela');

-- =========================================
-- USUARIOS (min 5)
-- =========================================
INSERT IGNORE INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil) VALUES
('Ana M.', 'García', '90010010', 'ana.m@demo.com', '600111222', 'demo123', 'https://cdn.example.com/perfiles/ana.jpg'),
('Carlos R.', 'López', '90010020', 'carlos.r@demo.com', '600333444', 'demo123', 'https://cdn.example.com/perfiles/carlos.jpg'),
('Lucía P.', 'Martín', '90010030', 'lucia.p@demo.com', '600555666', 'demo123', 'https://cdn.example.com/perfiles/lucia.jpg'),
('Diego S.', 'Ruiz', '90010040', 'diego.s@demo.com', '600777888', 'demo123', 'https://cdn.example.com/perfiles/diego.jpg'),
('María L.', 'Vega', '90010050', 'maria.l@demo.com', '600999000', 'demo123', 'https://cdn.example.com/perfiles/maria.jpg');

-- =========================================
-- UBICACIONES
-- =========================================
INSERT IGNORE INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 40.416775, -3.703790, 'Calle Mayor 1', 'Madrid'
FROM usuario u WHERE u.correo = 'ana.m@demo.com';

INSERT IGNORE INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 41.387015, 2.170047, 'Carrer de la Boqueria 5', 'Barcelona'
FROM usuario u WHERE u.correo = 'carlos.r@demo.com';

INSERT IGNORE INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 39.469907, -0.376288, 'Carrer de la Pau 12', 'Valencia'
FROM usuario u WHERE u.correo = 'lucia.p@demo.com';

INSERT IGNORE INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 37.389092, -5.984459, 'Av. de la Constitución 20', 'Sevilla'
FROM usuario u WHERE u.correo = 'diego.s@demo.com';

INSERT IGNORE INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 43.362343, -8.411540, 'Calle Real 7', 'A Coruña'
FROM usuario u WHERE u.correo = 'maria.l@demo.com';

-- =========================================
-- LIBROS (disponible = 1)
-- =========================================
INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, 'Cien años de soledad', 'Gabriel García Márquez', 'Edición cuidada.', 'muy bueno', 1
FROM usuario u, categoria c
WHERE u.correo = 'ana.m@demo.com' AND c.nombre = 'Realismo Mágico';

INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, 'La sombra del viento', 'Carlos Ruiz Zafón', 'Ligeros signos de uso.', 'bueno', 1
FROM usuario u, categoria c
WHERE u.correo = 'carlos.r@demo.com' AND c.nombre = 'Novela';

INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, 'El Alquimista', 'Paulo Coelho', 'Listo para intercambio.', 'bueno', 1
FROM usuario u, categoria c
WHERE u.correo = 'lucia.p@demo.com' AND c.nombre = 'Romántico';

INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, 'Rayuela', 'Julio Cortázar', 'Clásico en buen estado.', 'aceptable', 1
FROM usuario u, categoria c
WHERE u.correo = 'lucia.p@demo.com' AND c.nombre = 'Novela';

INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, 'Sapiens', 'Yuval Noah Harari', 'Lectura imprescindible.', 'muy bueno', 1
FROM usuario u, categoria c
WHERE u.correo = 'diego.s@demo.com' AND c.nombre = 'Historia';

INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, 'Breve historia del tiempo', 'Stephen Hawking', 'Excelente estado.', 'muy bueno', 1
FROM usuario u, categoria c
WHERE u.correo = 'diego.s@demo.com' AND c.nombre = 'Ciencia Ficción';

INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, 'El nombre del viento', 'Patrick Rothfuss', 'Como nuevo.', 'nuevo', 1
FROM usuario u, categoria c
WHERE u.correo = 'maria.l@demo.com' AND c.nombre = 'Fantasía';

INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, '1984', 'George Orwell', 'Buen estado.', 'bueno', 1
FROM usuario u, categoria c
WHERE u.correo = 'carlos.r@demo.com' AND c.nombre = 'Ciencia Ficción';

INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, 'Drácula', 'Bram Stoker', 'Edición clásica.', 'aceptable', 1
FROM usuario u, categoria c
WHERE u.correo = 'ana.m@demo.com' AND c.nombre = 'Terror';

INSERT IGNORE INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, disponible)
SELECT u.id_usuario, c.id_categoria, 'El Hobbit', 'J.R.R. Tolkien', 'Portada nueva.', 'muy bueno', 1
FROM usuario u, categoria c
WHERE u.correo = 'maria.l@demo.com' AND c.nombre = 'Fantasía';

-- =========================================
-- IMAGENES DE LIBROS
-- =========================================
INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/cien_anos.jpg'
FROM libro l WHERE l.titulo = 'Cien años de soledad';

INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/sombra_viento.jpg'
FROM libro l WHERE l.titulo = 'La sombra del viento';

INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/el_alquimista.jpg'
FROM libro l WHERE l.titulo = 'El Alquimista';

INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/rayuela.jpg'
FROM libro l WHERE l.titulo = 'Rayuela';

INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/sapiens.jpg'
FROM libro l WHERE l.titulo = 'Sapiens';

INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/breve_historia_tiempo.jpg'
FROM libro l WHERE l.titulo = 'Breve historia del tiempo';

INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/nombre_viento.jpg'
FROM libro l WHERE l.titulo = 'El nombre del viento';

INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/1984.jpg'
FROM libro l WHERE l.titulo = '1984';

INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/dracula.jpg'
FROM libro l WHERE l.titulo = 'Drácula';

INSERT IGNORE INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/hobbit.jpg'
FROM libro l WHERE l.titulo = 'El Hobbit';
