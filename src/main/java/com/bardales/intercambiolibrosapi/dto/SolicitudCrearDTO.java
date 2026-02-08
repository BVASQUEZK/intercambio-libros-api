package com.bardales.intercambiolibrosapi.dto;

import jakarta.validation.constraints.NotNull;

public class SolicitudCrearDTO {
    @NotNull
    private Integer idSolicitante;

    @NotNull
    private Integer idReceptor;

    @NotNull
    private Integer idLibro;

    @NotNull
    private String tipo;

    public SolicitudCrearDTO() {
    }

    public SolicitudCrearDTO(Integer idSolicitante, Integer idReceptor, Integer idLibro, String tipo) {
        this.idSolicitante = idSolicitante;
        this.idReceptor = idReceptor;
        this.idLibro = idLibro;
        this.tipo = tipo;
    }

    public Integer getIdSolicitante() {
        return idSolicitante;
    }

    public void setIdSolicitante(Integer idSolicitante) {
        this.idSolicitante = idSolicitante;
    }

    public Integer getIdReceptor() {
        return idReceptor;
    }

    public void setIdReceptor(Integer idReceptor) {
        this.idReceptor = idReceptor;
    }

    public Integer getIdLibro() {
        return idLibro;
    }

    public void setIdLibro(Integer idLibro) {
        this.idLibro = idLibro;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}