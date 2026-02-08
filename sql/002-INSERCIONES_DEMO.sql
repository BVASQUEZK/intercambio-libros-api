-- =========================================
-- DEMO: intercambio_libros
-- =========================================
USE intercambio_libros;

-- =========================================
-- CATEGORIAS
-- =========================================
INSERT IGNORE INTO categoria (nombre) VALUES
('Novela'),
('Ciencia'),
('Historia'),
('Fantasía'),
('Realismo Mágico');

-- =========================================
-- USUARIOS
-- =========================================
INSERT INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil)
SELECT 'Ana M.', 'García', '80010010', 'ana.m@demo.com', '600111222', 'demo123', 'https://cdn.example.com/perfiles/ana.jpg'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE correo = 'ana.m@demo.com');

INSERT INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil)
SELECT 'Carlos R.', 'López', '80010020', 'carlos.r@demo.com', '600333444', 'demo123', 'https://cdn.example.com/perfiles/carlos.jpg'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE correo = 'carlos.r@demo.com');

INSERT INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil)
SELECT 'Lucía P.', 'Martín', '80010030', 'lucia.p@demo.com', '600555666', 'demo123', 'https://cdn.example.com/perfiles/lucia.jpg'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE correo = 'lucia.p@demo.com');

INSERT INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil)
SELECT 'Diego S.', 'Ruiz', '80010040', 'diego.s@demo.com', '600777888', 'demo123', 'https://cdn.example.com/perfiles/diego.jpg'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE correo = 'diego.s@demo.com');

INSERT INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil)
SELECT 'María L.', 'Vega', '80010050', 'maria.l@demo.com', '600999000', 'demo123', 'https://cdn.example.com/perfiles/maria.jpg'
WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE correo = 'maria.l@demo.com');

-- =========================================
-- UBICACIONES
-- =========================================
INSERT INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 40.416775, -3.703790, 'Calle Mayor 1', 'Madrid'
FROM usuario u
WHERE u.correo = 'ana.m@demo.com'
  AND NOT EXISTS (SELECT 1 FROM ubicacion x WHERE x.id_usuario = u.id_usuario);

INSERT INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 41.387015, 2.170047, 'Carrer de la Boqueria 5', 'Barcelona'
FROM usuario u
WHERE u.correo = 'carlos.r@demo.com'
  AND NOT EXISTS (SELECT 1 FROM ubicacion x WHERE x.id_usuario = u.id_usuario);

INSERT INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 39.469907, -0.376288, 'Carrer de la Pau 12', 'Valencia'
FROM usuario u
WHERE u.correo = 'lucia.p@demo.com'
  AND NOT EXISTS (SELECT 1 FROM ubicacion x WHERE x.id_usuario = u.id_usuario);

INSERT INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 37.389092, -5.984459, 'Av. de la Constitución 20', 'Sevilla'
FROM usuario u
WHERE u.correo = 'diego.s@demo.com'
  AND NOT EXISTS (SELECT 1 FROM ubicacion x WHERE x.id_usuario = u.id_usuario);

INSERT INTO ubicacion (id_usuario, latitud, longitud, direccion, ciudad)
SELECT u.id_usuario, 43.362343, -8.411540, 'Calle Real 7', 'A Coruña'
FROM usuario u
WHERE u.correo = 'maria.l@demo.com'
  AND NOT EXISTS (SELECT 1 FROM ubicacion x WHERE x.id_usuario = u.id_usuario);

