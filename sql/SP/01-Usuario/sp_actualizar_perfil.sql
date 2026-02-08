-- =========================================
-- SP: Actualizar Perfil Usuario
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
