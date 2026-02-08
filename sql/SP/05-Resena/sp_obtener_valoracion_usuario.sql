-- =========================================
-- SP: Obtener Valoracion de Usuario
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_obtener_valoracion_usuario(
    IN id_usuario INT
)
BEGIN
    SELECT AVG(r.puntuacion) AS promedio_estrellas
    FROM resena r
    WHERE r.id_evaluado = id_usuario;
END $$
DELIMITER ;
