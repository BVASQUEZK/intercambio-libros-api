package com.bardales.intercambiolibrosapi.dto;

public class LibroHomeDTO {
    private String titulo;
    private String autor;
    private String ciudad;
    private String urlImagen;
    private String nombreDueno;

    public LibroHomeDTO() {
    }

    public LibroHomeDTO(String titulo, String autor, String ciudad, String urlImagen, String nombreDueno) {
        this.titulo = titulo;
        this.autor = autor;
        this.ciudad = ciudad;
        this.urlImagen = urlImagen;
        this.nombreDueno = nombreDueno;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getUrlImagen() {
        return urlImagen;
    }

    public void setUrlImagen(String urlImagen) {
        this.urlImagen = urlImagen;
    }

    public String getNombreDueno() {
        return nombreDueno;
    }

    public void setNombreDueno(String nombreDueno) {
        this.nombreDueno = nombreDueno;
    }
}