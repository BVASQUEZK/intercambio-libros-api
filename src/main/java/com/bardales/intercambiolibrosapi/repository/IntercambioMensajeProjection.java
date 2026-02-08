package com.bardales.intercambiolibrosapi.repository;

import java.time.LocalDateTime;

public interface IntercambioMensajeProjection {
    String getEmisor_nombre();
    String getContenido_mensaje();
    LocalDateTime getFecha_envio();
    Boolean getEs_mio();
}