-- =========================================
-- LIBROS
-- =========================================
INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'Cien años de soledad', 'Gabriel García Márquez', 'Edición cuidada para intercambio.', 'muy bueno'
FROM usuario u, categoria c
WHERE u.correo = 'ana.m@demo.com' AND c.nombre = 'Realismo Mágico'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'Cien años de soledad' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'La sombra del viento', 'Carlos Ruiz Zafón', 'Ligeros signos de uso.', 'bueno'
FROM usuario u, categoria c
WHERE u.correo = 'carlos.r@demo.com' AND c.nombre = 'Novela'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'La sombra del viento' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'El Alquimista', 'Paulo Coelho', 'Listo para intercambio.', 'bueno'
FROM usuario u, categoria c
WHERE u.correo = 'lucia.p@demo.com' AND c.nombre = 'Novela'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'El Alquimista' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'Rayuela', 'Julio Cortázar', 'Clásico en buen estado.', 'aceptable'
FROM usuario u, categoria c
WHERE u.correo = 'lucia.p@demo.com' AND c.nombre = 'Novela'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'Rayuela' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'Sapiens', 'Yuval Noah Harari', 'Lectura imprescindible.', 'muy bueno'
FROM usuario u, categoria c
WHERE u.correo = 'diego.s@demo.com' AND c.nombre = 'Historia'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'Sapiens' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'Breve historia del tiempo', 'Stephen Hawking', 'Excelente estado.', 'muy bueno'
FROM usuario u, categoria c
WHERE u.correo = 'diego.s@demo.com' AND c.nombre = 'Ciencia'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'Breve historia del tiempo' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'El nombre del viento', 'Patrick Rothfuss', 'Como nuevo.', 'nuevo'
FROM usuario u, categoria c
WHERE u.correo = 'maria.l@demo.com' AND c.nombre = 'Fantasía'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'El nombre del viento' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, '1984', 'George Orwell', 'Buen estado.', 'bueno'
FROM usuario u, categoria c
WHERE u.correo = 'carlos.r@demo.com' AND c.nombre = 'Novela'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = '1984' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'El Hobbit', 'J.R.R. Tolkien', 'Portada nueva.', 'muy bueno'
FROM usuario u, categoria c
WHERE u.correo = 'maria.l@demo.com' AND c.nombre = 'Fantasía'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'El Hobbit' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'Los detectives salvajes', 'Roberto Bolaño', 'Copia de colección.', 'muy bueno'
FROM usuario u, categoria c
WHERE u.correo = 'ana.m@demo.com' AND c.nombre = 'Novela'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'Los detectives salvajes' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'Cosmos', 'Carl Sagan', 'Subrayados leves.', 'aceptable'
FROM usuario u, categoria c
WHERE u.correo = 'diego.s@demo.com' AND c.nombre = 'Ciencia'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'Cosmos' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'La tregua', 'Mario Benedetti', 'Muy cuidado.', 'muy bueno'
FROM usuario u, categoria c
WHERE u.correo = 'lucia.p@demo.com' AND c.nombre = 'Novela'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'La tregua' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'Fahrenheit 451', 'Ray Bradbury', 'Buen estado.', 'bueno'
FROM usuario u, categoria c
WHERE u.correo = 'carlos.r@demo.com' AND c.nombre = 'Novela'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'Fahrenheit 451' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'El amor en los tiempos del cólera', 'Gabriel García Márquez', 'Casi nuevo.', 'muy bueno'
FROM usuario u, categoria c
WHERE u.correo = 'ana.m@demo.com' AND c.nombre = 'Realismo Mágico'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'El amor en los tiempos del cólera' AND l.id_usuario = u.id_usuario);

INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
SELECT u.id_usuario, c.id_categoria, 'La historia del arte', 'E. H. Gombrich', 'Colección clásica.', 'aceptable'
FROM usuario u, categoria c
WHERE u.correo = 'maria.l@demo.com' AND c.nombre = 'Historia'
  AND NOT EXISTS (SELECT 1 FROM libro l WHERE l.titulo = 'La historia del arte' AND l.id_usuario = u.id_usuario);

-- =========================================
-- IMAGENES DE LIBROS (1 por libro)
-- =========================================
INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/cien_anos.jpg'
FROM libro l WHERE l.titulo = 'Cien años de soledad'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/sombra_viento.jpg'
FROM libro l WHERE l.titulo = 'La sombra del viento'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/el_alquimista.jpg'
FROM libro l WHERE l.titulo = 'El Alquimista'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/rayuela.jpg'
FROM libro l WHERE l.titulo = 'Rayuela'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/sapiens.jpg'
FROM libro l WHERE l.titulo = 'Sapiens'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/breve_historia_tiempo.jpg'
FROM libro l WHERE l.titulo = 'Breve historia del tiempo'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/nombre_viento.jpg'
FROM libro l WHERE l.titulo = 'El nombre del viento'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/1984.jpg'
FROM libro l WHERE l.titulo = '1984'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/hobbit.jpg'
FROM libro l WHERE l.titulo = 'El Hobbit'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/detectives_salvajes.jpg'
FROM libro l WHERE l.titulo = 'Los detectives salvajes'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/cosmos.jpg'
FROM libro l WHERE l.titulo = 'Cosmos'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/tregua.jpg'
FROM libro l WHERE l.titulo = 'La tregua'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/f451.jpg'
FROM libro l WHERE l.titulo = 'Fahrenheit 451'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/amor_colera.jpg'
FROM libro l WHERE l.titulo = 'El amor en los tiempos del cólera'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

