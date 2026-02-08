-- =========================================
-- SP: Listar Mensajes por Solicitud
-- =========================================
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
