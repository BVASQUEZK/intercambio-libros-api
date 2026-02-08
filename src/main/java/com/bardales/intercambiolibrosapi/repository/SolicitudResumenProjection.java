package com.bardales.intercambiolibrosapi.repository;

import java.time.LocalDateTime;

public interface SolicitudResumenProjection {
    Integer getId_solicitud();
    String getTitulo_libro();
    String getNombre_contraparte();
    String getTipo();
    String getEstado();
    LocalDateTime getFecha_solicitud();
    String getUrl_imagen();
}
