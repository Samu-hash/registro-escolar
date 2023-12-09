/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utec.registroescolar.repository;

import com.utec.registroescolar.entities.CatalogoTiposNotasActividades;
import com.utec.registroescolar.resources.ConnectionDatabaseService;
import com.utec.registroescolar.resources.MysqlConnect;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 *
 * @author Samuel
 */
public class TipoActividadesRepository {

    private ConnectionDatabaseService connect;

    public List<CatalogoTiposNotasActividades> listarTiposActividades() {
        connect = new MysqlConnect();
        try {

            List<CatalogoTiposNotasActividades> list = (List) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "select * from catalogo_tipos_notas_actividades "
                    + "where estado <> 'INACTIVO'",
                    new ArrayList<>(), false, CatalogoTiposNotasActividades.class);

            return list;
        } catch (Exception e) {
            return null;
        }
    }

    public boolean saveTiposActividades(String nombreTipo, String estado) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", nombreTipo});
            parameters.add(new Object[]{"String", estado});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "INSERT INTO catalogo_tipos_notas_actividades "
                    + "(nombre_tipo, estado) "
                    + "VALUES(?, ?)",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean updateTipoActividades(String nombreTipo, String estado, Integer idTipoAct) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", nombreTipo});
            parameters.add(new Object[]{"String", estado});
            parameters.add(new Object[]{"Integer", idTipoAct});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "UPDATE catalogo_tipos_notas_actividades "
                    + "SET nombre_tipo=?, estado=? "
                    + "WHERE tipo_id=?",
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
                    "update catalogo_tipos_notas_actividades "
                    + "set estado = 'INACTIVO' where tipo_id = ?",
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
