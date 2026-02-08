package com.bardales.intercambiolibrosapi.service;

import java.util.List;

import com.bardales.intercambiolibrosapi.dto.IntercambioMensajeDTO;
import com.bardales.intercambiolibrosapi.dto.IntercambioRespuestaDTO;
import com.bardales.intercambiolibrosapi.dto.IntercambioSolicitudDTO;
import com.bardales.intercambiolibrosapi.dto.IntercambioSolicitudResumenDTO;

public interface IntercambioService {
    Integer enviarSolicitud(int idUsuarioSolicitante, IntercambioSolicitudDTO dto);
    void responderSolicitud(int idUsuario, int idSolicitud, IntercambioRespuestaDTO dto);
    List<IntercambioSolicitudResumenDTO> listarSolicitudes(int idUsuario, String tipo);
    List<IntercambioMensajeDTO> obtenerHistorial(int idUsuario, int idSolicitud);
}