/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import model.Professor;

/**
 *
 * @author inoue
 */
public class ProfessorTest {
    public static void main(String[] args) {
        System.out.println("START");
        
        instantiationTest("aaron_escartin@dlsu.edu.ph");
        
        System.out.println("END");
    }
    
    public static void instantiationTest(String profEmail){
        Professor p = new Professor(profEmail);
        
        System.out.println("Email: " + p.getProfEmail());
        System.out.println("Full Name: " + p.getFullName());
        System.out.println("About: " + p.getAbout());
        System.out.println("Profile Picture: " + p.getProfPicture());
        System.out.println("Status: " + p.getStatusString());
    }
}
