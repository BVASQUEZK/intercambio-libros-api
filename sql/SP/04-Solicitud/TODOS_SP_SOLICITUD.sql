-- =========================================
-- TODOS LOS SP DE SOLICITUD
-- =========================================

-- =========================================
-- SP: Crear Solicitud
-- =========================================
DROP PROCEDURE IF EXISTS sp_crear_solicitud;
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

-- =========================================
-- SP: Crear Solicitud de Intercambio
-- =========================================
DROP PROCEDURE IF EXISTS sp_crear_solicitud_intercambio;
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

-- =========================================
-- SP: Listar Solicitudes por Usuario
-- =========================================
DROP PROCEDURE IF EXISTS sp_listar_solicitudes_usuario;
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

-- =========================================
-- SP: Responder Solicitud de Intercambio
-- =========================================
DROP PROCEDURE IF EXISTS sp_responder_solicitud;
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

-- =========================================
-- SP: Actualizar Estado Solicitud
-- =========================================
DROP PROCEDURE IF EXISTS sp_actualizar_estado_solicitud;
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
