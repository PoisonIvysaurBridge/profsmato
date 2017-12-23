/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

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
    private College(){}
    
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
    
}
