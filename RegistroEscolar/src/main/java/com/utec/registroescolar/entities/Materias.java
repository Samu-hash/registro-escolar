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
public class Materias {
    
    private Integer materia_id;
    private Integer docente_id;
    private Usuarios docente;
    private String nombre_materia;
    private String descripcion;
    private String estado;
    
}
