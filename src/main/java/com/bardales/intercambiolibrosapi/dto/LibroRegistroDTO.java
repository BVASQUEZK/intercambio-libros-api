package com.bardales.intercambiolibrosapi.dto;

import java.util.List;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

public class LibroRegistroDTO {
    @NotBlank
    private String titulo;

    @NotBlank
    private String autor;

    private String descripcion;

    private String estado;

    @NotNull
    private Integer idUsuario;

    private Integer idCategoria;

    @NotEmpty
    private List<String> urlsImagenes;

    public LibroRegistroDTO() {
    }

    public LibroRegistroDTO(String titulo, String autor, String descripcion, String estado, Integer idUsuario,
            Integer idCategoria, List<String> urlsImagenes) {
        this.titulo = titulo;
        this.autor = autor;
        this.descripcion = descripcion;
        this.estado = estado;
        this.idUsuario = idUsuario;
        this.idCategoria = idCategoria;
        this.urlsImagenes = urlsImagenes;
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

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Integer getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(Integer idCategoria) {
        this.idCategoria = idCategoria;
    }

    public List<String> getUrlsImagenes() {
        return urlsImagenes;
    }

    public void setUrlsImagenes(List<String> urlsImagenes) {
        this.urlsImagenes = urlsImagenes;
    }
}