package com.bardales.intercambiolibrosapi.repository;

import java.time.LocalDateTime;

public interface IntercambioSolicitudProjection {
    Integer getId_solicitud();
    String getTitulo_libro();
    String getNombre_otra_parte();
    String getEstado();
    LocalDateTime getFecha_solicitud();
}
