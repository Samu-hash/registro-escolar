/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utec.registroescolar.repository;

import com.utec.registroescolar.entities.CatalogoTiposNotasActividades;
import com.utec.registroescolar.entities.Ciclos;
import com.utec.registroescolar.entities.Materias;
import com.utec.registroescolar.entities.MateriasEnCiclo;
import com.utec.registroescolar.entities.Usuarios;
import com.utec.registroescolar.resources.ConnectionDatabaseService;
import com.utec.registroescolar.resources.MysqlConnect;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 *
 * @author Samuel
 */
public class MateriasCiclosRepository {

    private ConnectionDatabaseService connect;

    public List<MateriasEnCiclo> listarMateriasCiclos(Integer id) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameter = new ArrayList<>();

            String sql = "select * from materias_en_ciclos where estado <> 'INACTIVO'";
            if (id != 0) {
                sql += " and materia_en_ciclo_id = ?";
                parameter.add(new Object[]{"Integer", id});
            }

            List<MateriasEnCiclo> list = (List) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    sql,
                    parameter, false, MateriasEnCiclo.class);

            for (MateriasEnCiclo u : list) {
                List<Object[]> parameters = new ArrayList<>();
                parameters.add(new Object[]{"Integer", u.getMateria_id()});

                List<Materias> m = (List) ConnectionDatabaseService.executeSql(connect.connectToDabase(),
                        "select * from materias where materia_id = ?",
                        parameters, false, Materias.class);

                if (!Objects.isNull(m)) {
                    u.setMateria(m.get(0));

                    UsuariosRepository usuariosRepository = new UsuariosRepository();

                    List<Usuarios> lu = usuariosRepository.listarUsuarios(u.getMateria().getDocente_id(), true, false);
                    if (!Objects.isNull(lu)) {
                        u.getMateria().setDocente(lu.get(0));
                    }
                }

                List<Object[]> parameters1 = new ArrayList<>();
                parameters1.add(new Object[]{"Integer", u.getCiclo_id()});
                List<Ciclos> c = (List) ConnectionDatabaseService.executeSql(connect.connectToDabase(),
                        "select * from ciclos where ciclo_id = ?",
                        parameters1, false, Ciclos.class);

                if (!Objects.isNull(c)) {
                    u.setCiclo(c.get(0));
                }
            }

            return list;
        } catch (Exception e) {
            return null;
        }
    }

    public boolean existeRegistroMateriaCiclo(Integer materiaId, Integer cicloId) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", materiaId});
            parameters.add(new Object[]{"Integer", cicloId});

            List<MateriasEnCiclo> list = (List) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "select * from materias_en_ciclos "
                    + "where materia_id =? and ciclo_id =?",
                    parameters, false, MateriasEnCiclo.class);

            if (Objects.isNull(list) || list.isEmpty()) {
                return false;
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean saveMateriasCiclo(Integer materiaId, Integer cicloId,
            String estado, String fechaIni, String fechaEnd) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", materiaId});
            parameters.add(new Object[]{"Integer", cicloId});
            parameters.add(new Object[]{"String", estado});
            parameters.add(new Object[]{"String", fechaIni});
            parameters.add(new Object[]{"String", fechaEnd});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "INSERT INTO materias_en_ciclos "
                    + "(materia_id, ciclo_id, estado, "
                    + "periodo_ini, periodo_end) "
                    + "VALUES(?, ?, ?, ?, ?)",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean updateMateriasCiclo(Integer materiaId, Integer cicloId, String estado,
            String fechaIni, String fechaEnd, Integer materiaCicloId) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", materiaId});
            parameters.add(new Object[]{"Integer", cicloId});
            parameters.add(new Object[]{"String", estado});
            parameters.add(new Object[]{"String", fechaIni});
            parameters.add(new Object[]{"String", fechaEnd});
            parameters.add(new Object[]{"Integer", materiaCicloId});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "UPDATE materias_en_ciclos "
                    + "SET materia_id=?, ciclo_id=?, estado=?, "
                    + "periodo_ini=?, periodo_end=? "
                    + "WHERE materia_en_ciclo_id=?",
                    parameters, true, Integer.class);

            if (Objects.isNull(value) || value == 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean eliminarCiclo(Integer materiaCicloId) {
        connect = new MysqlConnect();
        try {

            List<Object[]> parameters = new ArrayList<>();
            parameters.add(new Object[]{"Integer", materiaCicloId});

            Integer value = (Integer) ConnectionDatabaseService.executeSql(
                    connect.connectToDabase(),
                    "update materias_en_ciclos "
                    + "set estado = 'INACTIVO' where materia_en_ciclo_id = ?",
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
