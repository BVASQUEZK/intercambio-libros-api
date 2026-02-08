package com.bardales.intercambiolibrosapi.repository;

public interface LibroHomeProjection {
    Integer getId_libro();
    String getTitulo();
    String getAutor();
    String getUrl_portada();
}
