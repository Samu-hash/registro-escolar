package com.utec.registroescolar.resources;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 *
 * @author Samuel
 */
public interface ConnectionDatabaseService {

    Connection connectToDabase();

    void closeConnection(Connection c) throws SQLException;

    public static <T> Object executeSql(Connection c, String sql, List<Object[]> parameters,
            boolean isInsert, Class<T> clazz) throws Exception {
        try {
            PreparedStatement statement = c.prepareStatement(sql);
            Integer count = 1;
            for (Object[] parameter : parameters) {
                if (parameter[0] == "Integer") {
                    statement.setInt(count, Integer.parseInt(parameter[1].toString()));
                } else if (parameter[0] == "String") {
                    statement.setString(count, (parameter[1] == null) ? null : parameter[1].toString());
                } else if (parameter[0] == "Date") {
                    statement.setDate(count, (Date) parameter[1]);
                }
                count++;
            }
            if (isInsert) {
                return statement.executeUpdate();
            } else {
                return resultSetToObjects(statement.executeQuery(), clazz);
            }
        } catch (Exception e) {
            return null;
        } finally {
            if (!Objects.isNull(c)) {
                c.close();
            }
        }
    }

    static <T> List<T> resultSetToObjects(ResultSet rs, Class<T> clazz) throws SQLException, Exception {
        List<T> objects = new ArrayList<>();

        try {
            ResultSetMetaData metaData = rs.getMetaData();
            Field[] fields = clazz.getDeclaredFields();

            while (rs.next()) {
                T object = clazz.getDeclaredConstructor().newInstance();

                for (int i = 1; i <= metaData.getColumnCount(); i++) {
                    String columnName = metaData.getColumnName(i);

                    for (Field field : fields) {

                        if (field.getName().equalsIgnoreCase(columnName)) {

                            field.setAccessible(true);
                            field.set(object, rs.getObject(i, field.getType()));
                            break;
                        }
                    }
                }
                objects.add(object);
            }
        } catch (Exception e) {
            throw e;
        }
        return objects;
    }
}
