/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import model.College;
import model.Department;
import model.Professor;

/**
 *
 * @author inoue
 */
public class CollegeTest {
    public static void main(String[] args) {
        collegeInstantiationTest("CCS");
    }
    
    public static void collegeInstantiationTest(String collegeId){
        College c = new College(collegeId);
        System.out.println("College ID: " + c.getCollegeId());
        System.out.println("\tCollege Name: " + c.getCollegeName());
        System.out.println("\tDepartments");
        for(Department d : c.getDepartments()){
            System.out.println("\t\tDepartment ID: " + d.getDepartmentId());
            System.out.println("\t\t\tDepartment Name: " + d.getDepartmentName());
            System.out.println("\t\t\tProfessors");
            for (Professor p : d.getProfessors()) {
                System.out.println("\t\t\t\tEmail: " + p.getProfEmail());
                System.out.println("\t\t\t\t\tFull Name: " + p.getFullName());
                System.out.println("\t\t\t\t\tAbout: " + p.getAbout());
                System.out.println("\t\t\t\t\tProfile Picture: " + p.getProfPicture());
                System.out.println("\t\t\t\t\tStatus: " + p.getStatusString());
            }
        }
    }
}
