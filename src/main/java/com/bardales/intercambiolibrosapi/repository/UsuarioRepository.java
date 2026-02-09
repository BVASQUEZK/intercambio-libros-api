package com.bardales.intercambiolibrosapi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.bardales.intercambiolibrosapi.entity.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    @Query(value = "CALL sp_login_usuario_app(:correo, :password)", nativeQuery = true)
    List<LoginUsuarioAppProjection> loginUsuarioApp(@Param("correo") String correo, @Param("password") String password);

    @Query(value = "CALL sp_obtener_valoracion_usuario(:idUsuario)", nativeQuery = true)
    Double obtenerValoracion(@Param("idUsuario") Integer idUsuario);

    @Procedure(procedureName = "sp_actualizar_perfil")
    void actualizarPerfil(
            @Param("p_id_usuario") Integer idUsuario,
            @Param("p_nombres") String nombres,
            @Param("p_apellidos") String apellidos,
            @Param("p_url_foto") String urlFoto);
}
