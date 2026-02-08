-- =========================================
-- SP: Responder Solicitud de Intercambio
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_responder_solicitud(
    IN p_id_solicitud INT,
    IN p_nuevo_estado ENUM('ACEPTADA','RECHAZADA'),
    IN p_comentario TEXT
)
BEGIN
    DECLARE v_estado VARCHAR(20);
    DECLARE v_id_receptor INT;

    SET v_estado = CASE
        WHEN UPPER(p_nuevo_estado) = 'ACEPTADA' THEN 'aceptado'
        WHEN UPPER(p_nuevo_estado) = 'RECHAZADA' THEN 'rechazado'
        ELSE 'pendiente'
    END;

    UPDATE solicitud
    SET estado = v_estado
    WHERE id_solicitud = p_id_solicitud;

    IF v_estado = 'aceptado' THEN
        UPDATE libro l
        INNER JOIN detalle_solicitud ds ON ds.id_libro = l.id_libro
        SET l.disponible = FALSE
        WHERE ds.id_solicitud = p_id_solicitud
          AND ds.propietario = 'receptor';
    END IF;

    IF p_comentario IS NOT NULL AND p_comentario <> '' THEN
        SELECT id_receptor INTO v_id_receptor
        FROM solicitud
        WHERE id_solicitud = p_id_solicitud;

        INSERT INTO mensaje (id_solicitud, id_emisor, contenido)
        VALUES (p_id_solicitud, v_id_receptor, p_comentario);
    END IF;
END $$
DELIMITER ;
