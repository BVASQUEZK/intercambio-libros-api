package com.bardales.intercambiolibrosapi.dto;

import java.time.LocalDateTime;

public class PerfilUsuarioDTO {
    private String nombres;
    private String apellidos;
    private String urlFotoPerfil;
    private LocalDateTime fechaRegistro;
    private Double promedioPuntuacion;

    public PerfilUsuarioDTO() {
    }

    public PerfilUsuarioDTO(String nombres, String apellidos, String urlFotoPerfil, LocalDateTime fechaRegistro,
            Double promedioPuntuacion) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.urlFotoPerfil = urlFotoPerfil;
        this.fechaRegistro = fechaRegistro;
        this.promedioPuntuacion = promedioPuntuacion;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getUrlFotoPerfil() {
        return urlFotoPerfil;
    }

    public void setUrlFotoPerfil(String urlFotoPerfil) {
        this.urlFotoPerfil = urlFotoPerfil;
    }

    public LocalDateTime getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(LocalDateTime fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public Double getPromedioPuntuacion() {
        return promedioPuntuacion;
    }

    public void setPromedioPuntuacion(Double promedioPuntuacion) {
        this.promedioPuntuacion = promedioPuntuacion;
    }
}