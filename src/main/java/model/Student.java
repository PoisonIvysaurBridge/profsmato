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
import java.util.ArrayList;

/**
 * Represents a Student object.
 * @author Yuta Inoue
 */
public class Student {
    
    // <editor-fold defaultstate="collapsed" desc="Static fields of Student object.">
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
    
    // <editor-fold desc="Basic Student's attributes">
    /**
     * The <strong>Primary Key</strong> for the Student.<br />
     * Should always end @dlsu.edu.ph<br />
     * Column name <i>STUDENTEMAIL</i>.
     */
    private String  studentEmail;
    
    /**
     * The <strong>Username</strong> for the Student.<br />
     * Every Student should have a unique username.<br />
     * Column name <i>USERNAME</i>
     */
    private String  username;
    
    /**
     * The <strong>Password</strong> for the Student.<br />
     * Encrypted by the database.<br />
     * Do not store password here unless necessary!!!
     * Column name <i>PASSWORD</i>.
     */
    private String  password;
    
    /**
     * The <strong>Last Name</strong> for the Student.<br />
     * Column name <i>LASTNAME</i>.
     */
    private String  lastname;
    
    /**
     * The <strong>First Name</strong> for the Student.<br />
     * Column name <i>FIRSTNAME</i>.
     */
    private String  firstname;
    
    /**
     * The <strong>Program</strong> that a student is enrolled into.<br />
     * Referenced from the <i>DEGREE</i> table as a VARCHAR(10).<br />
     * Column name <i>PROGRAM</i>.
     */
    private Degree  program;
    
    /**
     * The <strong>Status</strong> of the student.<br />
     * Referenced from the <i>REF_STATUS</i> table as a INT(2).
     * Column name <i>STATUS</i>.
     */
    private int     status;
    
    /**
     * The <strong>Description</strong> of the student.<br />
     * Column name <i>ABOUT</i>.
     */
    private String  about;
    
    /**
     * The <strong>Profile Picture Path</strong> of the student.<br />
     * Column name <i>PROFILEPIC</i>.
     */
    private String  profilePicture;
    
    /**
     * The <strong>User Type</strong> of the student.<br />
     * Column name <i>USERTYPE</i>.
     */
    private String  userType;
    
    /**
     * The available <strong>Social Media contacts</strong> for this Student.
     */
    private ArrayList<Contact> contacts;
    
    // </editor-fold>
    
    // <editor-fold desc="Constructors">
    /**
     * Empty constructor for the Student class.
     */
    public Student(){}
    
    /**
     * Constructor's purpose is for the retrieving of the Database.
     * Note: NOT FOR LOGIN PURPOSE
     * @param studentEmail This Student's email address.
     * @param conn continued connection
     * @param pStmt continued prepared statement
     * @param rs continued result set
     * @throws SQLException sql exception done at the servlet
     */
    public Student(String studentEmail, Connection conn, 
            PreparedStatement pStmt, ResultSet rs) throws SQLException{
        this.contacts = new ArrayList<>();
        this.retrieveStudent(studentEmail, conn, pStmt, rs);
    }

    /**
     * Constructor for LOGING IN.
     * @param studentEmail retrieved email
     * @param username retrieved username
     * @param lastname retrieved lastname
     * @param firstname retrieved firstname
     * @param program retrieved program in string
     * @param status retrieved status
     * @param about retrieved about
     * @param profilePicture retrieved profile picture
     * @param userType retrieved user type
     * @param conn continued connection
     * @param pStmt continued prepared statement
     * @param rs continued result set
     * @throws SQLException thrown by SQL.
     */
    public Student(String studentEmail, String username, String lastname, String firstname, 
            String program, int status, String about, String profilePicture, String userType,
            Connection conn, PreparedStatement pStmt, ResultSet rs) throws SQLException {
        this.studentEmail = studentEmail;
        this.username = username;
        this.lastname = lastname;
        this.firstname = firstname;
        this.program = new Degree(program, conn, pStmt, rs);
        this.status = status;
        this.about = about;
        this.profilePicture = profilePicture;
        this.userType = userType;
    }
    
    
    // </editor-fold>
    
    // <editor-fold defaultstate="collapsed" desc="Methods of Student object.">
    /**
     * Gets the student's dlsu email address.
     * @return this student's dlsu email address
     */
    public String   getStudentEmail() {return studentEmail;}
    
    /**
     * Sets the student's dlsu email address.
     * @param studentEmail a dlsu email address that is going to be set
     */
    public void     setStudentEmail(String studentEmail) {this.studentEmail = studentEmail;}
    
