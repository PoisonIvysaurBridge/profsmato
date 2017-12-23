/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import dao.DataSource;
import java.beans.PropertyVetoException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author inoue
 */
public class ProfessorTest {
    public static void main(String[] args) {
        System.out.println("START");
        Connection conn = null;
        PreparedStatement pStmt = null;
        ResultSet rs = null;
        
        try{
            conn = DataSource.getInstance().getConnection();
            pStmt = conn.prepareStatement("SELECT * FROM PROFESSORS;");
            rs = pStmt.executeQuery();
            while(rs.next()){
                System.out.println("Email: " + rs.getString(1));
                System.out.println("\tLast Name: " + rs.getString(2));
                System.out.println("\tFirst Name: " + rs.getString(3));
                System.out.println("\tDepartment: " + rs.getString(4));
            }
        } catch (IOException | SQLException | PropertyVetoException ex) {
            ex.printStackTrace();
        }finally{
            if(conn != null)
                try{ conn.close(); }catch(SQLException e){e.printStackTrace();}
            if(pStmt != null)
                try{ pStmt.close(); }catch(SQLException e){e.printStackTrace();}
            if(rs != null)
                try{ rs.close(); }catch(SQLException e){e.printStackTrace();}
        }
        System.out.println("END");
    }
}
