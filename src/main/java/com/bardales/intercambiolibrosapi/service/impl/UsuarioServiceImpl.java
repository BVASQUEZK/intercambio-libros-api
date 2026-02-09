package com.bardales.intercambiolibrosapi.service.impl;

import com.bardales.intercambiolibrosapi.dto.LoginResponseDTO;
import com.bardales.intercambiolibrosapi.dto.PerfilUsuarioDTO;
import com.bardales.intercambiolibrosapi.dto.UsuarioUpdateDTO;
import com.bardales.intercambiolibrosapi.entity.Usuario;
import com.bardales.intercambiolibrosapi.exception.ResourceNotFoundException;
import com.bardales.intercambiolibrosapi.exception.UnauthorizedException;
import com.bardales.intercambiolibrosapi.repository.UsuarioRepository;
import com.bardales.intercambiolibrosapi.service.UsuarioService;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    private final UsuarioRepository usuarioRepository;
    private final JdbcTemplate jdbcTemplate;

    public UsuarioServiceImpl(UsuarioRepository usuarioRepository, JdbcTemplate jdbcTemplate) {
        this.usuarioRepository = usuarioRepository;
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public LoginResponseDTO login(String correo, String password) {
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
                "CALL sp_login_usuario_app(?, ?)", correo, password);
        if (rows.isEmpty()) {
            throw new ResourceNotFoundException("Credenciales invalidas");
        }
        Map<String, Object> row = rows.get(0);
        Number idUsuario = (Number) (row.containsKey("id_usuario")
                ? row.get("id_usuario")
                : row.get("idUsuario"));
        String nombre = row.get("nombre") == null ? null : row.get("nombre").toString();
        if (nombre == null) {
            String nombres = row.get("nombres") == null ? null : row.get("nombres").toString();
            String apellidos = row.get("apellidos") == null ? null : row.get("apellidos").toString();
            if (nombres != null && apellidos != null) {
                nombre = (nombres + " " + apellidos).trim();
            } else if (nombres != null) {
                nombre = nombres;
            } else if (apellidos != null) {
                nombre = apellidos;
            }
        }
        String token = UUID.randomUUID().toString();
        return new LoginResponseDTO(idUsuario == null ? null : idUsuario.intValue(), nombre, token);
    }

    @Override
    public PerfilUsuarioDTO obtenerPerfil(int idUsuario) {
        Usuario usuario = usuarioRepository.findById(idUsuario)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        Double promedio = usuarioRepository.obtenerValoracion(idUsuario);
        return new PerfilUsuarioDTO(
                usuario.getNombres(),
                usuario.getApellidos(),
                usuario.getUrlFotoPerfil(),
                usuario.getFechaRegistro(),
                promedio == null ? 0.0 : promedio);
    }

    @Override
    public LoginResponseDTO actualizarPerfil(int idUsuarioHeader, UsuarioUpdateDTO dto) {
        if (dto.getIdUsuario() == null || !dto.getIdUsuario().equals(idUsuarioHeader)) {
            throw new UnauthorizedException("No autorizado para editar este perfil");
        }

        usuarioRepository.actualizarPerfil(
                dto.getIdUsuario(),
                dto.getNombres(),
                dto.getApellidos(),
                dto.getUrlFoto()
        );

        Usuario usuario = usuarioRepository.findById(dto.getIdUsuario())
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        String urlFoto = usuario.getUrlFotoPerfil();
        if (urlFoto == null || urlFoto.isBlank()) {
            urlFoto = "default_user.png";
        }
        return new LoginResponseDTO(usuario.getNombres(), usuario.getApellidos(), urlFoto);
    }

    @Override
    public Map<String, Object> registrarUsuario(String nombre, String correo, String clave) {
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
                "CALL sp_registrar_usuario_app(?, ?, ?)", nombre, correo, clave);
        if (rows.isEmpty()) {
            throw new ResourceNotFoundException("No se pudo registrar el usuario");
        }
        Map<String, Object> row = rows.get(0);
        Number idUsuario = (Number) row.get("id_usuario");
        if (idUsuario == null || idUsuario.intValue() <= 0) {
            throw new ResourceNotFoundException("Correo ya registrado");
        }
        return Map.of("mensaje", "REGISTRO_OK", "id_usuario", idUsuario.intValue());
    }
}
