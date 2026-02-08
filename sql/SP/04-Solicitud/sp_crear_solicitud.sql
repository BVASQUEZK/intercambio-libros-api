-- =========================================
-- SP: Crear Solicitud
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_crear_solicitud(
    IN id_solicitante INT,
    IN id_receptor INT,
    IN tipo ENUM('intercambio','prestamo')
)
BEGIN
    INSERT INTO solicitud (id_solicitante, id_receptor, tipo)
    VALUES (id_solicitante, id_receptor, tipo);

    SELECT LAST_INSERT_ID() AS id_solicitud;
END $$
DELIMITER ;
