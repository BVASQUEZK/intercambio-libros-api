-- =========================================
-- 003 - ELIMINAR PROCEDIMIENTOS (USUARIO, CATEGORIA, LIBRO)
-- =========================================
DROP PROCEDURE IF EXISTS sp_login_usuario_app;
DROP PROCEDURE IF EXISTS sp_registrar_usuario_app;
DROP PROCEDURE IF EXISTS sp_actualizar_perfil;

DROP PROCEDURE IF EXISTS sp_listar_categorias;

DROP PROCEDURE IF EXISTS sp_registrar_libro;
DROP PROCEDURE IF EXISTS sp_listar_libros_recientes;
DROP PROCEDURE IF EXISTS sp_buscar_libros_filtros;
DROP PROCEDURE IF EXISTS sp_vincular_imagen_libro;
