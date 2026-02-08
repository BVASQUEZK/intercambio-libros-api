-- =========================================
-- SP COMPLETOS - intercambiolibrosapi
-- =========================================
USE intercambio_libros;

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
-- MÓDULO USUARIO: sp_login_usuario
-- =========================================
DELIMITER //
CREATE PROCEDURE sp_login_usuario(
    IN p_email VARCHAR(120),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT id_usuario,
           nombres,
           apellidos,
           correo,
           telefono,
           url_foto_perfil,
           fecha_registro,
           estado
    FROM usuario
    WHERE correo = p_email
      AND password = p_password
      AND estado = 'activo';
END //
DELIMITER ;

-- =========================================
-- MÓDULO USUARIO: sp_registrar_usuario
-- =========================================
DELIMITER //
CREATE PROCEDURE sp_registrar_usuario(
    IN p_nombres VARCHAR(100),
    IN p_apellidos VARCHAR(100),
    IN p_dni VARCHAR(15),
    IN p_correo VARCHAR(120),
    IN p_telefono VARCHAR(20),
    IN p_password VARCHAR(255),
    IN p_url_foto_perfil VARCHAR(500)
)
BEGIN
    INSERT INTO usuario (nombres, apellidos, dni, correo, telefono, password, url_foto_perfil)
    VALUES (p_nombres, p_apellidos, p_dni, p_correo, p_telefono, p_password, p_url_foto_perfil);
END //
DELIMITER ;

-- =========================================
-- MÓDULO LIBRO: sp_listar_libros_recientes
-- =========================================
DELIMITER //
CREATE PROCEDURE sp_listar_libros_recientes(
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT l.id_libro,
           l.titulo,
           l.autor,
           l.descripcion,
           l.estado,
           l.disponible,
           l.fecha_registro,
           c.id_categoria,
           c.nombre AS categoria,
           u.id_usuario,
           u.nombres,
           u.apellidos,
           u.url_foto_perfil,
           img.url_imagen AS url_portada
    FROM libro l
    INNER JOIN usuario u ON u.id_usuario = l.id_usuario
    LEFT JOIN categoria c ON c.id_categoria = l.id_categoria
    LEFT JOIN (
        SELECT i.id_libro, MIN(i.id_imagen) AS id_imagen
        FROM imagen_libro i
        GROUP BY i.id_libro
    ) img_min ON img_min.id_libro = l.id_libro
    LEFT JOIN imagen_libro img ON img.id_imagen = img_min.id_imagen
    WHERE l.disponible = TRUE
    ORDER BY l.fecha_registro DESC
    LIMIT p_limit OFFSET p_offset;
END //
DELIMITER ;

-- =========================================
-- MÓDULO LIBRO: sp_buscar_libros
-- =========================================
DELIMITER //
CREATE PROCEDURE sp_buscar_libros(
    IN p_query VARCHAR(150),
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT l.id_libro,
           l.titulo,
           l.autor,
           l.descripcion,
           l.estado,
           l.disponible,
           l.fecha_registro,
           c.id_categoria,
           c.nombre AS categoria,
           u.id_usuario,
           u.nombres,
           u.apellidos,
           u.url_foto_perfil,
           img.url_imagen AS url_portada
    FROM libro l
    INNER JOIN usuario u ON u.id_usuario = l.id_usuario
    LEFT JOIN categoria c ON c.id_categoria = l.id_categoria
    LEFT JOIN (
        SELECT i.id_libro, MIN(i.id_imagen) AS id_imagen
        FROM imagen_libro i
        GROUP BY i.id_libro
    ) img_min ON img_min.id_libro = l.id_libro
    LEFT JOIN imagen_libro img ON img.id_imagen = img_min.id_imagen
    WHERE l.disponible = TRUE
      AND (p_query IS NULL OR l.titulo LIKE CONCAT('%', p_query, '%') OR l.autor LIKE CONCAT('%', p_query, '%'))
    ORDER BY l.fecha_registro DESC
    LIMIT p_limit OFFSET p_offset;
END //
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
