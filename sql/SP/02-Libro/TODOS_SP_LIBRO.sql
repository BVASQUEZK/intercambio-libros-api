-- =========================================
-- TODOS LOS SP DE LIBRO
-- =========================================

-- =========================================
-- SP: Registrar Libro + Imagen Principal
-- =========================================
DROP PROCEDURE IF EXISTS sp_registrar_libro;
DELIMITER $$
CREATE PROCEDURE sp_registrar_libro(
    IN p_id_usuario INT,
    IN p_id_categoria INT,
    IN p_titulo VARCHAR(150),
    IN p_autor VARCHAR(150),
    IN p_descripcion TEXT,
    IN p_estado ENUM('nuevo','muy bueno','bueno','aceptable'),
    IN p_ubicacion VARCHAR(255),
    IN p_url_imagen VARCHAR(500),
    OUT p_id_libro INT
)
BEGIN
    INSERT INTO libro (id_usuario, id_categoria, titulo, autor, descripcion, estado, ubicacion)
    VALUES (p_id_usuario, p_id_categoria, p_titulo, p_autor, p_descripcion, p_estado, p_ubicacion);

    SET p_id_libro = LAST_INSERT_ID();

    INSERT INTO imagen_libro (id_libro, url_imagen)
    VALUES (p_id_libro, p_url_imagen);
END $$
DELIMITER ;

-- =========================================
-- SP: Listar Libros Recientes (Inicio)
-- =========================================
DROP PROCEDURE IF EXISTS sp_listar_libros_recientes;
DELIMITER $$
CREATE PROCEDURE sp_listar_libros_recientes(
    IN p_limit INT,
    IN p_offset INT
)
BEGIN
    SELECT l.id_libro AS id_libro,
           l.titulo AS titulo,
           l.autor AS autor,
           l.descripcion AS descripcion,
           c.nombre AS nombre_categoria,
           CONCAT(u.nombres, ' ', u.apellidos) AS nombre_usuario_propietario,
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
    ORDER BY l.fecha_registro DESC
    LIMIT p_limit OFFSET p_offset;
END $$
DELIMITER ;

-- =========================================
-- SP: Buscar Libros con Filtros (Búsqueda)
-- =========================================
DROP PROCEDURE IF EXISTS sp_buscar_libros_filtros;
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
           l.descripcion AS descripcion,
           c.nombre AS nombre_categoria,
           CONCAT(u.nombres, ' ', u.apellidos) AS nombre_usuario_propietario,
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
    WHERE (p_titulo IS NULL OR l.titulo LIKE CONCAT('%', p_titulo, '%'))
      AND (p_autor IS NULL OR l.autor LIKE CONCAT('%', p_autor, '%'))
      AND (p_id_categoria IS NULL OR l.id_categoria = p_id_categoria)
      AND (p_estado IS NULL OR l.estado = p_estado)
    ORDER BY l.fecha_registro DESC
    LIMIT p_limit OFFSET p_offset;
END $$
DELIMITER ;

-- =========================================
-- SP: Vincular Imagen a Libro
-- =========================================
DROP PROCEDURE IF EXISTS sp_vincular_imagen_libro;
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

