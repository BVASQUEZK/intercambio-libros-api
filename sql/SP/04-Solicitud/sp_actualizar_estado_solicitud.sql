-- =========================================
-- SP: Actualizar Estado Solicitud
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_actualizar_estado_solicitud(
    IN id_solicitud INT,
    IN estado ENUM('pendiente','aceptado','rechazado','finalizado','cancelado')
)
BEGIN
    UPDATE solicitud s
    SET s.estado = estado
    WHERE s.id_solicitud = id_solicitud;
END $$
DELIMITER ;
