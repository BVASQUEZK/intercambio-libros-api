package com.bardales.intercambiolibrosapi.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class MensajeEnviarDTO {
    @NotNull
    private Integer idSolicitud;

    @NotNull
    private Integer idEmisor;

    @NotBlank
    private String contenido;

    public MensajeEnviarDTO() {
    }

    public MensajeEnviarDTO(Integer idSolicitud, Integer idEmisor, String contenido) {
        this.idSolicitud = idSolicitud;
        this.idEmisor = idEmisor;
        this.contenido = contenido;
    }

    public Integer getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(Integer idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public Integer getIdEmisor() {
        return idEmisor;
    }

    public void setIdEmisor(Integer idEmisor) {
        this.idEmisor = idEmisor;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }
}