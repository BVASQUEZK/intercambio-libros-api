package com.bardales.intercambiolibrosapi.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bardales.intercambiolibrosapi.dto.IntercambioMensajeDTO;
import com.bardales.intercambiolibrosapi.dto.IntercambioRespuestaDTO;
import com.bardales.intercambiolibrosapi.dto.IntercambioSolicitudDTO;
import com.bardales.intercambiolibrosapi.dto.IntercambioSolicitudResumenDTO;
import com.bardales.intercambiolibrosapi.service.IntercambioService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/intercambios")
@CrossOrigin(origins = "*")
public class IntercambioController {

    private final IntercambioService intercambioService;

    public IntercambioController(IntercambioService intercambioService) {
        this.intercambioService = intercambioService;
    }

    @PostMapping("/solicitar")
    public ResponseEntity<Map<String, Object>> solicitar(
            @RequestHeader("X-User-Id") int idUsuario,
            @Valid @RequestBody IntercambioSolicitudDTO dto) {
        Integer idSolicitud = intercambioService.enviarSolicitud(idUsuario, dto);
        return ResponseEntity.status(201)
                .body(Map.of("mensaje", "Solicitud enviada", "id_solicitud", idSolicitud));
    }

    @PutMapping("/responder/{id}")
    public ResponseEntity<Map<String, Object>> responder(
            @RequestHeader("X-User-Id") int idUsuario,
            @PathVariable("id") int idSolicitud,
            @Valid @RequestBody IntercambioRespuestaDTO dto) {
        intercambioService.responderSolicitud(idUsuario, idSolicitud, dto);
        return ResponseEntity.ok(
                Map.of("mensaje", "Solicitud " + dto.getNuevoEstado().toLowerCase(), "id_solicitud", idSolicitud));
    }

    @GetMapping("/mis-solicitudes")
    public List<IntercambioSolicitudResumenDTO> listarMisSolicitudes(
            @RequestHeader("X-User-Id") int idUsuario,
            @RequestParam("tipo") String tipo) {
        return intercambioService.listarSolicitudes(idUsuario, tipo);
    }

    @GetMapping("/{id}/mensajes")
    public List<IntercambioMensajeDTO> obtenerMensajes(
            @RequestHeader("X-User-Id") int idUsuario,
            @PathVariable("id") int idSolicitud) {
        return intercambioService.obtenerHistorial(idUsuario, idSolicitud);
    }
}