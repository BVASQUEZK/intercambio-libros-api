package com.bardales.intercambiolibrosapi.dto;

import java.time.LocalDateTime;

public class ErrorResponseDTO {
    private LocalDateTime timestamp;
    private String mensaje;
    private String codigoError;

    public ErrorResponseDTO() {
    }

    public ErrorResponseDTO(LocalDateTime timestamp, String mensaje, String codigoError) {
        this.timestamp = timestamp;
        this.mensaje = mensaje;
        this.codigoError = codigoError;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getCodigoError() {
        return codigoError;
    }

    public void setCodigoError(String codigoError) {
        this.codigoError = codigoError;
    }
}