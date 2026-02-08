package com.bardales.intercambiolibrosapi.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class UsuarioUpdateDTO {
    @NotNull
    private Integer idUsuario;

    @NotBlank
    private String nombres;

    @NotBlank
    private String apellidos;

    private String urlFoto;

    public UsuarioUpdateDTO() {
    }

    public UsuarioUpdateDTO(Integer idUsuario, String nombres, String apellidos, String urlFoto) {
        this.idUsuario = idUsuario;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.urlFoto = urlFoto;
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
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

    public String getUrlFoto() {
        return urlFoto;
    }

    public void setUrlFoto(String urlFoto) {
        this.urlFoto = urlFoto;
    }
}