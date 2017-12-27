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
import model.Student;

/**
 *
 * @author inoue
 */
public class StudentTest {
    public static void main(String[] args) {
        studentInstantiationTest();
    }
    
    public static void studentInstantiationTest(){
        Connection conn = null;
        PreparedStatement pStmt = null;
        ResultSet rs = null;
        Student student = null;
        try{
            conn = DataSource.getInstance().getConnection();
            student = new Student("yuta_inoue@dlsu.edu.ph", conn, pStmt, rs);
        } catch (IOException | SQLException | PropertyVetoException ex) {
            ex.printStackTrace();
        }finally{
            if(conn != null)
                try{ conn.close(); }catch(SQLException e){}
            if(pStmt != null)
                try{ pStmt.close(); }catch(SQLException e){}
            if(rs != null)
                try{ rs.close(); }catch(SQLException e){}
        }
        
        System.out.println("Email: " + student.getStudentEmail());
        System.out.println("Username: " + student.getUsername());
        System.out.println("Firstname: " + student.getFirstname());
        System.out.println("Lastname: " + student.getLastname());
        System.out.println("User Type: " + student.getUserType());
        System.out.println("Degree: " + student.getProgram().getDegreeCode());
        System.out.println("Degree Name: " + student.getProgram().getProgramName());
        System.out.println("Attached College: " + student.getProgram().getAttachedCollege());
        
    }
}
