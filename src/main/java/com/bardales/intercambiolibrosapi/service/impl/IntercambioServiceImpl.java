package com.bardales.intercambiolibrosapi.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bardales.intercambiolibrosapi.dto.IntercambioMensajeDTO;
import com.bardales.intercambiolibrosapi.dto.IntercambioRespuestaDTO;
import com.bardales.intercambiolibrosapi.dto.IntercambioSolicitudDTO;
import com.bardales.intercambiolibrosapi.dto.IntercambioSolicitudResumenDTO;
import com.bardales.intercambiolibrosapi.entity.Libro;
import com.bardales.intercambiolibrosapi.exception.ResourceNotFoundException;
import com.bardales.intercambiolibrosapi.exception.UnauthorizedException;
import com.bardales.intercambiolibrosapi.repository.IntercambioJpaRepository;
import com.bardales.intercambiolibrosapi.repository.IntercambioMensajeProjection;
import com.bardales.intercambiolibrosapi.repository.IntercambioSolicitudProjection;
import com.bardales.intercambiolibrosapi.repository.LibroRepository;
import com.bardales.intercambiolibrosapi.service.IntercambioService;

@Service
public class IntercambioServiceImpl implements IntercambioService {

    private final IntercambioJpaRepository intercambioRepository;
    private final LibroRepository libroRepository;

    public IntercambioServiceImpl(IntercambioJpaRepository intercambioRepository, LibroRepository libroRepository) {
        this.intercambioRepository = intercambioRepository;
        this.libroRepository = libroRepository;
    }

    @Override
    @Transactional
    public Integer enviarSolicitud(int idUsuarioSolicitante, IntercambioSolicitudDTO dto) {
        Libro libro = libroRepository.findById(dto.getIdLibroInteresado())
                .orElseThrow(() -> new ResourceNotFoundException("Libro no encontrado"));

        if (libro.getIdUsuario() != null && libro.getIdUsuario().equals(idUsuarioSolicitante)) {
            throw new UnauthorizedException("No puedes solicitar tu propio libro");
        }

        if (libro.getDisponible() != null && !libro.getDisponible()) {
            throw new UnauthorizedException("El libro no está disponible");
        }

        Integer idSolicitud = intercambioRepository.crearSolicitudIntercambio(
                idUsuarioSolicitante,
                dto.getIdLibroInteresado(),
                dto.getMensajePropuesta());

        if (idSolicitud == null || idSolicitud <= 0) {
            throw new RuntimeException("No se pudo crear la solicitud de intercambio");
        }

        return idSolicitud;
    }

    @Override
    @Transactional
    public void responderSolicitud(int idUsuario, int idSolicitud, IntercambioRespuestaDTO dto) {
        Integer idDueno = intercambioRepository.obtenerIdDuenoLibro(idSolicitud);
        if (idDueno == null) {
            throw new ResourceNotFoundException("Solicitud no encontrada");
        }
        if (!idDueno.equals(idUsuario)) {
            throw new UnauthorizedException("No autorizado para responder esta solicitud");
        }

        String estado = dto.getNuevoEstado() == null ? "" : dto.getNuevoEstado().trim().toUpperCase();
        if (!"ACEPTADA".equals(estado) && !"RECHAZADA".equals(estado)) {
            throw new UnauthorizedException("Estado inválido");
        }

        intercambioRepository.responderSolicitud(idSolicitud, estado, dto.getComentario());
    }

    @Override
    public List<IntercambioSolicitudResumenDTO> listarSolicitudes(int idUsuario, String tipo) {
        String tipoNormalizado = tipo == null ? "" : tipo.trim().toUpperCase();
        if (!"RECIBIDAS".equals(tipoNormalizado) && !"ENVIADAS".equals(tipoNormalizado)) {
            throw new UnauthorizedException("Tipo inválido");
        }

        return intercambioRepository.listarSolicitudes(idUsuario, tipoNormalizado)
                .stream()
                .map(this::toResumenDto)
                .collect(Collectors.toList());
    }

    @Override
    public List<IntercambioMensajeDTO> obtenerHistorial(int idUsuario, int idSolicitud) {
        Integer existe = intercambioRepository.existeUsuarioEnSolicitud(idSolicitud, idUsuario);
        if (existe == null || existe == 0) {
            throw new UnauthorizedException("No autorizado para ver este intercambio");
        }

        return intercambioRepository.listarMensajesIntercambio(idSolicitud, idUsuario)
                .stream()
                .map(this::toMensajeDto)
                .collect(Collectors.toList());
    }

    private IntercambioSolicitudResumenDTO toResumenDto(IntercambioSolicitudProjection p) {
        return new IntercambioSolicitudResumenDTO(
                p.getId_solicitud(),
                p.getTitulo_libro(),
                p.getNombre_otra_parte(),
                p.getEstado(),
                p.getFecha_solicitud()
        );
    }

    private IntercambioMensajeDTO toMensajeDto(IntercambioMensajeProjection p) {
        boolean esMio = p.getEs_mio() != null && p.getEs_mio();
        return new IntercambioMensajeDTO(
                p.getEmisor_nombre(),
                p.getContenido_mensaje(),
                p.getFecha_envio(),
                esMio
        );
    }
}