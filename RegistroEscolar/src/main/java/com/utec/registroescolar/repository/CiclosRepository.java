/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utec.registroescolar.repository;

import com.utec.registroescolar.entities.Ciclos;
import com.utec.registroescolar.entities.Usuarios;
import com.utec.registroescolar.resources.ConnectionDatabaseService;
import com.utec.registroescolar.resources.MysqlConnect;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 *
 * @author Samuel
 */
public class CiclosRepository {

    private ConnectionDatabaseService connect;

    public List<Ciclos> listarCiclos() {
        connect = new MysqlConnect();
        try {

            List<Ciclos> list = (List) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "select * from ciclos where estado = 'ACTIVO'",
                    new ArrayList<>(), false, Ciclos.class);

            return list;
        } catch (Exception e) {
            return null;
        }
    }

    public boolean saveCiclo(String nombre, Integer anio,
            String estado) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", nombre});
            parameters.add(new Object[]{"Integer", anio});
            parameters.add(new Object[]{"String", estado});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "INSERT INTO ciclos "
                    + "(nombre_ciclo, anio_academico, estado) "
                    + "VALUES(?, ?, ?)",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean updateCiclo(String nombre, Integer anio,
            String estado, Integer idCiclo) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", nombre});
            parameters.add(new Object[]{"Integer", anio});
            parameters.add(new Object[]{"String", estado});
            parameters.add(new Object[]{"Integer", idCiclo});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "UPDATE ciclos "
                    + "SET nombre_ciclo=?, anio_academico=?, estado=? "
                    + "WHERE ciclo_id=?",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean eliminarCiclo(Integer idCiclo) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", idCiclo});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "update ciclos set estado = 'INACTIVO' where ciclo_id = ?",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }

            return true;
        } catch (Exception e) {
            return false;
        }
    }

}
