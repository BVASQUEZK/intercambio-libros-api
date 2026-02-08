package com.bardales.intercambiolibrosapi.dto;

import java.time.LocalDateTime;

public class IntercambioMensajeDTO {
    private String emisorNombre;
    private String contenidoMensaje;
    private LocalDateTime fechaEnvio;
    private boolean esMio;

    public IntercambioMensajeDTO() {
    }

    public IntercambioMensajeDTO(String emisorNombre, String contenidoMensaje, LocalDateTime fechaEnvio, boolean esMio) {
        this.emisorNombre = emisorNombre;
        this.contenidoMensaje = contenidoMensaje;
        this.fechaEnvio = fechaEnvio;
        this.esMio = esMio;
    }

    public String getEmisorNombre() {
        return emisorNombre;
    }

    public void setEmisorNombre(String emisorNombre) {
        this.emisorNombre = emisorNombre;
    }

    public String getContenidoMensaje() {
        return contenidoMensaje;
    }

    public void setContenidoMensaje(String contenidoMensaje) {
        this.contenidoMensaje = contenidoMensaje;
    }

    public LocalDateTime getFechaEnvio() {
        return fechaEnvio;
    }

    public void setFechaEnvio(LocalDateTime fechaEnvio) {
        this.fechaEnvio = fechaEnvio;
    }

    public boolean isEsMio() {
        return esMio;
    }

    public void setEsMio(boolean esMio) {
        this.esMio = esMio;
    }
}