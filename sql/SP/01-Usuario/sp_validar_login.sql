-- =========================================
-- SP: Login Usuario App
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_login_usuario_app(
    IN p_correo VARCHAR(120),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT id_usuario,
           nombres,
           apellidos,
           correo
    FROM usuario
    WHERE correo = p_correo
      AND password = p_password;
END $$
DELIMITER ;
