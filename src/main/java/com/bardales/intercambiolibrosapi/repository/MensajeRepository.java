package com.bardales.intercambiolibrosapi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.bardales.intercambiolibrosapi.entity.Mensaje;

public interface MensajeRepository extends JpaRepository<Mensaje, Integer> {

    @Query(value = "CALL sp_listar_mensajes_solicitud(:idSolicitud)", nativeQuery = true)
    List<MensajeProjection> listarMensajes(@Param("idSolicitud") Integer idSolicitud);

    @Query(value = "CALL sp_enviar_mensaje(:idSolicitud, :idEmisor, :contenido)", nativeQuery = true)
    void enviarMensaje(@Param("idSolicitud") Integer idSolicitud,
            @Param("idEmisor") Integer idEmisor,
            @Param("contenido") String contenido);
}
