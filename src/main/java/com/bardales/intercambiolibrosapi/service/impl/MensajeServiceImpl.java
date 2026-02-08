package com.bardales.intercambiolibrosapi.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bardales.intercambiolibrosapi.dto.MensajeDTO;
import com.bardales.intercambiolibrosapi.dto.MensajeEnviarDTO;
import com.bardales.intercambiolibrosapi.repository.MensajeProjection;
import com.bardales.intercambiolibrosapi.repository.MensajeRepository;
import com.bardales.intercambiolibrosapi.service.MensajeService;

@Service
public class MensajeServiceImpl implements MensajeService {

    private final MensajeRepository mensajeRepository;

    public MensajeServiceImpl(MensajeRepository mensajeRepository) {
        this.mensajeRepository = mensajeRepository;
    }

    @Override
    public List<MensajeDTO> listarMensajes(int idSolicitud, int idUsuario) {
        return mensajeRepository.listarMensajes(idSolicitud)
                .stream()
                .map(p -> toDto(p, idUsuario))
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void enviarMensaje(MensajeEnviarDTO dto) {
        mensajeRepository.enviarMensaje(dto.getIdSolicitud(), dto.getIdEmisor(), dto.getContenido());
    }

    private MensajeDTO toDto(MensajeProjection p, int idUsuario) {
        boolean esMio = p.getId_emisor() != null && p.getId_emisor() == idUsuario;
        return new MensajeDTO(
                p.getId_mensaje(),
                p.getId_emisor(),
                p.getContenido(),
                p.getFecha_envio(),
                esMio);
    }
}