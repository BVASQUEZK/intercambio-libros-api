-- =========================================
-- SP: Listar Libros Recientes (Inicio)
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
