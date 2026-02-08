package com.bardales.intercambiolibrosapi.service;

import java.util.List;

import com.bardales.intercambiolibrosapi.dto.LibroDTO;
import com.bardales.intercambiolibrosapi.dto.LibroHomeDTO;
import com.bardales.intercambiolibrosapi.dto.LibroRegistroDTO;

public interface LibroService {
    List<LibroHomeDTO> obtenerLibrosRecientes(int pagina, int cantidad);
    List<LibroDTO> buscarLibros(String query, Integer idCategoria, String estado, int pagina, int cantidad);
    Integer registrarLibro(LibroRegistroDTO dto);
}
