package com.bardales.intercambiolibrosapi.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "solicitud")
public class Solicitud {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_solicitud")
    private Integer idSolicitud;

    @Column(name = "id_solicitante", nullable = false)
    private Integer idSolicitante;

    @Column(name = "id_receptor", nullable = false)
    private Integer idReceptor;

    @Column(name = "tipo", nullable = false)
    private String tipo;

    @Column(name = "estado", insertable = false)
    private String estado;

    @CreationTimestamp
    @Column(name = "fecha_solicitud", updatable = false)
    private LocalDateTime fechaSolicitud;

    public Solicitud() {
    }

    public Solicitud(Integer idSolicitud, Integer idSolicitante, Integer idReceptor, String tipo, String estado,
            LocalDateTime fechaSolicitud) {
        this.idSolicitud = idSolicitud;
        this.idSolicitante = idSolicitante;
        this.idReceptor = idReceptor;
        this.tipo = tipo;
        this.estado = estado;
        this.fechaSolicitud = fechaSolicitud;
    }

    public Integer getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(Integer idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public Integer getIdSolicitante() {
        return idSolicitante;
    }

    public void setIdSolicitante(Integer idSolicitante) {
        this.idSolicitante = idSolicitante;
    }

    public Integer getIdReceptor() {
        return idReceptor;
    }

    public void setIdReceptor(Integer idReceptor) {
        this.idReceptor = idReceptor;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
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