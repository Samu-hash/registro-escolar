/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utec.registroescolar.entities;

import lombok.Getter;
import lombok.Setter;

/**
 *
 * @author Samuel
 */
@Getter
@Setter
public class Usuarios {
    
    private Integer user_id;
    private Integer ciclo_actual;
    private String nombre;
    private String apellido;
    private String correo_electronico;
    private String contrasena;
    private Integer es_docente;
    private String estado_pago;
    private String role;
    private String estado_usuario;
    private Ciclos cicloActual;
    
}
