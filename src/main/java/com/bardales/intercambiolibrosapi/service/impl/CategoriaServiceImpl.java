package com.bardales.intercambiolibrosapi.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bardales.intercambiolibrosapi.entity.Categoria;
import com.bardales.intercambiolibrosapi.repository.CategoriaRepository;
import com.bardales.intercambiolibrosapi.service.CategoriaService;

@Service
public class CategoriaServiceImpl implements CategoriaService {

    private final CategoriaRepository categoriaRepository;

    public CategoriaServiceImpl(CategoriaRepository categoriaRepository) {
        this.categoriaRepository = categoriaRepository;
    }

    @Override
    public List<Categoria> listarCategorias() {
        return categoriaRepository.listarCategorias();
    }
}