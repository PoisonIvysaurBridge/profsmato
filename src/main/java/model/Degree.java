/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;

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
     */
    public Degree(String degreeCode){
        this.retrieveDegree();
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
     */
    private void retrieveDegree(){
        
    }
    // </editor-fold>
    
}
