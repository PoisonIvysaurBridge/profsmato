/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import dao.DataSource;
import java.beans.PropertyVetoException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Represents the Department Object
 * @author Yuta Inoue
 */
public class Department {
    
    /**
     * The Department's <strong>Primary Key</strong>.<br />
     * Column name <i>DEPARTMENTID</i>.
     */
    private String departmentId;
    
    /**
     * The Department's Name.<br />
     * Column name <i>DEPARTMENTNAME</i>.
     */
    private String departmentName;
    
    /**
     * The Department's assigned professors.<br />
     */
    private ArrayList<Professor> professors;
    
    /**
     * Empty Constructor.
     */
    public Department(){}
    
    /**
     * Instantiates Department Object through constructor
     * @param departmentId targeted department
     * @deprecated use the constructor with Connection Object
     */
    public Department(String departmentId){
        this.retrieveDepartment(departmentId);
    }
    
    /**
     * Constructor for retrieving the department from Database and is called from the College Object.
     * Professors ArrayList instantiated as well.
     * @param departmentId targeted department
     * @param conn continue the connection object
     * @param pStmt continue the prepared statement
     * @param rs continue the result set
     * @throws SQLException thrown by Connection object
     */
    public Department(String departmentId, Connection conn, 
            PreparedStatement pStmt, ResultSet rs) throws SQLException{
        this.professors = new ArrayList<>();
        this.retrieveDepartmentV2(departmentId, conn, pStmt, rs);
    }

    // <editor-fold defaultstate="collapsed" desc="Department Methods">
    /**
     * Gets this Department's department ID.
     * @return this department id
     */
    public String getDepartmentId() {return departmentId;}

    /**
     * Sets this Department's department ID.
     * @param departmentId the department id that will be set
     */
    public void setDepartmentId(String departmentId) {this.departmentId = departmentId;}

    /**
     * Gets this Department's name.
     * @return this department's name
     */
    public String getDepartmentName() {return departmentName;}

    /**
     * Sets this Department's name.
     * @param departmentName the department name that will be set
     */
    public void setDepartmentName(String departmentName) {this.departmentName = departmentName;}

    /**
     * Gets this Department's Professors.
     * @return the professors assigned to this department in arraylist
     */
    public ArrayList<Professor> getProfessors() {return professors;}

    /**
     * Sets this Department's Professors
     * @param professors the professors that will be assigned to this department
     */
    public void setProfessors(ArrayList<Professor> professors) {this.professors = professors;}
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="Data Access Object methods">
    /**
     * Retrieves the data from Database.
     * @param departmentId the targeted department
     * @deprecated connection object must be passed through parameter
     */
    private void retrieveDepartment(String departmentId){
        Connection conn = null;
        PreparedStatement pStmt = null;
        ResultSet rs = null;
        String sql = "SELECT        DEPARTMENTID, DEPARTMENTNAME "
                + "   FROM          DEPARTMENTS "
                + "   WHERE         DEPARTMENTID = ?";
        try{
            conn = DataSource.getInstance().getConnection();
            pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, departmentId);
            rs = pStmt.executeQuery();
            while(rs.next()){
                this.departmentId = rs.getString("DEPARTMENTID");
                this.departmentName = rs.getString("DEPARTMENTNAME");
            }
        } catch (IOException | SQLException | PropertyVetoException ex) {
            ex.printStackTrace();
        } finally {
            if(conn != null)
                try{ conn.close(); }catch(SQLException e){}
            if(pStmt != null)
                try{ pStmt.close(); }catch(SQLException e){}
            if(rs != null)
                try{ rs.close(); }catch(SQLException e){}
        }
    }
    
    /**
     * Retrieves the data from Database.<br />
     * Being called by the department constructor.
     * @param departmentId targeted department
     * @param conn continued connection object
     * @param pStmt continued prepared statement object
     * @param rs continued result set object
     * @throws SQLException handled by the College.retrieveCollege
     */
    private void retrieveDepartmentV2(String departmentId, Connection conn, 
            PreparedStatement pStmt, ResultSet rs) throws SQLException {
        String sql = "SELECT        DEPARTMENTID, DEPARTMENTNAME "
                + "   FROM          DEPARTMENTS "
                + "   WHERE         DEPARTMENTID = ?";
        pStmt = conn.prepareStatement(sql);
        pStmt.setString(1, departmentId);
        rs = pStmt.executeQuery();
        while (rs.next()) {
            this.departmentId = rs.getString("DEPARTMENTID");
            this.departmentName = rs.getString("DEPARTMENTNAME");
        }
        
        pStmt = conn.prepareStatement("SELECT PROFEMAIL FROM PROFESSORS WHERE DEPARTMENT = ?;");
        pStmt.setString(1, this.departmentId);
        rs = pStmt.executeQuery();
        while(rs.next()){
            String profEmail = rs.getString("PROFEMAIL");
            this.professors.add(new Professor(profEmail, conn, pStmt, rs));
        }
    }
    // </editor-fold>
}
