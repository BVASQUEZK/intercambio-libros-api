package com.bardales.intercambiolibrosapi.service.impl;

import com.bardales.intercambiolibrosapi.dto.LoginResponseDTO;
import com.bardales.intercambiolibrosapi.dto.PerfilUsuarioDTO;
import com.bardales.intercambiolibrosapi.dto.UsuarioUpdateDTO;
import com.bardales.intercambiolibrosapi.entity.Usuario;
import com.bardales.intercambiolibrosapi.exception.ResourceNotFoundException;
import com.bardales.intercambiolibrosapi.exception.UnauthorizedException;
import com.bardales.intercambiolibrosapi.repository.LoginResponseProjection;
import com.bardales.intercambiolibrosapi.repository.UsuarioRepository;
import com.bardales.intercambiolibrosapi.service.UsuarioService;

import org.springframework.stereotype.Service;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    private final UsuarioRepository usuarioRepository;

    public UsuarioServiceImpl(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Override
    public LoginResponseDTO login(String correo, String password) {
        LoginResponseProjection projection = usuarioRepository.validarLogin(correo, password)
                .orElseThrow(() -> new ResourceNotFoundException("Credenciales inválidas"));
        String urlFoto = projection.getUrl_foto();
        if (urlFoto == null || urlFoto.isBlank()) {
            urlFoto = "default_user.png";
        }
        return new LoginResponseDTO(projection.getNombres(), projection.getApellidos(), urlFoto);
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
}