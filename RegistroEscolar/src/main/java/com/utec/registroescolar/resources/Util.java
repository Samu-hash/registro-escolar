/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utec.registroescolar.resources;

import java.util.Objects;

/**
 *
 * @author Samuel
 */
public class Util {
    
    
    public static boolean findNullOrEmpty(Object value){
        if(Objects.isNull(value))
            return true;
        
        return value.equals("");
    }
}
