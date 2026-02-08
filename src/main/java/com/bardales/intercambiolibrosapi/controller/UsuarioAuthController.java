package com.bardales.intercambiolibrosapi.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.bardales.intercambiolibrosapi.service.UsuarioService;

@RestController
@RequestMapping("/usuarios")
@CrossOrigin(origins = "*")
public class UsuarioAuthController {

    private final UsuarioService usuarioService;

    public UsuarioAuthController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @PostMapping("/registrar")
    public ResponseEntity<Map<String, Object>> registrar(@RequestBody Map<String, String> body) {
        String nombre = body.get("nombre");
        String correo = body.get("correo");
        String clave = body.get("clave");
        if (nombre == null || nombre.isBlank() || correo == null || correo.isBlank()
                || clave == null || clave.isBlank()) {
            throw new IllegalArgumentException("Faltan campos obligatorios");
        }
        Map<String, Object> response = usuarioService.registrarUsuario(nombre, correo, clave);
        return ResponseEntity.status(201).body(response);
    }
}
