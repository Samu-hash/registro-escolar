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
    
    private Integer materiaId;
    private Usuarios docente;
    private String nombreMateria;
    private String descripcion;
    
}
