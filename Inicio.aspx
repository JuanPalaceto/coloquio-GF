<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Inicio.aspx.cs" Inherits="Inicio" %>

<!DOCTYPE html>

<html lang="es" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>FCAV | Coloquio de Investigación</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <%-- <meta http-equiv="Expires" content="0">
    <meta http-equiv="Last-Modified" content="0">
    <meta http-equiv="Cache-Control" content="no-cache, mustrevalidate">
    <meta http-equiv="Pragma" content="no-cache"> --%>

    <%-- fontawesome --%>
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

    <!-- Favicons -->
    <link href="assets/img/fcav.png" rel="icon">
    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- CSS para el Menú en móvil -->
    <link rel="stylesheet" href="assets/css/styleMenu.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">

    <style> 
        @media only screen and (max-width: 600px) {
          .imgs {
            display:none;
          }
        }

        @media screen and (max-width: 991px) {
        #lics, #submenu{
            display:none;
        }
        #menu {
            display:block;
        }
      }
      @media screen and (min-width: 992px) {
        #menu{
            display:none;
        }

      }

      @media screen and (max-width: 500px){
	    .img_logom{
            display:block !important;
         }
        .img_logo{
            display:none !important;
         }

      }
    </style>    
</head>
<body>
    <!-- ======= Top Bar ======= -->    
    <div class="container d-flex justify-content-center justify-content-md-between">        
        <div class="float-end me-5" style="margin-left:auto;">
            <ul class="list-inline">
                <%-- <li class="list-inline-item"><a href="/Posgrado/Servicios/Servicios_Alumnos.aspx">Alumnos Posgrado</a></li> --%>
                <li class="list-inline-item mx-1"></li>
                <%-- <li class="list-inline-item"><a href="/Posgrado/Servicios/Servicios_Docentes.aspx">Docentes Posgrado</a></li> --%>
            </ul>
        </div>                   
    </div>
    <!-- Agregué el margin bottom negativo para reducir el espacio en blanco entre el header y el navbar -->
    <div class="container d-flex justify-content-center justify-content-md-between position-relative" style="margin-bottom:-18px; margin-top: -18px;">
        <img class="img_logo" src="<%= Page.ResolveUrl("~")%>assets/img/header/thumbnail_header2.png" alt="uat-fcav-logos" style="width: 100%;">
        <img class="img_logom" src="<%= Page.ResolveUrl("~")%>assets/img/header/headerm.png" alt="uat-fcav-logos" style="width: 100%;display:none;">
    </div>
    
    <!-- End Top Bar -->

    <!-- ======= Header ======= -->
    <header id="header" class="d-flex">
        <div class="container d-flex">
            <!-- Navbar -->
            <nav id="navbar" class="navbar w-100">
                <div id="menuprincipal" class="row w-100 mx-auto">
                    <ul id="navbarm">
                        <li class="col d-flex justify-content-center"><a class="nav-link scrollto logo" href="#inicio">INICIO</a></li>
                        <li class="col d-flex justify-content-center"><a class="nav-link scrollto logo" href="#lineamientos">LINEAMIENTOS</a></li>
                        <li class="col d-flex justify-content-center"><a class="nav-link scrollto logo" href="#comite">COMIT&Eacute;</a></li>
                        <li class="col d-flex justify-content-center"><a class="nav-link scrollto logo" href="#fechas">FECHAS</a></li>  
                        <li class="col d-flex justify-content-center"><a class="nav-link scrollto logo" href="login/login.aspx">REGISTRO</a></li>                        
                    </ul>
                </div>
                <i id="clsbtn" class="bi bi-list mobile-nav-toggle"></i>
            </nav>
            <!-- .navbar -->
        </div>
    </header>
    <!-- End Header -->

    <form id="form1" runat="server">            
        <!-- ======= Slider Section ======= -->
        <div class="container">
            <section id="hero">
                <div id="heroCarousel" data-bs-interval="5000" class="carousel slide carousel-fade " data-bs-ride="carousel">
                    <ol class="carousel-indicators" id="hero-carousel-indicators"></ol>
                    <div class="carousel-inner" role="listbox">
                        <!-- Slide 1 -->
                        <div class="carousel-item active" style="background-image: url(assets/img/slide/XColoquio.png); height: auto !important;">
                            <!-- <div class="carousel-container">
                                <div class="container" >
                                    <h2 id="titulo" class="animate__animated animate__fadeInUp" style="padding-bottom:45px; margin-bottom:-10px;">Bienvenidos a <span>División de Estudios de Posgrado e Investigación FCAV</span></h2>                            
                                </div>
                            </div> -->
                        </div>

                        <!-- Slide 2 -->
                        <%-- <div class="carousel-item" style="background-image: url(assets/img/slide/DCA.png)"></div> --%>
                        
                    </div>

                    <a class="carousel-control-prev" href="#heroCarousel" role="button" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon bi bi-chevron-left" aria-hidden="true"></span>
                    </a>

                    <a class="carousel-control-next" href="#heroCarousel" role="button" data-bs-slide="next">
                        <span class="carousel-control-next-icon bi bi-chevron-right" aria-hidden="true"></span>
                    </a>

                </div>
            </section>
        </div>
        <!-- End Slider -->
        <br>
        <main id="main">          
        <!-- ======= Contenido ======= -->
            <div class="container" style="text-align:justify;">
                <section id="about" class="about">                            
                    <div class="row no-gutters">                                     
                        <div class="container">
                            <section id="featured-services2" class="featured-services">
                                <div class="container">
                                
                                    <%-- INICIO --%>
                                    <div id="inicio" style="padding-top:15px">
                                        <div class="section-title">
                                            <h1 id="Noticias">La División de Estudios de Posgrado de la Facultad de Comercio y Administración Victoria</h4><br>
                                            <h2 id="Noticias">Convoca</h2>
                                        </div>
                                        <div class="row no-gutters">
                                            <div class="container">
                                            <p class="lead" style="text-align:justify;">A estudiantes de nivel posgrado inscritos en programas afines a las <strong>Ciencias Administrativas</strong> a presentar sus avances de tesis o trabajos de investigación, con el objetivo de generar y difundir el conocimiento al crear un entorno de dialogo académico con profesores expertos para contribuir al fortalecimiento de las investigaciones participantes. Los trabajos aceptados deberán ser presentados en el <strong>X Coloquio de Investigación</strong> a celebrarse del <strong>10 al 12 de octubre del 2022</strong>.</p>
                                            </div>
                                        </div>                                
                                        <br>
                                        <br>
                                    </div>

                                    <%-- LINEAMIENTOS --%>
                                    <div id="lineamientos" style="padding-top:17px">
                                        <div class="section-title">
                                            <h2 id="Noticias">Lineamientos</h2>
                                        </div>
                                        <div class="container">
                                            <p class="lead">
                                                1. Los trabajos deberán ser registrados por los autores en la página: <a href="https://fcav.uat.edu.mx/coloquio">https://fcav.uat.edu.mx/coloquio</a><br><br>
                                                2. Los trabajos a participar deberán concordar con una de las cinco Líneas de Generación y Aplicación de Conocimiento que a continuación se mencionan:<br><br>
                                                I. Teorías de la Administración General.<br>
                                                II. Desarrollo Regional.<br>
                                                III. Tecnologías, innovación y redes de conocimiento.<br><br>
                                                3. Los trabajos serán sometidos a una evaluación a doble ciego; los documentos aceptados serán presentados en modalidad oral con 15 minutos para exposición y 5 minutos para preguntas y respuestas.<br><br>
                                                4. Este coloquio no tiene costo de inscripción.<br><br>
                                                5. Las fecha para recepción de trabajos serán del 7 al 30 de septiembre de 2022.<br><br>                            
                                            </p>
                                            <p class="lead" style="text-align:center">Si quieres saber más, consulta la convocatoria completa:</p>
                                        </div>
                                        <!-- Botón de lineamientos-->
                                        <div class="text-center mt-4">
                                            <a class="btn btn-xl bg-success text-white" href="https://fcav.uat.edu.mx/coloquio/convocatorias/convocatoria.pdf" target="_blank" id="convocatoriabtn">
                                                <i class="fas fa-download me-2"></i>
                                                Convocatoria
                                            </a>
                                        </div>                                
                                        <br>
                                        <br>
                                    </div>

                                    <%-- COMITÉ --%>
                                    <div id="comite">
                                        <div class="section-title" id="comite" style="padding-top:20px">                                    
                                            <h2 id="Noticias">Comit&eacute;</h2>
                                        </div>
                                        <div class="container" style="text-align:center">
                                            <ul style="display:inline-block;text-align:left;font-size:18px;font-family:'Tenor', sans-serif;">
                                                <li>Dr. Arturo Briseño García</li>                                        
                                                <li>Dr. Demian Abrego Almazán</li>
                                                <li>Dr. Francisco García Fernández</li>
                                                <li>Dr. Jesús Lavín Verástegui</li>
                                                <li>Dr. José Antonio Serna Hinojosa</li>
                                                <li>Dr. José Rafael Baca Pumajero</li>
                                                <li>Dra. Mariana Zerón Felix</li>
                                                <li>Dra. Maritza Alvarez Herrera</li>
                                                <li>Dra. Mónica Lorena Sánchez Limón</li>
                                                <li>Dra. Norma Angélica Pedraza Melo</li>
                                                <li>Dra. Yesenia Sánchez Tovar</li>                
                                            </ul>
                                        </div>
                                    </div>
                                </div>                  
                            </section>
                        </div>

                        <%-- FECHAS --%>
                        <div class="container" id="fechas">
                            <section id="featured-services2" class="featured-services section-bg">

                                <%-- titulo --%>
                                <div class="section-title">
                                    <h2 id="Noticias">Fechas</h2>
                                </div>

                                <%-- eventos --%>
                                <div class="row no-gutters">    

                                    <%-- evento 1 --%>
                                    <div class="col-lg-4 col-md-6">
                                        <div class="icon-box">
                                            <div class="icon">
                                                <h1><span class="badge badge-secondary" style="background-color:#6c757d !important">10</span> Octubre</h1>
                                            </div>
                                            
                                            <h4 class="title"><a href="#p">Mesas de investigaci&oacute;n.</a></h4>
                                            <ul class="list-inline" style="justify-content:left;">
                                                <li class="list-inline-item"><i class="bi bi-calendar4-week" aria-hidden="true"></i> Lunes</li>
                                                <li class="list-inline-item"><i class="bi bi-clock" aria-hidden="true"></i> 11:30 A.M. a 14:00 P.M.</li>
                                                <li class="list-inline-item"><i class="bi bi-bookmark-check" aria-hidden="true"></i> 2022</li>
                                            </ul>
                                            <p class="description">
                                                <b>Organizado por:</b> Divisi&oacute;n de Estudios de Posgrado e Investigaci&oacute;n.
                                            </p>
                                            <p class="description">
                                                <b>Lugar:</b> Posgrado.
                                            </p>
                                            <hr>

                                            <h4 class="title"><a href="#p">Mesas de investigaci&oacute;n.</a></h4>
                                            <ul class="list-inline" style="justify-content:left;">
                                                <li class="list-inline-item"><i class="bi bi-calendar4-week" aria-hidden="true"></i> Lunes</li>
                                                <li class="list-inline-item"><i class="bi bi-clock" aria-hidden="true"></i> 16:00 P.M. a 18:30 P.M.</li>
                                                <li class="list-inline-item"><i class="bi bi-bookmark-check" aria-hidden="true"></i> 2022</li>
                                            </ul>
                                            <p class="description">
                                                <b>Organizado por:</b> Divisi&oacute;n de Estudios de Posgrado e Investigaci&oacute;n.
                                            </p>
                                            <p class="description">
                                                <b>Lugar:</b> Posgrado.
                                            </p>                                                                        
                                        </div>
                                    </div>

                                    <%-- evento 2 --%>
                                    <div class="col-lg-4 col-md-6">
                                        <div class="icon-box">
                                            <div class="icon">
                                                <h1><span class="badge badge-secondary" style="background-color:#6c757d !important">11</span> Octubre</h1>
                                            </div>

                                            <h4 class="title"><a href="#p">Mesas de investigaci&oacute;n.</a></h4>                        
                                            <ul class="list-inline"  style="justify-content:left;">
                                                <li class="list-inline-item"><i class="bi bi-calendar4-week" aria-hidden="true"></i> Martes</li>
                                                <li class="list-inline-item"><i class="bi bi-clock" aria-hidden="true"></i> 12:00 P.M. a 14:00 P.M.</li>
                                                <li class="list-inline-item"><i class="bi bi-bookmark-check" aria-hidden="true"></i> 2022</li>
                                            </ul>
                                            <p class="description">
                                                <b>Organizado por:</b> Divisi&oacute;n de Estudios de Posgrado e Investigaci&oacute;n.
                                            </p>
                                            <p class="description">
                                                <b>Lugar:</b> Posgrado.
                                            </p>               
                                        </div>
                                    </div>


                                    <%-- evento 3 --%>
                                    <div class="col-lg-4 col-md-6">
                                        <div class="icon-box">
                                            <div class="icon">
                                                <h1><span class="badge badge-secondary" style="background-color:#6c757d !important">12</span> Octubre</h1>
                                            </div>

                                            <h4 class="title"><a href="#p">Mesas de investigaci&oacute;n.</a></h4>                        
                                            <ul class="list-inline"  style="justify-content:left;">
                                                <li class="list-inline-item"><i class="bi bi-calendar4-week" aria-hidden="true"></i> Mi&eacute;rcoles</li>
                                                <li class="list-inline-item"><i class="bi bi-clock" aria-hidden="true"></i> 10:00 A.M. a 12:00 P.M.</li>                                                
                                                <li class="list-inline-item"><i class="bi bi-bookmark-check" aria-hidden="true"></i> 2022</li>
                                            </ul>
                                            <p class="description">
                                                <b>Organizado por:</b> Divisi&oacute;n de Estudios de Posgrado e Investigaci&oacute;n.
                                            </p>                                            
                                            <p class="description">
                                                <b>Lugar:</b> Auditorio FCAV.
                                            </p>               
                                        </div>
                                    </div>                                                                        
                                </div>
                            </section>
                        </div>                                                                                
                    </div>                                                 
                </section>
            </div>             
        </main>
    </form>

    <!-- ======= Footer ======= -->
    <div class="container">
        <footer id="footer">
            <div class="container">
                <h3>Divisi&oacute;n de Estudios de Posgrado e Investigaci&oacute;n</h3>
                <p style="margin-bottom:-10px;">
                    Universidad Aut&oacute;noma de Tamaulipas
                    <br />
                    Centro Universitario Victoria - FCAV, C.P. 87000 
                    <br />
                    Cd. Victoria, Tamaulipas, M&eacute;xico.
                    <br />
                    Tel. (+52 834) 318 1800, Extensiones 2413, 2451 y 2452.</i>                                        
                    <br />
                    Horario de Atención
                    <br />
                    Lunes a Viernes
                    <br />
                    De 9:00 a 19:00 Hrs.
            </div>
        </footer>
        <!-- End Footer -->
    </div>

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

    <!-- Vendor JS Files -->
    <script src="<%= Page.ResolveUrl("~")%>assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="<%= Page.ResolveUrl("~")%>assets/vendor/glightbox/js/glightbox.min.js"></script>
    <script src="<%= Page.ResolveUrl("~")%>assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
    <script src="<%= Page.ResolveUrl("~")%>assets/vendor/php-email-form/validate.js"></script>
    <script src="<%= Page.ResolveUrl("~")%>assets/vendor/swiper/swiper-bundle.min.js"></script>

    <!-- Template Main JS File -->
    <script src="<%= Page.ResolveUrl("~")%>assets/js/main.js"></script>


<!-- Scripts para el Menú en móvil -->
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
    <script src="<%= Page.ResolveUrl("~")%>assets/js/scriptMenu.js"></script>
    <script src="<%= Page.ResolveUrl("~")%>assets/js/maestrias.js"></script>
    <script src="<%= Page.ResolveUrl("~")%>assets/js/doctorados.js"></script>

    <script>
        $(document).ready(function () {

            if ($(window).width() <= 991) {
                $("#menuprincipal").removeClass("row");
                $("#menuprincipal").removeClass("w-100");
                $("#menuprincipal").removeClass("mx-auto");
            }
        });

        $(window).resize(function () {
            if ($(window).width() <= 991) {
                $("#menuprincipal").removeClass("row");
                $("#menuprincipal").removeClass("w-100");
                $("#menuprincipal").removeClass("mx-auto");
            }
            else {
                $("#menuprincipal").addClass("row");
                $("#menuprincipal").addClass("w-100");
                $("#menuprincipal").addClass("mx-auto");
            }
        });

    </script>
</body>
</html>
