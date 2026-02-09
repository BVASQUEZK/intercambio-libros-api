-- =========================================
-- SP: Registrar Usuario App
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
