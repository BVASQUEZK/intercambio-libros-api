package com.bardales.intercambiolibrosapi.controller;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bardales.intercambiolibrosapi.dto.LoginResponseDTO;
import com.bardales.intercambiolibrosapi.dto.PerfilUsuarioDTO;
import com.bardales.intercambiolibrosapi.dto.UsuarioUpdateDTO;
import com.bardales.intercambiolibrosapi.service.UsuarioService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/usuarios")
@CrossOrigin(origins = "*")
public class UsuarioController {

    private final UsuarioService usuarioService;

    public UsuarioController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @GetMapping("/perfil/{id}")
    public PerfilUsuarioDTO obtenerPerfil(@PathVariable("id") int idUsuario) {
        return usuarioService.obtenerPerfil(idUsuario);
    }

    @GetMapping("/me")
    public PerfilUsuarioDTO obtenerMiPerfil(@RequestHeader("X-User-Id") int idUsuario) {
        return usuarioService.obtenerPerfil(idUsuario);
    }

    @PutMapping("/perfil")
    public LoginResponseDTO actualizarPerfil(
            @RequestHeader("X-User-Id") int idUsuario,
            @Valid @RequestBody UsuarioUpdateDTO dto) {
        return usuarioService.actualizarPerfil(idUsuario, dto);
    }
}