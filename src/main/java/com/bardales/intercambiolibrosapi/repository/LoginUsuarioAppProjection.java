package com.bardales.intercambiolibrosapi.repository;

public interface LoginUsuarioAppProjection {
    Integer getIdUsuario();
    String getNombres();
    String getApellidos();
    String getCorreo();
    String getPassword();
    String getEstado();
}
