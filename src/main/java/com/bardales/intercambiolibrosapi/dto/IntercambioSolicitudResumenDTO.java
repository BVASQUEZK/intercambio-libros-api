package com.bardales.intercambiolibrosapi.dto;

import java.time.LocalDateTime;

public class IntercambioSolicitudResumenDTO {
    private Integer idSolicitud;
    private String tituloLibro;
    private String nombreOtraParte;
    private String estado;
    private LocalDateTime fechaSolicitud;

    public IntercambioSolicitudResumenDTO() {
    }

    public IntercambioSolicitudResumenDTO(Integer idSolicitud, String tituloLibro, String nombreOtraParte, String estado,
            LocalDateTime fechaSolicitud) {
        this.idSolicitud = idSolicitud;
        this.tituloLibro = tituloLibro;
        this.nombreOtraParte = nombreOtraParte;
        this.estado = estado;
        this.fechaSolicitud = fechaSolicitud;
    }

    public Integer getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(Integer idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public String getTituloLibro() {
        return tituloLibro;
    }

    public void setTituloLibro(String tituloLibro) {
        this.tituloLibro = tituloLibro;
    }

    public String getNombreOtraParte() {
        return nombreOtraParte;
    }

    public void setNombreOtraParte(String nombreOtraParte) {
        this.nombreOtraParte = nombreOtraParte;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public LocalDateTime getFechaSolicitud() {
        return fechaSolicitud;
    }

    public void setFechaSolicitud(LocalDateTime fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }
}