-- =========================================
-- SP: Enviar Mensaje
-- =========================================
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
