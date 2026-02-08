-- =========================================
-- SP: Vincular Imagen a Libro
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
