/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Yuta Inoue
 */
public class Professor {
    
    // <editor-fold defaultstate="collapsed" desc="Static fields of Professor object.">
    /**
     * The String equivalent for Active status.
     */
    public static final String STATUS1 = "active";
    /**
     * The String equivalent for Pending status.
     */
    public static final String STATUS2 = "pending";
    /**
     * The String equivalent for Inactive status.
     */
    public static final String STATUS3 = "inactive";
    
    /**
     * The int equivalent for Active status.
     */
    public static final int ACTIVE = 1;
    /**
     * The int equivalent for Pending status.
     */
    public static final int PENDING = 2;
    /**
     * The int equivalent for Inactive status.
     */
    public static final int INACTIVE = 3;
    // </editor-fold>
    
    // <editor-fold desc="Professor Attributes">
    /**
     * The <i>Primary Key</i> of Professor.<br />
     * Column name <i>PROFEMAIL</i>.
     */
    private String  profEmail;
    
    /**
     * The <strong>Last Name</strong> of Professor.<br />
     * Column name <i>LASTNAME</i>.
     */
    private String  lastname;
    
    /**
     * The <strong>First Name</strong> of Professor.<br />
     * Column nmae <i>FIRSTNAME</i>.
     */
    private String  firstname;
    
    /**
     * The <strong>Description</strong> of Professor.<br />
     * Column name <i>ABOUT</i>.
     */
    private String  about;
    
    /**
     * The <strong>Profile Picture's Path</strong> of Professor.<br />
     * Column name <i>PROFPIC</i>.
     */
    private String  profPicture;
    
    /**
     * The <strong>Status</strong> of Professor.<br />
     * Column name <i>STATUS</i>.
     */
    private int     status;
    // </editor-fold>
    
    /**
     * Empty Constructor.
     */
    public Professor(){}
    
    // <editor-fold desc="Professor Methods">
    /**
     * Gets the Professor's DLSU email.
     * @return this professor's email
     */
    public String getProfEmail() {return profEmail;}
    
    /**
     * Sets the Professor's DLSU email.
     * @param profEmail the dlsu email that will be set
     */
    public void setProfEmail(String profEmail) {this.profEmail = profEmail;}
    
    /**
     * Gets the Last Name of the Professor.
     * @return this professor's last name
     */
    public String getLastname() {return lastname;}

    /**
     * Sets the Last Name of the Professor.
     * @param lastname the lastname that will be set
     */
    public void setLastname(String lastname) {this.lastname = lastname;}

    /**
     * Gets the First Name of the Professor.
     * @return this professor's firstname
     */
    public String getFirstname() {return firstname;}

    /**
     * Sets the First Name of the Professor.
     * @param firstname the firstname that will be set
     */
    public void setFirstname(String firstname) {this.firstname = firstname;}

    /**
     * Gets the Full Name of the Professor.
     * @return firstname + " " + lastname
     */
    public String getFullName(){return firstname + " " + lastname;}
    
    /**
     * Gets the Description of the Professor.
     * @return this professor's description
     */
    public String getAbout() {return about;}

    /**
     * Sets the description of the Professor.
     * @param about the description that will be set
     */
    public void setAbout(String about) {this.about = about;}

    /**
     * Gets the Picture Path of the Professor.
     * @return this professor's picture path.
     */
    public String getProfPicture() {return profPicture;}

    /**
     * Sets the Picture Path of the Professor.
     * @param profPicture the picture path that will be set.
     */
    public void setProfPicture(String profPicture) {this.profPicture = profPicture;}
    
    /**
     * Gets the Status in a String.
     * @return this professor's status
     */
    public String getStatusString(){
        String statusString = "";
        switch(this.status){
            case ACTIVE:
                statusString = Professor.STATUS1;
                break;
            case INACTIVE:
                statusString = Professor.STATUS3;
                break;
            case PENDING:
                statusString = Professor.STATUS2;
                break;
        }
        return statusString;
    }
    
    /**
     * Sets the Status depending on the event.
     * @param event the event that will occur to a professor
     */
    public void statusManager(String event){
        switch(event){
            case "Request":
                this.status = PENDING;
                break;
            case "Accept":
                this.status = ACTIVE;
                break;
            case "Reject":
                this.status = INACTIVE;
                break;
        }
    }
    
    // </editor-fold>
    
}
