-- =========================================
-- SP: Registrar Usuario
-- =========================================
DELIMITER $$
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
END $$
DELIMITER ;
