/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Represents the Degree object.
 * @author inoue
 */
public class Degree {
    
    // <editor-fold desc="Degree Attribute">
    /**
     * This Object's <strong><i>Primary Key</i>, Degree Code</strong>.<br />
     * Column name <i>DEGREECODE</i>.
     */
    private String degreeCode;
    
    /**
     * This Object's <strong>Degree name</strong>.<br />
     * Column name <i>PROGRAMNAME</i>.
     */
    private String programName;
    
    /**
     * The Degree's <strong>Attached College</strong>.<br />
     * Should be full name of the College.<br />
     */
    private String attachedCollege;
    // </editor-fold>
    
    // <editor-fold desc="Degree Constructor">
    /**
     * Empty Constructor.
     */
    public Degree(){}
    
    /**
     * Retrieve the Degree data in the Database through Degree Code.
     * @param degreeCode the targeted degree
     * @param conn continued connection
     * @param pStmt continued prepared statement
     * @param rs continued result set
     * @throws java.sql.SQLException thrown by retrieveDegree method, caught by the servlet
     */
    public Degree(String degreeCode, Connection conn, 
            PreparedStatement pStmt, ResultSet rs) throws SQLException{
        this.retrieveDegree(degreeCode, conn, pStmt, rs);
    }
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="Degree Methods">
    /**
     * Gets this object's Degree Code.
     * @return this degree's code
     */
    public String getDegreeCode() {return degreeCode;}

    /**
     * Sets the Object's degree code.
     * @param degreeCode the program code that will be set
     */
    public void setDegreeCode(String degreeCode) {this.degreeCode = degreeCode;}

    /**
     * Gets this object's Program name.
     * @return this degree's name
     */
    public String getProgramName() {return programName;}

    /**
     * Sets the Object's Program name.
     * @param programName the program name that will be set
     */
    public void setProgramName(String programName) {this.programName = programName;}
    
    /**
     * Gets the Object's Attached College name.
     * @return this degree's attachedCollege
     */
    public String getAttachedCollege() {
        return attachedCollege;
    }
    
    /**
     * Sets the Object's Attached College name.
     * @param attachedCollege the attachedCollege that will be set
     */
    public void setAttachedCollege(String attachedCollege) {
        this.attachedCollege = attachedCollege;
    }
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="Degree Data Access Object method">
    /**
     * Retrieves the Data from the database through the Degree Code.<br />
     * Called by this Object's constructor.
     * @param degreeCode
     * @param conn
     * @param pStmt
     * @param rs 
     * @throws SQLException thrown by the connection
     */
    private void retrieveDegree(String degreeCode, Connection conn, 
            PreparedStatement pStmt, ResultSet rs) throws SQLException{
        String sql = "SELECT		DEGREECODE, (SELECT COLLEGENAME FROM COLLEGES WHERE COLLEGEID = ATTACHEDCOLLEGE) AS ATTACHEDCOLLEGE, PROGRAMNAME "
                   + "FROM		DEGREES "
                   + "WHERE		DEGREECODE = ?;";
        pStmt = conn.prepareStatement(sql);
        pStmt.setString(1, degreeCode);
        rs = pStmt.executeQuery();
        if(rs.next()){
            this.degreeCode = rs.getString("DEGREECODE");
            this.attachedCollege = rs.getString("ATTACHEDCOLLEGE");
            this.programName = rs.getString("PROGRAMNAME");
        }
    }
    // </editor-fold>
    
}
