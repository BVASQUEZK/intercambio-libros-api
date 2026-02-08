package com.bardales.intercambiolibrosapi.dto;

import jakarta.validation.constraints.NotBlank;

public class IntercambioRespuestaDTO {
    @NotBlank
    private String nuevoEstado;

    private String comentario;

    public IntercambioRespuestaDTO() {
    }

    public IntercambioRespuestaDTO(String nuevoEstado, String comentario) {
        this.nuevoEstado = nuevoEstado;
        this.comentario = comentario;
    }

    public String getNuevoEstado() {
        return nuevoEstado;
    }

    public void setNuevoEstado(String nuevoEstado) {
        this.nuevoEstado = nuevoEstado;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }
}