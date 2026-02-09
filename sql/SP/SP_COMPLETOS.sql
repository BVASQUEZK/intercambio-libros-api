-- =========================================
-- SP COMPLETOS - intercambiolibrosapi
-- =========================================
USE intercambio_libros;

-- =========================================
-- ELIMINAR SP (USUARIO, CATEGORIA, LIBRO)
-- =========================================
DROP PROCEDURE IF EXISTS sp_login_usuario_app;
DROP PROCEDURE IF EXISTS sp_registrar_usuario_app;
DROP PROCEDURE IF EXISTS sp_actualizar_perfil;
DROP PROCEDURE IF EXISTS sp_listar_categorias;
DROP PROCEDURE IF EXISTS sp_registrar_libro;
DROP PROCEDURE IF EXISTS sp_listar_libros_recientes;
DROP PROCEDURE IF EXISTS sp_buscar_libros_filtros;
DROP PROCEDURE IF EXISTS sp_vincular_imagen_libro;

-- =========================================
-- MÓDULO USUARIO: sp_login_usuario_app
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_login_usuario_app(
    IN p_correo VARCHAR(120),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT id_usuario,
           nombres,
           apellidos,
           correo
    FROM usuario
    WHERE correo = p_correo
      AND password = p_password;
END $$
DELIMITER ;

-- =========================================
-- MÓDULO USUARIO: sp_registrar_usuario_app
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_registrar_usuario_app(
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_correo VARCHAR(120),
    IN p_password VARCHAR(255)
)
BEGIN
    INSERT INTO usuario (nombres, apellidos, correo, password)
    VALUES (p_nombres, p_apellidos, p_correo, p_password);

    SELECT LAST_INSERT_ID() AS id_usuario;
END $$
DELIMITER ;

-- =========================================
-- MÓDULO USUARIO: sp_actualizar_perfil
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_actualizar_perfil(
    IN p_id_usuario INT,
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_url_foto VARCHAR(500)
)
BEGIN
    UPDATE usuario
    SET nombres = p_nombres,
        apellidos = p_apellidos,
        url_foto_perfil = p_url_foto
    WHERE id_usuario = p_id_usuario;
END $$
DELIMITER ;

-- =========================================
-- MÓDULO CATEGORÍA: sp_listar_categorias
-- =========================================
DELIMITER //
CREATE PROCEDURE sp_listar_categorias()
BEGIN
    SELECT c.id_categoria AS id_categoria,
           c.nombre AS nombre
    FROM categoria c
    ORDER BY c.nombre ASC;
END //
DELIMITER ;

-- =========================================
-- MÓDULO LIBRO: sp_registrar_libro
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_registrar_libro(
    IN p_id_usuario INT,
    IN p_id_categoria INT,
    IN p_titulo VARCHAR(150),
    IN p_autor VARCHAR(150),
    IN p_descripcion TEXT,
    IN p_estado ENUM('nuevo','muy bueno','bueno','aceptable'),
    IN p_url_imagen VARCHAR(500),
    OUT p_id_libro INT
)
BEGIN
    INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado)
    VALUES (p_id_usuario, p_id_categoria, p_titulo, p_autor, p_descripcion, p_estado);

    SET p_id_libro = LAST_INSERT_ID();

    INSERT INTO imagen_libro (id_libro, url_imagen)
    VALUES (p_id_libro, p_url_imagen);
END $$
DELIMITER ;

-- =========================================
-- MÓDULO LIBRO: sp_listar_libros_recientes
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_listar_libros_recientes(
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT l.id_libro AS id_libro,
           l.titulo AS titulo,
           l.autor AS autor,
           img.url_imagen AS url_portada
    FROM libro l
    LEFT JOIN (
        SELECT i.id_libro, MIN(i.id_imagen) AS id_imagen
        FROM imagen_libro i
        GROUP BY i.id_libro
    ) img_min ON img_min.id_libro = l.id_libro
    LEFT JOIN imagen_libro img ON img.id_imagen = img_min.id_imagen
    ORDER BY l.fecha_registro DESC
    LIMIT p_limit OFFSET p_offset;
END $$
DELIMITER ;

-- =========================================
-- MÓDULO LIBRO: sp_buscar_libros_filtros
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_buscar_libros_filtros(
    IN p_titulo VARCHAR(150),
    IN p_autor VARCHAR(150),
    IN p_id_categoria INT,
    IN p_estado ENUM('nuevo','muy bueno','bueno','aceptable'),
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT l.id_libro AS id_libro,
           l.titulo AS titulo,
           l.autor AS autor,
           img.url_imagen AS url_portada
    FROM libro l
    LEFT JOIN (
        SELECT i.id_libro, MIN(i.id_imagen) AS id_imagen
        FROM imagen_libro i
        GROUP BY i.id_libro
    ) img_min ON img_min.id_libro = l.id_libro
    LEFT JOIN imagen_libro img ON img.id_imagen = img_min.id_imagen
    WHERE (p_titulo IS NULL OR l.titulo LIKE CONCAT('%', p_titulo, '%'))
      AND (p_autor IS NULL OR l.autor LIKE CONCAT('%', p_autor, '%'))
      AND (p_id_categoria IS NULL OR l.id_categoria = p_id_categoria)
      AND (p_estado IS NULL OR l.estado = p_estado)
    ORDER BY l.fecha_registro DESC
    LIMIT p_limit OFFSET p_offset;
END $$
DELIMITER ;

-- =========================================
-- MÓDULO LIBRO: sp_vincular_imagen_libro
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_vincular_imagen_libro(
    IN p_id_libro INT,
    IN p_url_imagen VARCHAR(500)
)
BEGIN
    INSERT INTO imagen_libro (id_libro, url_imagen)
    VALUES (p_id_libro, p_url_imagen);
END $$
DELIMITER ;

-- =========================================
-- MÓDULO SOLICITUD: sp_crear_solicitud
-- =========================================
DELIMITER //
CREATE PROCEDURE sp_crear_solicitud(
    IN p_id_solicitante INT,
    IN p_id_receptor INT,
    IN p_tipo ENUM('intercambio','prestamo')
)
BEGIN
    INSERT INTO solicitud (id_solicitante, id_receptor, tipo, estado)
    VALUES (p_id_solicitante, p_id_receptor, p_tipo, 'pendiente');
END //
DELIMITER ;