INSERT INTO imagen_libro (id_libro, url_imagen)
SELECT l.id_libro, 'https://cdn.example.com/libros/historia_arte.jpg'
FROM libro l WHERE l.titulo = 'La historia del arte'
  AND NOT EXISTS (SELECT 1 FROM imagen_libro i WHERE i.id_libro = l.id_libro);

-- =========================================
-- SOLICITUDES (3 estados distintos)
-- =========================================
INSERT INTO solicitud (id_solicitante, id_receptor, tipo, estado)
SELECT u1.id_usuario, u2.id_usuario, 'intercambio', 'pendiente'
FROM usuario u1, usuario u2
WHERE u1.correo = 'ana.m@demo.com' AND u2.correo = 'carlos.r@demo.com'
  AND NOT EXISTS (SELECT 1 FROM solicitud s WHERE s.id_solicitante = u1.id_usuario AND s.id_receptor = u2.id_usuario AND s.estado = 'pendiente');

INSERT INTO solicitud (id_solicitante, id_receptor, tipo, estado)
SELECT u1.id_usuario, u2.id_usuario, 'prestamo', 'aceptado'
FROM usuario u1, usuario u2
WHERE u1.correo = 'lucia.p@demo.com' AND u2.correo = 'diego.s@demo.com'
  AND NOT EXISTS (SELECT 1 FROM solicitud s WHERE s.id_solicitante = u1.id_usuario AND s.id_receptor = u2.id_usuario AND s.estado = 'aceptado');

INSERT INTO solicitud (id_solicitante, id_receptor, tipo, estado)
SELECT u1.id_usuario, u2.id_usuario, 'intercambio', 'finalizado'
FROM usuario u1, usuario u2
WHERE u1.correo = 'maria.l@demo.com' AND u2.correo = 'ana.m@demo.com'
  AND NOT EXISTS (SELECT 1 FROM solicitud s WHERE s.id_solicitante = u1.id_usuario AND s.id_receptor = u2.id_usuario AND s.estado = 'finalizado');

-- =========================================
-- DETALLE_SOLICITUD (libros solicitados)
-- =========================================
INSERT INTO detalle_solicitud (id_solicitud, id_libro, propietario)
SELECT s.id_solicitud, l.id_libro, 'receptor'
FROM solicitud s, libro l
WHERE s.estado = 'pendiente' AND l.titulo = 'La sombra del viento'
  AND NOT EXISTS (SELECT 1 FROM detalle_solicitud d WHERE d.id_solicitud = s.id_solicitud);

INSERT INTO detalle_solicitud (id_solicitud, id_libro, propietario)
SELECT s.id_solicitud, l.id_libro, 'receptor'
FROM solicitud s, libro l
WHERE s.estado = 'aceptado' AND l.titulo = 'Sapiens'
  AND NOT EXISTS (SELECT 1 FROM detalle_solicitud d WHERE d.id_solicitud = s.id_solicitud);

INSERT INTO detalle_solicitud (id_solicitud, id_libro, propietario)
SELECT s.id_solicitud, l.id_libro, 'receptor'
FROM solicitud s, libro l
WHERE s.estado = 'finalizado' AND l.titulo = 'Cien años de soledad'
  AND NOT EXISTS (SELECT 1 FROM detalle_solicitud d WHERE d.id_solicitud = s.id_solicitud);

-- =========================================
-- RESEÑAS (para reputación)
-- =========================================
INSERT INTO resena (id_solicitud, id_evaluador, id_evaluado, puntuacion, comentario)
SELECT s.id_solicitud, u1.id_usuario, u2.id_usuario, 5, 'Excelente intercambio.'
FROM solicitud s, usuario u1, usuario u2
WHERE s.estado = 'finalizado'
  AND u1.correo = 'maria.l@demo.com'
  AND u2.correo = 'ana.m@demo.com'
  AND NOT EXISTS (SELECT 1 FROM resena r WHERE r.id_solicitud = s.id_solicitud AND r.id_evaluador = u1.id_usuario);

INSERT INTO resena (id_solicitud, id_evaluador, id_evaluado, puntuacion, comentario)
SELECT s.id_solicitud, u1.id_usuario, u2.id_usuario, 4, 'Todo correcto.'
FROM solicitud s, usuario u1, usuario u2
WHERE s.estado = 'aceptado'
  AND u1.correo = 'lucia.p@demo.com'
  AND u2.correo = 'diego.s@demo.com'
  AND NOT EXISTS (SELECT 1 FROM resena r WHERE r.id_solicitud = s.id_solicitud AND r.id_evaluador = u1.id_usuario);
