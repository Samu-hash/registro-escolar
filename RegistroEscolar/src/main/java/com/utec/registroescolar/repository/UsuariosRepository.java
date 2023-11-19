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
public class UsuariosRepository {

    private ConnectionDatabaseService connect;

    public boolean validateCredential(String email, String password) {
        connect = new MysqlConnect();
        try {
            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", email});
            parameters.add(new Object[]{"String", password});

            List<Usuarios> u = (List) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "select * from usuarios where correo_electronico = ? and contrasena = ? and estado_usuario <> 'INACTIVO'",
                    parameters, false, Usuarios.class);

            if (Objects.isNull(u) || u.isEmpty()) {
                return false;
            }

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public Usuarios buscarUsuario(String email) {
        try {
            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", email});

            List<Usuarios> lu = (List) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "select * from usuarios where correo_electronico = ? and estado_usuario <> 'INACTIVO'",
                    parameters, false, Usuarios.class);

            if (Objects.isNull(lu)) {
                return null;
            }

            Usuarios u = lu.get(0);

            List<Object[]> parameters1 = new ArrayList<>();
            parameters1.add(new Object[]{"Integer", u.getCiclo_actual()});

            List<Ciclos> c = (List) ConnectionDatabaseService.executeSql(connect.connectToDabase(),
                    "select * from ciclos where ciclo_id = ?", parameters1, false, Ciclos.class);

            u.setCicloActual(c.get(0));

            return u;
        } catch (Exception e) {
            return null;
        }
    }

    public List<Usuarios> listarUsuarios(Integer idUsuario) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", idUsuario});

            List<Usuarios> list = (List) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "select * from usuarios where "
                    + "estado_usuario <> 'INACTIVO' and user_id <> ?",
                    parameters, false, Usuarios.class);

            for (Usuarios u : list) {
                List<Object[]> parameters1 = new ArrayList<>();

                parameters1.add(new Object[]{"Integer", u.getCiclo_actual()});
                List<Ciclos> c = (List) ConnectionDatabaseService.executeSql(connect.connectToDabase(),
                        "select * from ciclos where ciclo_id = ?",
                        parameters1, false, Ciclos.class);

                if (!Objects.isNull(c)) {
                    u.setCicloActual(c.get(0));
                }
            }
            return list;
        } catch (Exception e) {
            return null;
        }
    }

    public boolean saveUser(String nombres, String apellidos, String correo,
            String clave, String esDocente, String estadoPago, Integer cicloActual, String role, String estadoU) {
        connect = new MysqlConnect();
        try {
            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", nombres});
            parameters.add(new Object[]{"String", apellidos});
            parameters.add(new Object[]{"String", correo});
            parameters.add(new Object[]{"String", clave});
            parameters.add(new Object[]{"String", esDocente});
            parameters.add(new Object[]{"String", estadoPago});
            parameters.add(new Object[]{"Integer", cicloActual});
            parameters.add(new Object[]{"String", role});
            parameters.add(new Object[]{"String", estadoU});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "INSERT INTO usuarios "
                    + "(nombre, apellido, correo_electronico, contrasena, es_docente, "
                    + "estado_pago, ciclo_actual, role, estado_usuario) "
                    + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean updateUser(String nombres, String apellidos, String correo,
            String clave, String esDocente, String estadoPago, Integer cicloActual, String role, String estadoU, Integer idUsuario) {
        connect = new MysqlConnect();
        try {
            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"String", nombres});
            parameters.add(new Object[]{"String", apellidos});
            parameters.add(new Object[]{"String", correo});
            parameters.add(new Object[]{"String", clave});
            parameters.add(new Object[]{"String", esDocente});
            parameters.add(new Object[]{"String", estadoPago});
            parameters.add(new Object[]{"Integer", cicloActual});
            parameters.add(new Object[]{"String", role});
            parameters.add(new Object[]{"String", estadoU});
            parameters.add(new Object[]{"Integer", idUsuario});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "UPDATE registro_escolar.usuarios "
                    + "SET nombre=?, apellido=?, correo_electronico=?, "
                    + "contrasena=?, es_docente=?, estado_pago=?, "
                    + "ciclo_actual=?, `role`=?, estado_usuario=? "
                    + "WHERE user_id=?;",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean eliminarUsuario(Integer id) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", id});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "update usuarios set estado_usuario = 'INACTIVO' where user_id = ?",
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
