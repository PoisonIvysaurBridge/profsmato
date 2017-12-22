/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import java.beans.PropertyVetoException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author inoue
 */
public class DataSource {
    
    private static DataSource dataSource;
    private ComboPooledDataSource cpds;
    
    // JDBC Driver Name & Database URL
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String JDBC_DB_URL = "jdbc:mysql://localhost:3306/profsmato";

    // JDBC Database Credentials
    private static final String JDBC_USER = "";
    private static final String JDBC_PASS = "";
    
    private DataSource() 
            throws IOException, SQLException, PropertyVetoException{
        this.cpds = new ComboPooledDataSource();
        cpds.setDriverClass(JDBC_DRIVER);
        cpds.setJdbcUrl(JDBC_DB_URL);
        cpds.setUser(JDBC_USER);
        cpds.setPassword(JDBC_PASS);
        
        cpds.setMinPoolSize(5);
        cpds.setAcquireIncrement(5);
        cpds.setMaxPoolSize(20);
        cpds.setMaxStatements(180);
    }
    
    public static DataSource getInstance() 
            throws IOException, SQLException, PropertyVetoException{
        if(dataSource == null){
            dataSource = new DataSource();
        }
        return dataSource;
    }
    
    public Connection getConnection() throws SQLException, SQLException {
        return this.cpds.getConnection();
    }
    
}
