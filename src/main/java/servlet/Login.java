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
import javax.servlet.http.HttpSession;
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
        HttpSession session = request.getSession();
        Student loginUser = (Student) session.getAttribute("loginUser");
        if(loginUser != null){
            if(loginUser.getUserType().equals("admin")){
                response.sendRedirect("AdminMain");
            }else if(loginUser.getUserType().equals("student")){
                response.sendRedirect("StudentMain");
            }
        }else{
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
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
        Student loginUser = this.loginUser(email, password);
        if(loginUser != null){
            if(loginUser.getStatusString().equals(Student.PENDING)){
                request.getSession().setAttribute("msg", "Your account is still pending for acceptance. Please try again later.");
                response.sendRedirect("Login");
            }else{
                request.getSession().setAttribute("loginUser", loginUser);
                if(loginUser.getUserType().equals("admin")){
                    response.sendRedirect("AdminMain");
                }else if(loginUser.getUserType().equals("student")){
                    response.sendRedirect("StudentMain");
                }
            }
        }else{
            request.getSession().setAttribute("msg", "Email or Password is wrong. Please try again.");
            response.sendRedirect("Login");
        }
    }
    
    private Student loginUser(String email, String password){
        Student loginUser = null;
        Connection conn = null;
        PreparedStatement pStmt = null;
        ResultSet rs = null;
        String sql = "SELECT		STUDENTEMAIL, USERNAME, LASTNAME, FIRSTNAME, PROGRAM, STATUS, ABOUT, PROFILEPIC, USERTYPE "
                   + "FROM		STUDENTS "
                   + "WHERE		STUDENTEMAIL = ? AND PASSWORD = ?;";
        
        try{
            conn = DataSource.getInstance().getConnection();
            pStmt = conn.prepareStatement(sql);
            pStmt.setString(1, email);
            pStmt.setString(2, password);
            rs = pStmt.executeQuery();
            
            if(rs.next()){
                String studentEmail = rs.getString("STUDENTEMAIL");
                String username = rs.getString("USERNAME");
                String lastname = rs.getString("LASTNAME");
                String firstname = rs.getString("FIRSTNAME");
                String programName = rs.getString("PROGRAM");
                int status = rs.getInt("STATUS");
                String about = rs.getString("ABOUT");
                String profilePic = rs.getString("PROFILEPIC");
                String userType = rs.getString("USERTYPE");
                loginUser = new Student(studentEmail, username, lastname, firstname, programName, status, about, profilePic, userType, conn, pStmt, rs);
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
