-- =========================================
-- SP: Listar Categorias
-- =========================================
DELIMITER //
CREATE PROCEDURE sp_listar_categorias()
BEGIN
    SELECT c.id_categoria AS id_categoria,
           c.nombre AS nombre
    FROM categoria c
    ORDER BY c.nombre ASC;
END //
DELIMITER ;
