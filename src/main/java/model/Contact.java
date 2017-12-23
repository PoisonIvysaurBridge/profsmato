/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 * Represents the Contact of the Student.
 * @author Yuta Inoue
 */
public class Contact {
    
    // <editor-fold defaultstate="collapsed" desc="Static Fields">
    /**
     * Contact Type 1 is Facebook.
     */
    public static String CONTACT_TYPE1 = "facebook";
    
    /**
     * Contact Type 2 is YouTube.
     */
    public static String CONTACT_TYPE2 = "youtube";
    
    /**
     * Contact Type 3 is Twitter.
     */
    public static String CONTACT_TYPE3 = "twitter";
    
    /**
     * Contact Type 4 is Instagram.
     */
    public static String CONTACT_TYPE4 = "instagram";
    // </editor-fold>
    
    // <editor-fold desc="Contact Attributes">    
    /**
     * The <strong>Contact Details</strong> of the Contact.<br />
     * Must be <strong>UNIQUE</strong> from the other Contacts.<br />
     * Column name <i>CONTACTDETAIL</i>.
     */
    private String contactDetail;
    
    /**
     * The <strong>Person Type</strong> of the Contact.<br />
     * Can only be <i>student</i> or <i>prof</i>.<br />
     * Column name <i>PERSONTYPE</i>.
     */
    private String personType;
    
    /**
     * The <strong>Type of Social Media contact</strong> of the Contact.<br />
     * Column name <i>CONTACTTYPE</i>.
     */
    private int contactType;
    // </editor-fold>
    
    /**
     * Empty Constructor.
     */
    public Contact(){}
    
    // <editor-fold defaultstate="collapsed" desc="Contact Methods">
    /**
     * Gets the Contact Detail.
     * @return this contact's contact detail
     */
    public String getContactDetail() {return contactDetail;}

    /**
     * Sets the Contact Detail.
     * @param contactDetail the contact detail that will be set
     */
    public void setContactDetail(String contactDetail) {this.contactDetail = contactDetail;}

    /**
     * Gets the Person Type.
     * @return this contact's person type
     */
    public String getPersonType() {return personType;}

    /**
     * Sets the Person Type
     * @param personType the person type that will be set
     */
    public void setPersonType(String personType) {this.personType = personType;}

    /**
     * Gets the Contact Type in a String.
     * @return this contact's contact type
     */
    public String getContactTypeString(){
        String contactTypeString = "";
        switch (this.contactType){
            case 1:
                contactTypeString = CONTACT_TYPE1;
                break;
            case 2:
                contactTypeString = CONTACT_TYPE2;
                break;
            case 3:
                contactTypeString = CONTACT_TYPE3;
                break;
            case 4:
                contactTypeString = CONTACT_TYPE4;
                break;
        }
        return contactTypeString;
    }

    /**
     * Sets the Contact Type.
     * @param contactType the contact type that will be set
     */
    public void setContactType(int contactType) {this.contactType = contactType;}
    // </editor-fold>
    
}
