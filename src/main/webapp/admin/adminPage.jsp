<%-- 
    Document   : adminPage
    Created on : 12 22, 17, 9:49:09 PM
    Author     : Yuta Inoue
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Profsmato</title>
        <%@include file="/commons/commonLinks.html" %>
    </head>
    <style>
        .mainContainer {
            padding-top: 3rem;
        }


        .carousel {
            background-color: black;
        }

        .carousel-item {
            text-align: center;
        }

        .carousel-item img {
            height: 400px;
        }

        .carousel-caption {
            background-color: rgba(0, 0, 0, 0.7);
            width: 100%;
            max-width: 100%;
            left: 0;
        }

        .carousel-caption h3,
        p {
            margin-left: 2rem;
        }

        .proflabel {
            display: inline;
            margin: auto;
            font-size: 1.1rem;
            left: 2%;
            position: relative;
        }

        .threadlabel {
            display: inline;
            margin: auto;
            font-size: 1.1rem;
            left: 0.6%;
            position: relative;
        }

        @media ( min-width: 768px) {
            .grid-divider {
                border-right: 1px solid gray;
            }
            .responsive-hr {
                background-color: gray;
                opacity: 1;
            }
        }

        @media ( max-width: 768px) {
            .responsive-hr {
                background-color: gray;
                opacity: 0;
            }
        }

        .material-shadow{
            box-shadow: 0 1px 6px rgba(0,0,0,0.16), 0 1px 6px rgba(0,0,0,0.23);
            transition: all 0.3s cubic-bezier(.25,.8,.25,1);
        }

        .material-shadow:hover{
            box-shadow: 0 3px 25px rgba(0,0,0,0.16), 0 3px 25px rgba(0,0,0,0.23);
        }
    </style>
    <body>
        <%@include file="/commons/adminNavbar.jsp" %>
        <div class="container mainContainer">
            <h1 class="display-4 d-none d-sm-block">Dashboard</h1>
            <div class="alert alert-info alert-dismissible fade show material-shadow" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <strong>Welcome to the dashboard, admin!</strong> You should check in on some of those fields below.
            </div><!--/.alert alert-info-->
            <div class="row mb-3">
                <div class="col-xl-3 col-sm-6">
                    <div class="card bg-success text-white h-100">
                        <div class="card-body bg-success">
                            <div class="rotate">
                                <i class="fa fa-user fa-3x"></i>
                            </div>
                            <h6 class="text-uppercase">Users</h6>
                            <h1 class="display-4">3,125</h1>
                        </div>
                    </div>
                </div><!--/.col-xl-3-->
                <div class="col-xl-3 col-sm-6">
                    <div class="card text-white bg-primary h-100">
                        <div class="card-body bg-primary">
                            <div class="rotate">
                                <i class="fa fa-id-card fa-3x"></i>
                            </div>
                            <h6 class="text-uppercase">Professors</h6>
                            <h1 class="display-4">256</h1>
                        </div>
                    </div>
                </div><!--/.col-xl-3-->
                <div class="col-xl-3 col-sm-6">
                    <div class="card text-white bg-danger h-100">
                        <div class="card-body bg-danger">
                            <div class="rotate">
                                <i class="fa fa-exclamation-circle fa-3x"></i>
                            </div>
                            <h6 class="text-uppercase">Complaints</h6>
                            <h1 class="display-4">32</h1>
                        </div>
                    </div>
                </div><!--/.col-xl-3-->
                <div class="col-xl-3 col-sm-6">
                    <div class="card text-white bg-secondary h-100">
                        <div class="card-body bg-secondary">
                            <div class="rotate">
                                <i class="fa fa-info-circle fa-3x"></i>
                            </div>
                            <h6 class="text-uppercase">Requests</h6>
                            <h1 class="display-4">12</h1>
                        </div>
                    </div>
                </div><!--/.col-xl-3-->
            </div><!--/row-->
            <div class="row">
                <div class="col-md-6">
                    <h4>Top 5 Most Reviewed Profs Data</h4>
                    <div class="table-responsive material-shadow">
                        <table class="table table-striped">
                            <thead class="thead-inverse">
                                <tr>
                                    <th>ID</th>
                                    <th>College</th>
                                    <th>Name</th>
                                    <th>Avg. Rating</th>
                                    <th>Reviews</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>20800</td>
                                    <td>CLA</td>
                                    <td>Bryan Kim Lira</td>
                                    <td>4.250</td>
                                    <td>1,350</td>
                                </tr>
                                <tr>
                                    <td>15712</td>
                                    <td>CCS</td>
                                    <td>Neil Patrick Del Dellego</td>
                                    <td>4.850</td>
                                    <td>1,005</td>
                                </tr>
                                <tr>
                                    <td>11324</td>
                                    <td>CCS</td>
                                    <td>Renato Jose Maria Molano</td>
                                    <td>4.950</td>
                                    <td>995</td>
                                </tr>
                                <tr>
                                    <td>34412</td>
                                    <td>COS</td>
                                    <td>Doree Arzadon</td>
                                    <td>3.950</td>
                                    <td>850</td>
                                </tr>
                                <tr>
                                    <td>49054</td>
                                    <td>GCOE</td>
                                    <td>Mark Anthony Garcia</td>
                                    <td>4.900</td>
                                    <td>780</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div><!--/.col-md-6-->
                <div class="col-md-6">
                    <h4>Top 5 Highest Rated Profs Data</h4>
                    <div class="table-responsive material-shadow">
                        <table class="table table-striped">
                            <thead class="thead-inverse">
                                <tr>
                                    <th>ID</th>
                                    <th>College</th>
                                    <th>Name</th>
                                    <th>Avg. Rating</th>
                                    <th>Reviews</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>11324</td>
                                    <td>CCS</td>
                                    <td>Renato Jose Maria Molano</td>
                                    <td>4.950</td>
                                    <td>995</td>
                                </tr>
                                <tr>
                                    <td>49054</td>
                                    <td>GCOE</td>
                                    <td>Mark Anthony Garcia</td>
                                    <td>4.900</td>
                                    <td>780</td>
                                </tr>
                                <tr>
                                    <td>15712</td>
                                    <td>CCS</td>
                                    <td>Neil Patrick Del Gallego</td>
                                    <td>4.850</td>
                                    <td>1,005</td>
                                </tr>
                                <tr>
                                    <td>10825</td>
                                    <td>COS</td>
                                    <td>Oliver Malabanan</td>
                                    <td>4.825</td>
                                    <td>582</td>
                                </tr>
                                <tr>
                                    <td>50154</td>
                                    <td>SOE</td>
                                    <td>Glenn Sipin</td>
                                    <td>4.800</td>
                                    <td>352</td>
                                </tr>
                            </tbody>
                        </table>
                    </div><!--/.table-->
                </div><!--/.col-md-6-->
            </div> <!--/row-->
        </div><!--/.container mainContainer--><br>
        <div>
            <div class="container">
                <p class="text-center text-black" style="margin-left:0px;!important">© Copyright 2017 Phantom Five Dev Team, all rights reserved. </p>
            </div><!--/.container-->
        </div><!--FOOTER-->
    </body>
</html>
