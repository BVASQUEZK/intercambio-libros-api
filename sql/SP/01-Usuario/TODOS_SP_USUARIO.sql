-- =========================================
-- TODOS LOS SP DE USUARIO
-- =========================================

-- =========================================
-- SP: Login Usuario App
-- =========================================
DROP PROCEDURE IF EXISTS sp_login_usuario_app;
DELIMITER $$
CREATE PROCEDURE sp_login_usuario_app(
    IN p_correo VARCHAR(120),
    IN p_password VARCHAR(255)
)
BEGIN
    -- IMPORTANT: DO NOT CHANGE THE COLUMN ORDER BELOW.
    -- IMPORTANT: DO NOT CHANGE THE COLUMN ORDER BELOW.
    -- IMPORTANT: DO NOT CHANGE THE COLUMN ORDER BELOW.
    SELECT id_usuario AS idUsuario,
           nombres,
           apellidos,
           correo,
           password,
           estado
    FROM usuario
    WHERE correo = p_correo
      AND password = p_password;
END $$
DELIMITER ;

-- =========================================
-- SP: Registrar Usuario App
-- =========================================
DROP PROCEDURE IF EXISTS sp_registrar_usuario_app;
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

-- =========================================
-- SP: Actualizar Perfil Usuario
-- =========================================
DROP PROCEDURE IF EXISTS sp_actualizar_perfil;
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
