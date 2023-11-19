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
                    "select * from ciclos",
                    new ArrayList<>(), false, Ciclos.class);

            return list;
        } catch (Exception e) {
            return null;
        }
    }

}
