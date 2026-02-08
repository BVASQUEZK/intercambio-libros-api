-- =========================================
-- SP: Crear Solicitud de Intercambio
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_crear_solicitud_intercambio(
    IN p_id_usuario_solicitante INT,
    IN p_id_libro_interesado INT,
    IN p_mensaje_propuesta TEXT,
    OUT p_id_solicitud INT
)
BEGIN
    DECLARE v_id_receptor INT;

    SELECT id_usuario INTO v_id_receptor
    FROM libro
    WHERE id_libro = p_id_libro_interesado;

    INSERT INTO solicitud (id_solicitante, id_receptor, tipo, estado)
    VALUES (p_id_usuario_solicitante, v_id_receptor, 'intercambio', 'pendiente');

    SET p_id_solicitud = LAST_INSERT_ID();

    INSERT INTO detalle_solicitud (id_solicitud, id_libro, propietario)
    VALUES (p_id_solicitud, p_id_libro_interesado, 'receptor');

    IF p_mensaje_propuesta IS NOT NULL AND p_mensaje_propuesta <> '' THEN
        INSERT INTO mensaje (id_solicitud, id_emisor, contenido)
        VALUES (p_id_solicitud, p_id_usuario_solicitante, p_mensaje_propuesta);
    END IF;
END $$
DELIMITER ;
