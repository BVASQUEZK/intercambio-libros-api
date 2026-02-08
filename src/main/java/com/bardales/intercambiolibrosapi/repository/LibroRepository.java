package com.bardales.intercambiolibrosapi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.bardales.intercambiolibrosapi.entity.Libro;

public interface LibroRepository extends JpaRepository<Libro, Integer> {

    @Query(value = "CALL sp_listar_libros_recientes(:limit, :offset)", nativeQuery = true)
    List<LibroHomeProjection> listarRecientes(@Param("limit") int limit, @Param("offset") int offset);

    @Procedure(procedureName = "sp_buscar_libros_filtros")
    List<LibroHomeProjection> buscarLibros(
            @Param("p_titulo") String titulo,
            @Param("p_autor") String autor,
            @Param("p_id_categoria") Integer idCategoria,
            @Param("p_estado") String estado,
            @Param("p_limit") int limit,
            @Param("p_offset") int offset);

    @Procedure(procedureName = "sp_registrar_libro", outputParameterName = "p_id_libro")
    Integer registrarLibro(
            @Param("p_id_usuario") Integer idUsuario,
            @Param("p_id_categoria") Integer idCategoria,
            @Param("p_titulo") String titulo,
            @Param("p_autor") String autor,
            @Param("p_descripcion") String descripcion,
            @Param("p_estado") String estado,
            @Param("p_url_imagen") String urlImagen);

    @Query(value = "CALL sp_vincular_imagen_libro(:idLibro, :urlImagen)", nativeQuery = true)
    void vincularImagen(@Param("idLibro") Integer idLibro, @Param("urlImagen") String urlImagen);
}
