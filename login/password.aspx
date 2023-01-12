<%@ Page Language="C#" AutoEventWireup="true" CodeFile="password.aspx.cs" Inherits="password" %>

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
                        Software desarrollado por La Facultad
                        <br />
                        de Comercio y Administraci&oacute;n Victoria
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


                        <h2 class="text-center">Restablecer Contraseña</h2>
                        <div class="wrap-input100 validate-input m-b-23" data-validate="Se requiere un correo electrónico">
                            <span class="label-input100">Correo electrónico</span>

                            <asp:TextBox ID="inputEmail" runat="server" class="input100" name="Correo"></asp:TextBox>
                            <span class="focus-input100" data-symbol="&#xf15a;"></span>
                        </div>                        
                        <asp:Label runat="server" ID="lblTxt" />                         
                        <div class="form-element form-submit text-center">                            
                            <button type="button" class="botones" onclick="Validar();">Restablecer</button>
                        </div>                        
                        <div class="form-element form-submit">
                            <a href="login.aspx" style="color:green;">Regresar a Inicio de Sesión.</a>
                        </div>


                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        function Validar(){
            var correo = $('inputEmail').val();

            var regex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;

            if (!regex.test(email)) {
                $('#inputEmail').addClass("is-invalid");
                $('#inputEmail')[0].reportValidity();
                return;
            }

            var obj = {};
            obj.correo = correo;

            if ($('form')[0].checkValidity()){
                $.ajax({
                    type: 'POST',
                    url: 'password.aspx/Recuperar',
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("Error" + jqXHR.responseText);
                    },
                    success: function (valor) {
                        var JsonD = $.parseJSON(valor.d)
                        if (JsonD.success == 1) {
                            alert('Se ha enviado un correo a esta dirección con instrucciones para recuperar su contraseña.');
                            window.location.href = "login.aspx";
                        } else if (JsonD.success == 2) {
                            alert('Este correo no está dado de alta.')
                        }
                    }
                });
            } else {
                $('form')[0].reportValidity();
                return;
            }
        }
    </script>
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