package com.bardales.intercambiolibrosapi.dto;

public class LoginResponseDTO {
    private Integer idUsuario;
    private String nombre;
    private String token;
    private String nombres;
    private String apellidos;
    private String urlFoto;

    public LoginResponseDTO() {
    }

    public LoginResponseDTO(Integer idUsuario, String nombre, String token) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.token = token;
    }

    public LoginResponseDTO(Integer idUsuario, String nombre, String token,
            String nombres, String apellidos, String urlFoto) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.token = token;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.urlFoto = urlFoto;
    }

    public LoginResponseDTO(String nombres, String apellidos, String urlFoto) {
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

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
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
