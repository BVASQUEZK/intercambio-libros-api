-- =========================================
-- SP: Registrar Libro + Imagen Principal
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