    /**
     * Gets the student's username.
     * @return this student's username
     */
    public String   getUsername() {return username;}
    
    /**
     * Sets the student's username.
     * @param username a username that is going to be set
     */
    public void     setUsername(String username) {this.username = username;}
    
    /**
     * Gets the student's hashed password.
     * @return this student's hashed password
     */
    public String   getPassword() {return password;}
    
    /**
     * Sets the student's password.
     * @param password a password that is going to be set
     */
    public void     setPassword(String password) {this.password = password;}
    
    /**
     * Gets the student's Last name.
     * @return this student's lastname
     */
    public String   getLastname() {return lastname;}
    
    /**
     * Sets the student's Last name.
     * @param lastname a lastname that is going to be set
     */
    public void     setLastname(String lastname) {this.lastname = lastname;}
    
    /**
     * Gets the First name of the student.
     * @return this student's lastname
     */
    public String   getFirstname() {return firstname;}
    
    /**
     * Sets the First name of the student.
     * @param firstname a firstname that will be set
     */
    public void     setFirstname(String firstname) {this.firstname = firstname;}
    
    /**
     * Gets the student's enrolled program.
     * @return this student's enrolled program - Degree Object
     */
    public Degree   getProgram(){return program;}
    
    /**
     * Sets the student's enrolled program.
     * @param program a Degree object that will be set
     */
    public void     setProgram(Degree program){this.program = program;}
    
    /**
     * Sets this Student's status depending on the Event that will occur.
     * @param action the event that happens to this Student
     */
    public void     statusManager(String action){
        switch(action){
            case "SignUp":
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
    
    /**
     * Gets this Student's status.
     * @return this student's status in String
     */
    public String   getStatusString(){
        String statusString = "";
        switch(this.status){
            case ACTIVE:
                statusString = STATUS1;
                break;
            case INACTIVE:
                statusString = STATUS3;
                break;
            case PENDING:
                statusString = STATUS2;
                break;
        }
        return statusString;
    }

    /**
     * Gets the student's description.
     * @return this student's description
     */
    public String   getAbout() {return about;}
    
    /**
     * Sets the student's description.
     * @param about the description that will be set
     */
    public void     setAbout(String about) {this.about = about;}
    
    /**
     * Gets the student's profile picture path.
     * @return this student's profile picture path
     */
    public String   getProfilePicture() {return profilePicture;}
    
    /**
     * Sets the student's profile picture path.
     * @param profilePicture the new profile picture path that will be set
     */
    public void     setProfilePicture(String profilePicture) {this.profilePicture = profilePicture;}
    
    /**
     * Gets this student's user type.
     * @return the usertype of this student
     */
    public String   getUserType() {return userType;}
    
    /**
     * Sets the student's user type.
     * @param userType the user type that will be set.
     */
    public void     setUserType(String userType) {this.userType = userType;}
    
    /**
     * Gets this student's contact lists.
     * @return this student's contacts in an ArrayList object
     */
    public ArrayList<Contact> getContacts(){return contacts;}
    
    /**
     * Sets the new contact list.
     * @param contacts the contact arraylist to be set
     */
    public void     setContacts(ArrayList<Contact> contacts){this.contacts = contacts;}
    
    // </editor-fold>
    
    // <editor-fold desc="Data Access Object methods">
    /**
     * Simply retrieving the Student from the database
     * @param studentEmail the targeted Student's email
     * @param conn the continued connection
     * @param pStmt the continued prepared statement
     * @param rs the continued result set
     * @throws SQLException thrown for the sql handling
     */
    private void retrieveStudent(String studentEmail, Connection conn, 
            PreparedStatement pStmt, ResultSet rs) throws SQLException{
        String sql = "SELECT		STUDENTEMAIL, USERNAME, LASTNAME, FIRSTNAME, PROGRAM, STATUS, ABOUT, PROFILEPIC, USERTYPE " + 
                     "FROM		STUDENTS " +
                     "WHERE		STUDENTEMAIL = ?;";
        pStmt = conn.prepareStatement(sql);
        pStmt.setString(1, studentEmail);
        rs = pStmt.executeQuery();
        while(rs.next()){
            this.studentEmail = rs.getString("STUDENTEMAIL");
            this.username = rs.getString("USERNAME");
            this.lastname = rs.getString("LASTNAME");
            this.firstname = rs.getString("FIRSTNAME");
            this.program = new Degree(rs.getString("PROGRAM"), conn, pStmt, rs);
            this.status = rs.getInt("STATUS");
            this.profilePicture = rs.getString("PROFILEPIC");
            this.userType = rs.getString("USERTYPE");
        }
    }
    
    // </editor-fold>
}
