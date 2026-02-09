-- =========================================
-- TODOS LOS SP DE MENSAJE
-- =========================================

-- =========================================
-- SP: Enviar Mensaje
-- =========================================
DROP PROCEDURE IF EXISTS sp_enviar_mensaje;
DELIMITER $$
CREATE PROCEDURE sp_enviar_mensaje(
    IN id_solicitud INT,
    IN id_emisor INT,
    IN contenido TEXT
)
BEGIN
    INSERT INTO mensaje (id_solicitud, id_emisor, contenido)
    VALUES (id_solicitud, id_emisor, contenido);
END $$
DELIMITER ;

-- =========================================
-- SP: Listar Mensajes por Solicitud
-- =========================================
DROP PROCEDURE IF EXISTS sp_listar_mensajes_solicitud;
DELIMITER $$
CREATE PROCEDURE sp_listar_mensajes_solicitud(
    IN id_solicitud INT
)
BEGIN
    SELECT m.id_mensaje, m.id_solicitud, m.id_emisor, m.contenido, m.fecha_envio, m.leido,
           u.nombres, u.apellidos, u.url_foto_perfil
    FROM mensaje m
    INNER JOIN usuario u ON u.id_usuario = m.id_emisor
    WHERE m.id_solicitud = id_solicitud
    ORDER BY m.fecha_envio ASC;
END $$
DELIMITER ;

-- =========================================
-- SP: Obtener Mensajes de Intercambio
-- =========================================
DROP PROCEDURE IF EXISTS sp_obtener_mensajes_intercambio;
DELIMITER $$
CREATE PROCEDURE sp_obtener_mensajes_intercambio(
    IN p_id_solicitud INT,
    IN p_id_usuario INT
)
BEGIN
    SELECT CONCAT(u.nombres, ' ', u.apellidos) AS emisor_nombre,
           m.contenido AS contenido_mensaje,
           m.fecha_envio AS fecha_envio,
           (m.id_emisor = p_id_usuario) AS es_mio
    FROM mensaje m
    INNER JOIN usuario u ON u.id_usuario = m.id_emisor
    WHERE m.id_solicitud = p_id_solicitud
    ORDER BY m.fecha_envio ASC;
END $$
DELIMITER ;
