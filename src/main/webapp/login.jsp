<%-- 
    Document   : login
    Created on : 12 22, 17, 9:49:58 PM
    Author     : Yuta Inoue
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String msg = (String) session.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login</title>
        <!--Link href-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons">
        <!-- Bootstrap core CSS -->
        <link href="/Profsmato/assets/css/bootstrap-material-design.css" rel="stylesheet">
        <!-- Phantom Five Custom CSS. PUT THIS AFTER THE LINK HREF TO bootstrap-material-design.css -->
        <link href="/Profsmato/assets/css/Fixes_and_Additional_Classes.css" rel="stylesheet">
        
        <!--Script Imports-->
        <script src="/Profsmato/assets/js/jquery-3.2.1.min.js"></script>
        <script src="https://unpkg.com/popper.js@1.12.5/dist/umd/popper.js" integrity="sha384-KlVcf2tswD0JOTQnzU4uwqXcbAy57PvV48YUiLjqpk/MJ2wExQhg9tuozn5A1iVw" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/bootstrap-material-design@4.0.0-beta.3/dist/js/bootstrap-material-design.js" integrity="sha384-hC7RwS0Uz+TOt6rNG8GX0xYCJ2EydZt1HeElNwQqW+3udRol4XwyBfISrNDgQcGA" crossorigin="anonymous"></script>
        
        <!--Stlye-->
        <style>
            body {
                background: url("/Profsmato/assets/designs/loginwallpaper.jpg");
            }

            #logincard {
                background: rgba(76, 175, 80, 0.95)!important;
                margin: auto;
                margin-top: 0%;
            }

            #logincardfooter {
                background: rgba(0, 130, 0, 0.0);
                margin: auto;
            }

            /*! Fixes the dark grey color of placeholder text in input boxes  */
            .form-control::placeholder {
                color: white;
                opacity: 1
            }

            input::-webkit-input-placeholder {
                color: white;
            }

            ::-webkit-input-placeholder {
                color: white;
            }

            ::-moz-placeholder {
                color: white;
            }

            ::-ms-placeholder {
                color: white;
            }

            ::placeholder {
                color: white;
            }

        </style>
    </head>
    <body>
        <div class="py-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="card text-white p-5 bg-success" id="logincard">
                            <img src="/Profsmato/assets/designs/logobanner.png" style="width:100%;" />
                            <div class="card-body">
                                <% if(msg != null){ %>
                                <h2><%= msg %></h2>
                                <% } %>
                                <form action="Login" method="post">
                                    <div class="form-group">
                                        <label class="text-white">Email address</label>
                                        <input type="email" class="form-control text-white" name="email">
                                    </div>
                                    <div class="form-group">
                                        <label class="text-white">Password</label>
                                        <input type="password" class="form-control text-white" name="pw">
                                    </div>
                                    <input type="submit" class="btn btn-md btn-secondary btn-raised" value="LOGIN" /><br /><br />
                                    <a href="SignUp" class="btn btn-md btn-secondary btn-raised">SIGN UP</a>
                                </form>
                                <!--card-body-->
                                <div class="card-footer" id="logincardfooter" style="text-align:center;">Profsmato is brought to you by Phantom Five Dev Team, ©2017.</div>
                            </div><!--/.card-body-->
                        </div><!--/#logincard-->
                    </div><!--/.col-md-6-->
                </div><!--/.row-->
            </div><!--/.container-->
        </div><!--/.py5-->
    </body>
    <script>
        $(document).ready(function(){
           $('body').bootstrapMaterialDesign(); 
        });
    </script>
</html>
