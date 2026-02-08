package com.bardales.intercambiolibrosapi.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.bardales.intercambiolibrosapi.entity.Categoria;

public interface CategoriaRepository extends JpaRepository<Categoria, Integer> {

    @Query(value = "CALL sp_listar_categorias()", nativeQuery = true)
    List<Categoria> listarCategorias();
}
