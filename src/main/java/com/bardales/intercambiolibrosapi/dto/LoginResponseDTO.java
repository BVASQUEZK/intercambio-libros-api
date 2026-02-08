package com.bardales.intercambiolibrosapi.dto;

public class LoginResponseDTO {
    private String nombres;
    private String apellidos;
    private String urlFoto;

    public LoginResponseDTO() {
    }

    public LoginResponseDTO(String nombres, String apellidos, String urlFoto) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.urlFoto = urlFoto;
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