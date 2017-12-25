/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main;

import model.Department;

/**
 *
 * @author inoue
 */
public class DepartmentTest {
    public static void main(String[] args) {
        departmentInstantiationTest("IT");
    }
    
    public static void departmentInstantiationTest(String departmentId){
        Department d = new  Department(departmentId);
        System.out.println("Department ID: " + d.getDepartmentId());
        System.out.println("Department Name: " + d.getDepartmentName());
    }
}
