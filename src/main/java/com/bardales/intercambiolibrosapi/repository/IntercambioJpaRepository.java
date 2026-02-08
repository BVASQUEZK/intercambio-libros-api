package com.bardales.intercambiolibrosapi.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.bardales.intercambiolibrosapi.entity.Solicitud;

public interface IntercambioJpaRepository extends JpaRepository<Solicitud, Integer>, IntercambioRepository {
}