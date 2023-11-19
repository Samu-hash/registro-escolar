/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utec.registroescolar.entities;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;

/**
 *
 * @author Samuel
 */
@Getter
@Setter
public class Inscripciones {
    
    private Integer inscripcionId;
    private Usuarios usuario;
    private MateriasEnCiclo materiasEnCiclo;
    private Date fechaInscripcion;
}
