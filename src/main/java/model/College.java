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
 * Represents College Object.
 * @author Yuta Inoue
 */
public class College {
    
    /**
     * This college's abbreviated name.<br />
     * The <i>Primary Key</i> for College.<br />
     * Column name <i>COLLEGEID</i>.
     */
    private String collegeId;
    
    /**
     * This college's official name.<br />
     * Column name <i>COLLEGENAME</i>.
     */
    private String collegeName;
    
    /**
     * This college's assigned departments.
     */
    private ArrayList<Department> departments;
    
    
    /**
     * Empty Constructor.
     */
    public College(){}
    
    /**
     * Constructor will call a method to retrieve Data from Database.
     * Instantiates the departments ArrayList as well.
     * @param collegeId the targeted college
     */
    public College(String collegeId){
        this.departments = new ArrayList<>();
        this.retrieveCollege(collegeId);
    }
    
    // <editor-fold defaultstate="collapsed" desc="College Methods">
    /**
     * Gets this college's College ID.
     * @return this college's college id
     */
    public String getCollegeId() {return collegeId;}
    
    /**
     * Sets this college's College ID.
     * @param collegeId the college id that will be set
     */
    public void setCollegeId(String collegeId) {this.collegeId = collegeId;}
    
    /**
     * Gets this college's name.
     * @return this college's name
     */
    public String getCollegeName() {return collegeName;}
    
    /**
     * Sets this college's name.
     * @param collegeName the college name that will be set.
     */
    public void setCollegeName(String collegeName) {this.collegeName = collegeName;}
    
    /**
     * Gets this college's departments.
     * @return the college's departments in arraylist
     */
    public ArrayList<Department> getDepartments() {return departments;}
    
    /**
     * Sets this college's departments.
     * @param departments the departments that will be set
     */
    public void setDepartments(ArrayList<Department> departments) {this.departments = departments;}
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="Data Access Object methods">
    /**
     * Retrieves Data from database.<br />
     * Does the Exception Handling for the Connection, PreparedStatment & ResultSet
     * @param collegeId targeted college
     */
    private void retrieveCollege(String collegeId){
        Connection conn = null;
        PreparedStatement pStmt = null;
        ResultSet rs = null;
        String sql = "SELECT        COLLEGEID, COLLEGENAME "
                + "   FROM          COLLEGES "
                + "   WHERE         COLLEGEID = ?";
        try {
            conn = DataSource.getInstance().getConnection();
            pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, collegeId);
            rs = pStmt.executeQuery();
            
            while(rs.next()){
                this.collegeId = rs.getString("COLLEGEID");
                this.collegeName = rs.getString("COLLEGENAME");
            }
            
            pStmt = conn.prepareStatement("SELECT DEPARTMENTID FROM DEPARTMENTS WHERE ATTACHEDCOLLEGE = ?");
            pStmt.setString(1, this.collegeId);
            rs = pStmt.executeQuery();
            
            while(rs.next()){
                String departmentId = rs.getString("DEPARTMENTID");
                this.departments.add(new Department(departmentId, conn, pStmt, rs));
            }
            
        } catch (IOException | SQLException | PropertyVetoException ex) {
            ex.printStackTrace();
        } finally{
            if(conn != null)
                try{ conn.close(); }catch(SQLException e){ e.printStackTrace(); }
            if(pStmt != null)
                try{ pStmt.close(); }catch(SQLException e){ e.printStackTrace(); }
            if(rs != null)
                try{ rs.close(); }catch(SQLException e){ e.printStackTrace(); }
        }
    }
    // </editor-fold>
    
}
