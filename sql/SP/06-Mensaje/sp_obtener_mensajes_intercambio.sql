-- =========================================
-- SP: Obtener Mensajes de Intercambio
-- =========================================
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
