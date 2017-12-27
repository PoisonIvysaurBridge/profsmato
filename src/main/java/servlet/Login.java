/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import dao.DataSource;
import java.beans.PropertyVetoException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Student;

/**
 *
 * @author inoue
 */
public class Login extends HttpServlet {
    
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("pw");
    }
    
    private Student loginStudent(String email, String password){
        Student loginUser = null;
        Connection conn = null;
        PreparedStatement pStmt = null;
        ResultSet rs = null;
        String sql = "SELECT		STUDENTEMAIL, USERNAME, PASSWORD, LASTNAME, FIRSTNAME, PROGRAM, STATUS, ABOUT, PROFILEPIC, USERTYPE "
                   + "FROM		STUDENTS "
                   + "WHERE		STUDENTEMAIL = ? AND PASSWORD = ?;";
        
        try{
            conn = DataSource.getInstance().getConnection();
            pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, email);
            pStmt.setString(2, password);
            rs = pStmt.executeQuery();
            
            if(rs.next()){
                
            }else{
                loginUser = null;
            }
            
        } catch (IOException | SQLException | PropertyVetoException ex) {
            ex.printStackTrace();
        } finally {
            if(conn != null)
                try{ conn.close(); } catch(SQLException e){}
            if(pStmt != null)
                try{ pStmt.close(); } catch(SQLException e){}
            if(rs != null)
                try{ rs.close(); } catch(SQLException e){}
        }
        
        return loginUser;
    }

}
