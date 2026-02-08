package com.bardales.intercambiolibrosapi.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bardales.intercambiolibrosapi.dto.LibroDTO;
import com.bardales.intercambiolibrosapi.dto.LibroHomeDTO;
import com.bardales.intercambiolibrosapi.dto.LibroRegistroDTO;
import com.bardales.intercambiolibrosapi.repository.LibroHomeProjection;
import com.bardales.intercambiolibrosapi.repository.LibroRepository;
import com.bardales.intercambiolibrosapi.service.LibroService;

@Service
public class LibroServiceImpl implements LibroService {

    private final LibroRepository libroRepository;

    public LibroServiceImpl(LibroRepository libroRepository) {
        this.libroRepository = libroRepository;
    }

    @Override
    public List<LibroHomeDTO> obtenerLibrosRecientes(int pagina, int cantidad) {
        int safePagina = Math.max(pagina, 1);
        int safeCantidad = Math.max(cantidad, 1);
        int offset = (safePagina - 1) * safeCantidad;

        return libroRepository.listarRecientes(safeCantidad, offset)
                .stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public List<LibroDTO> buscarLibros(String query, Integer idCategoria, String estado, int pagina, int cantidad) {
        int safePagina = Math.max(pagina, 1);
        int safeCantidad = Math.max(cantidad, 1);
        int offset = (safePagina - 1) * safeCantidad;
        String filtro = (query == null || query.isBlank()) ? null : query.trim();
        String estadoFiltro = (estado == null || estado.isBlank()) ? null : estado.trim();

        return libroRepository.buscarLibros(filtro, filtro, idCategoria, estadoFiltro, safeCantidad, offset)
                .stream()
                .map(this::toBusquedaDto)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public Integer registrarLibro(LibroRegistroDTO dto) {
        String primeraUrl = null;
        if (dto.getUrlsImagenes() != null) {
            for (String url : dto.getUrlsImagenes()) {
                if (url == null || url.isBlank()) {
                    continue;
                }
                primeraUrl = url.trim();
                break;
            }
        }

        Integer idLibro = libroRepository.registrarLibro(
                dto.getIdUsuario(),
                dto.getIdCategoria(),
                dto.getTitulo(),
                dto.getAutor(),
                dto.getDescripcion(),
                dto.getEstado(),
                primeraUrl
        );
        if (idLibro == null || idLibro <= 0) {
            throw new RuntimeException("No se pudo registrar el libro");
        }

        if (dto.getUrlsImagenes() != null) {
            boolean firstUsed = false;
            for (String url : dto.getUrlsImagenes()) {
                if (url == null || url.isBlank()) {
                    continue;
                }
                if (!firstUsed) {
                    firstUsed = true;
                    continue;
                }
                libroRepository.vincularImagen(idLibro, url.trim());
            }
        }

        return idLibro;
    }

    private LibroHomeDTO toDto(LibroHomeProjection p) {
        return new LibroHomeDTO(
                p.getTitulo(),
                p.getAutor(),
                null,
                p.getUrl_portada(),
                null
        );
    }

    private LibroDTO toBusquedaDto(LibroHomeProjection p) {
        return new LibroDTO(
                p.getId_libro(),
                p.getTitulo(),
                p.getAutor(),
                p.getUrl_portada()
        );
    }
}