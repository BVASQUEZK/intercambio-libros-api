package com.bardales.intercambiolibrosapi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IntercambioRepository {

    @Procedure(procedureName = "sp_crear_solicitud_intercambio", outputParameterName = "p_id_solicitud")
    Integer crearSolicitudIntercambio(
            @Param("p_id_usuario_solicitante") Integer idUsuarioSolicitante,
            @Param("p_id_libro_interesado") Integer idLibroInteresado,
            @Param("p_mensaje_propuesta") String mensajePropuesta);

    @Procedure(procedureName = "sp_responder_solicitud")
    void responderSolicitud(
            @Param("p_id_solicitud") Integer idSolicitud,
            @Param("p_nuevo_estado") String nuevoEstado,
            @Param("p_comentario") String comentario);

    @Query(value = "SELECT l.id_usuario FROM solicitud s " +
            "INNER JOIN detalle_solicitud ds ON ds.id_solicitud = s.id_solicitud AND ds.propietario = 'receptor' " +
            "INNER JOIN libro l ON l.id_libro = ds.id_libro " +
            "WHERE s.id_solicitud = :idSolicitud", nativeQuery = true)
    Integer obtenerIdDuenoLibro(@Param("idSolicitud") Integer idSolicitud);

    @Procedure(procedureName = "sp_listar_solicitudes_usuario")
    List<IntercambioSolicitudProjection> listarSolicitudes(
            @Param("p_id_usuario") Integer idUsuario,
            @Param("p_tipo") String tipo);

    @Procedure(procedureName = "sp_obtener_mensajes_intercambio")
    List<IntercambioMensajeProjection> listarMensajesIntercambio(
            @Param("p_id_solicitud") Integer idSolicitud,
            @Param("p_id_usuario") Integer idUsuario);

    @Query(value = "SELECT COUNT(1) FROM solicitud s " +
            "WHERE s.id_solicitud = :idSolicitud " +
            "AND (s.id_solicitante = :idUsuario OR s.id_receptor = :idUsuario)", nativeQuery = true)
    Integer existeUsuarioEnSolicitud(@Param("idSolicitud") Integer idSolicitud, @Param("idUsuario") Integer idUsuario);
}