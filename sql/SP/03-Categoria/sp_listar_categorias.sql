-- =========================================
-- SP: Listar Categorias
-- =========================================
DELIMITER $$
CREATE PROCEDURE sp_listar_categorias()
BEGIN
    SELECT id_categoria, nombre
    FROM categoria
    ORDER BY nombre ASC;
END $$
DELIMITER ;
