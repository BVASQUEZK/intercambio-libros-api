-- =========================================
-- SP: Listar Solicitudes por Usuario
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_listar_solicitudes_usuario(
    IN p_id_usuario INT,
    IN p_tipo ENUM('RECIBIDAS','ENVIADAS')
)
BEGIN
    SELECT s.id_solicitud AS id_solicitud,
           l.titulo AS titulo_libro,
           CASE
               WHEN p_tipo = 'RECIBIDAS' THEN CONCAT(us.nombres, ' ', us.apellidos)
               ELSE CONCAT(ur.nombres, ' ', ur.apellidos)
           END AS nombre_otra_parte,
           s.estado AS estado,
           s.fecha_solicitud AS fecha_solicitud
    FROM solicitud s
    INNER JOIN detalle_solicitud ds ON ds.id_solicitud = s.id_solicitud AND ds.propietario = 'receptor'
    INNER JOIN libro l ON l.id_libro = ds.id_libro
    INNER JOIN usuario us ON us.id_usuario = s.id_solicitante
    INNER JOIN usuario ur ON ur.id_usuario = s.id_receptor
    WHERE (p_tipo = 'RECIBIDAS' AND s.id_receptor = p_id_usuario)
       OR (p_tipo = 'ENVIADAS' AND s.id_solicitante = p_id_usuario)
    ORDER BY s.fecha_solicitud DESC;
END $$
DELIMITER ;
