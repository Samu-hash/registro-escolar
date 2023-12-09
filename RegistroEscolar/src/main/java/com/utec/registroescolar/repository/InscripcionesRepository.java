/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utec.registroescolar.repository;

import com.utec.registroescolar.entities.CatalogoTiposNotasActividades;
import com.utec.registroescolar.entities.Ciclos;
import com.utec.registroescolar.entities.Inscripciones;
import com.utec.registroescolar.entities.Materias;
import com.utec.registroescolar.entities.MateriasEnCiclo;
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
public class InscripcionesRepository {

    private ConnectionDatabaseService connect;

    public List<Inscripciones> listarInscripciones() {
        connect = new MysqlConnect();
        try {

            List<Inscripciones> list = (List) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "select * from inscripciones "
                    + "where estado not in('INACTIVO', 'EN CURSO')",
                    new ArrayList<>(), false, Inscripciones.class);

            for (Inscripciones i : list) {
                List<Object[]> parameters = new ArrayList<>();
                parameters.add(new Object[]{"Integer", i.getUser_id()});

                List<Usuarios> u = (List) ConnectionDatabaseService.executeSql(connect.connectToDabase(),
                        "select * from usuarios where user_id = ?",
                        parameters, false, Usuarios.class);

                if (!Objects.isNull(u)) {
                    i.setUsuario(u.get(0));
                }

                MateriasCiclosRepository repo = new MateriasCiclosRepository();
                List<MateriasEnCiclo> lmateria = repo.listarMateriasCiclos(i.getMateria_en_ciclo_id());

                if (!Objects.isNull(lmateria)) {
                    i.setMateriasEnCiclo(lmateria.get(0));
                }
            }

            return list;
        } catch (Exception e) {
            return null;
        }
    }

    public boolean saveInscripciones(Integer userId, Integer materiaCicloId,
            String fechaIns, String estado) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", userId});
            parameters.add(new Object[]{"Integer", materiaCicloId});
            parameters.add(new Object[]{"String", fechaIns});
            parameters.add(new Object[]{"String", estado});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "INSERT INTO inscripciones "
                    + "(user_id, materia_en_ciclo_id, fecha_inscripcion, estado) "
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

    public boolean updateInscripciones(Integer userId, Integer materiaCicloId,
            String fechaIns, String estado, Integer inscripcionesId) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", userId});
            parameters.add(new Object[]{"Integer", materiaCicloId});
            parameters.add(new Object[]{"String", fechaIns});
            parameters.add(new Object[]{"String", estado});
            parameters.add(new Object[]{"Integer", inscripcionesId});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "UPDATE inscripciones "
                    + "SET user_id=?, materia_en_ciclo_id=?, fecha_inscripcion=?, estado=? "
                    + "WHERE inscripcion_id=?",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean eliminar(Integer inscripcionId) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", inscripcionId});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "update inscripciones "
                    + "set estado = 'INACTIVO' where inscripcion_id = ?",
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
