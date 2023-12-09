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
public class MateriasEnCiclo {
    
    private Integer materia_en_ciclo_id;
    private Integer materia_id;
    private Integer ciclo_id;
    private String estado;
    private Materias materia;
    private Ciclos ciclo;
    private String periodo_ini;
    private String periodo_end;
}
