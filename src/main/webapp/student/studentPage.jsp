<%-- 
    Document   : studentPage
    Created on : 12 22, 17, 9:49:01 PM
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
        
        <style is="custom-style">
            paper-fab-speed-dial.two {
                --paper-fab-speed-dial: {
                    bottom: 2%;
                    right: 1.2%;
                    position:fixed;
                };
            }

            paper-fab.blue {
                --paper-fab-background: var(--paper-light-blue-500);
                --paper-fab-keyboard-focus-background: var(--paper-light-blue-900);
            }

            paper-fab.fblue {
                --paper-fab-background: #3B5998;
                --paper-fab-keyboard-focus-background: #3B5998;
            }

            paper-fab.twitter {
                --paper-fab-background: #1DA1F2;
                --paper-fab-keyboard-focus-background: #1DA1F2;
            }

            paper-fab.info {
                --paper-fab-background: #646464;
                --paper-fab-keyboard-focus-background: #646464;
            }
        </style>
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
        </style>
    </head>
    <body>
        <%@include file="/commons/studentNavbar.jsp" %>
        <br />
        <div class="container mainContainer">
            <div class="row">
                <div class="col-md-8 ml-auto mr-auto">
                    <form action="#" method="get">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search a professor">
                            <span class="input-group-addon"><a href="#" class="text-success"><i class="fa fa-search" aria-hidden="true"></i></a></span>
                        </div>
                    </form><!--/Search Function-->
                </div><!--/.col-md-8-->
            </div><!--/.row-->
            <div class="row">
                <div class="col-md-12">
                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                            <li data-target="#myCarousel" data-slide-to="1"></li>
                            <li data-target="#myCarousel" data-slide-to="2"></li>
                        </ol><!--/.carousel-indicators-->
                        <div class="carousel-inner" role="listbox">
                            <div class="carousel-item active">
                                <img class="first-slide img-responsive" src="/Profsmato/assets/carousel-pic/prof1.jpg" alt="First slide">
                                <div class="container">
                                    <div class="carousel-caption text-left">
                                        <h3>Most Outstanding Teacher</h3>
                                        <p>Sir RJ Molano, the CCS favorite stays on top.</p>
                                    </div><!--/.carousel-caption-->
                                </div><!--/.container-->
                            </div><!--/.carousel-item-->
                            <div class="carousel-item">
                                <img class="second-slide img-responsive" src="/Profsmato/assets/carousel-pic/prof2.jpg" alt="Second slide">
                                <div class="container">
                                    <div class="carousel-caption text-left">
                                        <h3>Unmatched</h3>
                                        <p>Ms. Diane Lim, the true definition of beauty and brains.</p>
                                    </div><!--carousel-caption-->
                                </div><!--container-->
                            </div><!--/.carousel-item-->
                            <div class="carousel-item">
                                <img class="third-slide img-responsive" src="/Profsmato/assets/carousel-pic/prof3.jpg" alt="Third slide">
                                <div class="container">
                                    <div class="carousel-caption text-left">
                                        <h3>L O D I</h3>
                                        <p>Sir Jordan Deja, Leader of Design and Innovation</p>
                                    </div><!--carousel-caption-->
                                </div><!--/.container-->
                            </div><!--/.carousel-item-->
                        </div><!--/.carousel-inner-->
                        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev"> <span class="carousel-control-prev-icon" aria-hidden="true"></span> <span class="sr-only">Previous</span> </a>
                        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next"> <span class="carousel-control-next-icon" aria-hidden="true"></span> <span class="sr-only">Next</span> </a>
                    </div><!--/#myCarousel-->
                </div> <!--carousel -->
            </div><!--/.col-md-12 carousel-->
            <br />
            <div class="row">
                <div class="col-lg-6 grid-divider">
                    <div class="container">
                        <h3>Most Reviewed Profs</h3>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Neil Patrick Del Gallego (CCS) </a>
                        </div>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Renato Jose Maria Molano (CLA) </a>
                        </div>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Shirley Chu (COB) </a>
                        </div>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Diane Lim (CCS) </a>
                        </div>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Thomas James Tiam-Lee (SOE) </a>
                        </div>
                    </div><!-- div class container -->
                    <br /> 
                </div>
                <div class="col-lg-6">
                    <div class="container">
                        <h3>Highest Rated Profs</h3>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Jordan Deja (CCS) </a>
                        </div>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Neil Patrick Del Gallego (CCS) </a>
                        </div>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Briane Samson (CCS) </a>
                        </div>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Glenn Sipin (CCS) </a>
                        </div>
                        <div>
                            <img src="/Profsmato/assets/designs/tomato.svg" style="width:5%;">
                            <a href="#" class="proflabel text-black">Oliver Malabanan (CCS) </a>
                        </div>
                    </div><!--/.container -->
                </div><!--/.col-md-6 -->
            </div><!--/.row-->
            <hr class="responsive-hr" />
            <br />
            <div>
                <div class="container">
                    <p class="text-center text-black" style="margin-left:0px;!important">© Copyright 2017 Phantom Five Dev Team, all rights reserved. </p>
                </div>
            </div><!--/.footer-->
            <div class="screen">
                <paper-fab-speed-dial class="two">
                    <paper-fab class ="blue" icon="more-vert"></paper-fab>
                    <div class="dropdown-content">
                        <a href="#"><paper-fab class="info" mini icon="info-outline"></paper-fab></a>
                        <paper-fab class="twitter" mini src="/Profsmato/assets/designs/twitter.svg"></paper-fab>
                        <paper-fab class="fblue" mini src="/Profsmato/assets/designs/facebook.svg"></paper-fab>
                        <paper-fab mini src="/Profsmato/assets/designs/instagram.svg"></paper-fab>
                    </div>
                </paper-fab-speed-dial>
            </div><!--/.screen-->
        </div><!--/.container-->
    </body>
    <script>
        $(document).ready(function(){
           $('body').bootstrapMaterialDesign(); 
        });
    </script>
</html>
