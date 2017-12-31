<%@page import="model.Student"%>
<%
Student loginUser = (Student) session.getAttribute("loginUser");
%>
<form action="Logout" method="post" id="logoutForm"></form>
<nav class="navbar navbar-expand-md bg-success navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">Profsmato</a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Management</a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="#">Homepage</a>
                        <a class="dropdown-item" href="#">Users</a>
                        <a class="dropdown-item" href="#">Professors</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Complaints</a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="#">Reported Reviews</a>
                        <a class="dropdown-item" href="#">Reported Users</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Requests</a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="#">Registration</a>
                        <a class="dropdown-item" href="#">Professors</a>
                    </div>
                </li>
            </ul><!--/.navbar-nav-->
            <ul class="navbar-nav navbar-right">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" aria-expanded="false" aria-haspopup="true" data-toggle="dropdown" id="Preview" role="button"> Administrator  </a>
                    <div class="dropdown-menu" aria-labelledby="Preview">
                        <div style="text-align:center;">
                            <img class="rounded-circle" src="/Profsmato/assets/studentpic/andrew.jpg" alt="Generic placeholder image" style="width:64px;">
                            <br /> 
                            <text><%= loginUser.getFirstname()%></text>
                            <hr /> 
                        </div>
                        <a class="dropdown-item" href="#">Profile</a>
                        <button class="dropdown-item" onclick="logout()">Logout</button>
                    </div>
                </li>
            </ul><!--/.navbar-nav-->
        </div><!--/.collapse navbar-collapse-->
    </div><!--/.container-->
</nav>
<script>
    function logout(){
        $('#logoutForm').submit();
    }
</script>