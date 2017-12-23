/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

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
    
}
