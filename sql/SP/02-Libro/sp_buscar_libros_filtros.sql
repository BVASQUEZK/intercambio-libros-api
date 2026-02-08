-- =========================================
-- SP: Buscar Libros con Filtros (Búsqueda)
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
