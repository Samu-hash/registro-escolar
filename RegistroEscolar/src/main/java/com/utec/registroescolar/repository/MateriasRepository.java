/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utec.registroescolar.repository;

import com.utec.registroescolar.entities.Materias;
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
public class MateriasRepository {

    private ConnectionDatabaseService connect;

    public boolean saveUser(String nombreMateria, String descripcion,
            Integer docenteId, String estado) {
        connect = new MysqlConnect();
        try {
            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", nombreMateria});
            parameters.add(new Object[]{"String", descripcion});
            parameters.add(new Object[]{"Integer", docenteId});
            parameters.add(new Object[]{"String", estado});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "INSERT INTO materias "
                    + "(nombre_materia, descripcion, docente_id, estado) "
                    + "VALUES(?, ?, ?, ?)",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean updateUser(String nombreMateria, String descripcion,
            Integer docenteId, String estado, Integer materiaId) {
        connect = new MysqlConnect();
        try {
            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", nombreMateria});
            parameters.add(new Object[]{"String", descripcion});
            parameters.add(new Object[]{"Integer", docenteId});
            parameters.add(new Object[]{"String", estado});
            parameters.add(new Object[]{"Integer", materiaId});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "UPDATE materias SET nombre_materia=?, "
                    + "descripcion=?, docente_id=?, estado=? "
                    + "WHERE materia_id=?",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean eliminarCiclo(Integer idMateria) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", idMateria});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "update materias "
                    + "set estado = 'INACTIVO' "
                    + "where materia_id = ?",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public List<Materias> listarMaterias() {
        connect = new MysqlConnect();
        try {

            List<Materias> list = (List) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(), "select * from materias "
                    + "where estado <> 'INACTIVO'",
                    new ArrayList<>(), false, Materias.class);

            for (Materias u : list) {
                List<Object[]> parameters1 = new ArrayList<>();
                parameters1.add(new Object[]{"Integer", u.getDocente_id()});
                
                List<Usuarios> c = (List) ConnectionDatabaseService.executeSql(connect.connectToDabase(),
                        "select * from usuarios where user_id = ?",
                        parameters1, false, Usuarios.class);

                if (!Objects.isNull(c)) {
                    u.setDocente(c.get(0));
                }
            }
            return list;
        } catch (Exception e) {
            return null;
        }
    }
}
