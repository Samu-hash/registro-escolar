/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.utec.registroescolar.resources;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Samuel
 */
public class MysqlConnect implements ConnectionDatabaseService{
    
    @Override
    public void closeConnection(Connection c) throws SQLException {
        c.close();
    }

    @Override
    public Connection connectToDabase() {
        try {
            
            Class.forName("com.mysql.jdbc.Driver");
           
            return DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/registro_escolar?"
                            + "user=root&password=");
        } catch (ClassNotFoundException | SQLException e) {
            return null;
        }
    }
}
