package com.bardales.intercambiolibrosapi.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public class LibroDTO {
    @NotNull
    private Integer idLibro;

    @NotBlank
    private String titulo;

    @NotBlank
    private String autor;

    @NotBlank
    private String urlPortada;

    public LibroDTO() {
    }

    public LibroDTO(Integer idLibro, String titulo, String autor, String urlPortada) {
        this.idLibro = idLibro;
        this.titulo = titulo;
        this.autor = autor;
        this.urlPortada = urlPortada;
    }

    public Integer getIdLibro() {
        return idLibro;
    }

    public void setIdLibro(Integer idLibro) {
        this.idLibro = idLibro;
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

    public String getUrlPortada() {
        return urlPortada;
    }

    public void setUrlPortada(String urlPortada) {
        this.urlPortada = urlPortada;
    }
}