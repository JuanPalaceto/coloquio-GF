<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Coloquio de Investigación | FCAV</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="../css/style2.css">
    <link rel="stylesheet" type="text/css" href="../css/util2.css">
    <link rel="stylesheet" type="text/css" href="../css/main2.css">
    <link rel="stylesheet" type="text/css" href="../login/vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../login/fonts/iconic/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="../login/vendor/animate/animate.css">
    <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
    <style>
        #inicio:hover{
            background-color:#51a97f;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="back">
            <canvas id="canvas" class="canvas-back"></canvas>
            <div class="backRight">
            </div>
            <div class="backLeft">
                <div id="dLeyenda">
                    <p id="pLeyenda">
                        Software desarrollado por La Facultad<br />
                        de Comercio y Administraci&oacute;n Victoria.
                    </p>
                </div>
            </div>
        </div>
        <div id="slideBox">
            <div class="topLayer">
                <div class="right">
                    <div class="contenedor-logo-uat row">
                        <div class="logo-uat col-sm-6 col-md-6 col-lg-6">
                            <img id="loguat" src="../assets/img/UAT22.png" />
                        </div>
                        <div class="logo-fcav col-xs-12 col-sm-12 col-md-12 col-lg-6">
                            <img id="logfcav" src="../assets/img/FCAV22.png" />
                        </div>  
                        <%-- <div class="text-center">
                            <img width="50%" id="logoColoquio" src="../assets/img/X.png" /><br><br>
                        </div>                 --%>
                    </div>
                    <div class="content" style="margin-top:200px !important">


                        <h2 class="text-center">Coloquio de Investigaci&oacute;n</h2>
                        <div class="wrap-input100 validate-input m-b-23" data-validate="Se requiere un correo electrónico">
                            <span class="label-input100">Correo electrónico</span>

                            <asp:TextBox ID="inputEmail" runat="server" class="input100" name="Correo"></asp:TextBox>
                            <span class="focus-input100" data-symbol="&#xf207;"></span>
                        </div>
                        <div class="wrap-input100 validate-input" data-validate="Se requiere contraseña">
                            <span class="label-input100">Contraseña</span>

                            <asp:TextBox ID="inputPassword" runat="server" class="input100" type="password"></asp:TextBox>
                            <span class="focus-input100" data-symbol="&#xf191;"></span>
                        </div>
                        <div class="form-element form-submit">
                            <a class="float-left" href="register.aspx" style="color:green;"><h6>¿No tienes cuenta? Ir al registro.</h6></a>
                            <a class="float-right" href="password.aspx" style="color:green;"><h6>Recuperar contraseña.</h6></a>
                        </div>                         
                        <asp:Label runat="server" ID="lblTxt" /> 
                        <div class="form-element form-submit text-center">
                            <asp:Button class="login" ID="inicio" runat="server" Text="Iniciar sesion" OnClick="login_Click" />
                        </div>                    
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/paper.js/0.11.3/paper-full.min.js'></script>
    <script src="../login/vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="../login/vendor/animsition/js/animsition.min.js"></script>
    <script src="../login/vendor/bootstrap/js/popper.js"></script>
    <script src="../login/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="../login/vendor/select2/select2.min.js"></script>
    <script src="../login/vendor/countdowntime/countdowntime.js"></script>
    <script src="../js/mainV2.js"></script>
    <script src="../js/indexV2.js"></script>
</body>
</html>
