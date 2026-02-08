package com.bardales.intercambiolibrosapi.dto;

import jakarta.validation.constraints.NotNull;

public class IntercambioSolicitudDTO {
    @NotNull
    private Integer idLibroInteresado;

    private String mensajePropuesta;

    public IntercambioSolicitudDTO() {
    }

    public IntercambioSolicitudDTO(Integer idLibroInteresado, String mensajePropuesta) {
        this.idLibroInteresado = idLibroInteresado;
        this.mensajePropuesta = mensajePropuesta;
    }

    public Integer getIdLibroInteresado() {
        return idLibroInteresado;
    }

    public void setIdLibroInteresado(Integer idLibroInteresado) {
        this.idLibroInteresado = idLibroInteresado;
    }

    public String getMensajePropuesta() {
        return mensajePropuesta;
    }

    public void setMensajePropuesta(String mensajePropuesta) {
        this.mensajePropuesta = mensajePropuesta;
    }
}