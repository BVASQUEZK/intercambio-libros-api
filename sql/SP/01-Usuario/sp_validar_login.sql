-- =========================================
-- SP: Validar Login
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_validar_login(
    IN p_correo VARCHAR(120),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT nombres, apellidos, url_foto_perfil AS url_foto
    FROM usuario
    WHERE correo = p_correo AND password = p_password;
END $$
DELIMITER ;
