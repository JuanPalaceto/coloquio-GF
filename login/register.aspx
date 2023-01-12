<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">
    <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
    <%-- icons unicode source --%>
    <%-- https://zavoloklom.github.io/material-design-iconic-font/icons.html#application --%>
    <style>
        #inicio:hover{
            background-color:#51a97f;
        }
    </style>
</head>
<body>
    <form id="form" runat="server">
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
                    </div>

                    <%-- registro --%>
                    <div class="content" style="margin-top:200px !important">
                    <h2 class="text-center">Registro</h2>
                        <%-- nombre --%>
                        <div class="wrap-input100 validate-input m-b-23" data-validate="Ingrese su nombre.">
                            <span class="label-input100">Nombre(s)</span>
                            <input type="text" name="" id="inputNom" class="input100">
                            <span class="focus-input100" data-symbol="&#xf207;"></span>
                        </div>
                        <%-- apellido --%>
                        <div class="wrap-input100 validate-input m-b-23" data-validate="Ingrese sus apellidos.">
                            <span class="label-input100">Apellidos</span>
                            <input type="text" name="" id="inputApe" class="input100">
                            <span class="focus-input100" data-symbol="&#xf207;"></span>
                        </div>
                        <%-- correo electrónico --%>
                        <div class="wrap-input100 validate-input m-b-23" data-validate="Ingrese su correo.">
                            <span class="label-input100">Correo electrónico</span>
                            <input type="text" name="" id="inputEmail" class="input100">
                            <span class="focus-input100" data-symbol="&#xf15a;"></span>
                        </div>
                        <%-- teléfono --%>
                        <div class="wrap-input100 validate-input m-b-23" data-validate="Ingrese su país.">
                            <span class="label-input100">Teléfono</span>
                            <input type="number" name="" id="inputTel" class="input100">
                            <span class="focus-input100" data-symbol="&#xf2be;"></span>
                        </div>

                        <%-- contraseña --%>
                        <div class="wrap-input100 validate-input m-b-23" data-validate="Ingrese una contraseña.">
                            <span class="label-input100">Contraseña</span>
                            <input type="text" name="" id="inputPassword" class="input100">
                            <span class="focus-input100" data-symbol="&#xf191;"></span>
                        </div>
                        <%-- confirmar contraseña --%>
                        <div class="wrap-input100 validate-input m-b-23" data-validate="Ingrese nuevamente la contraseña.">
                            <span class="label-input100">Confirmar contraseña</span>
                            <input type="text" name="" id="inputPasswordConfirm" class="input100">
                            <span class="focus-input100" data-symbol="&#xf191;"></span>
                        </div>
                        <%-- grado académico máximo --%>
                        <div class="wrap-input100 validate-input m-b-23" data-validate="Ingrese su grado.">
                            <span class="label-input100">Grado académico máximo</span>
                            <select name="" class="input100" id="inputGrado" data-live-search="true" required>
                                <option value="0">- Seleccionar -</option>
                                <option value="Licenciatura">Licenciatura</option>
                                <option value="Maestría">Maestría</option>
                                <option value="Doctorado">Doctorado</option>
                            </select>
                            <span class="focus-input100" data-symbol="&#xf174;"></span>
                        </div>
                        <%-- institución --%>
                        <div class="wrap-input100 validate-input m-b-23 sortear" data-validate="Ingrese su institución.">
                            <span class="label-input100">Institución</span>
                            <select name="" class="input100" id="inputInstitucion" data-live-search="true" onchange="cargarDependencia();">
                                <option value="0">- Seleccionar -</option>
                            </select>
                            <span class="focus-input100" data-symbol="&#xf11c;"></span>
                        </div>
                        <%-- dependencia --%>
                        <div class="wrap-input100 validate-input m-b-23 sortear" data-validate="Ingrese su dependencia.">
                            <span class="label-input100">Dependencia</span>
                            <select name="" class="input100" id="inputDependencia" data-live-search="true" disabled>
                                <option value="0">Seleccione una institución</option>
                            </select>
                            <span class="focus-input100" data-symbol="&#xf18d;"></span>
                        </div>
                        <%-- estado --%>
                        <div class="wrap-input100 validate-input m-b-23 sortear" data-validate="Ingrese su estado.">
                            <span class="label-input100">Estado</span>
                            <select name="" class="input100" id="inputEstado" data-live-search="true" onchange="cargarCiudad();">
                                <option value="0">- Seleccionar -</option>
                            </select>
                            <span class="focus-input100" data-symbol="&#xf173;"></span>
                        </div>
                        <%-- ciudad --%>
                        <div class="wrap-input100 validate-input m-b-23 sortear" data-validate="Ingrese su ciudad.">
                            <span class="label-input100">Ciudad</span>
                            <select name="" class="input100" id="inputCiudad" data-live-search="true" disabled>
                                <option value="0">Seleccione un estado</option>
                            </select>
                            <span class="focus-input100" data-symbol="&#xf133;"></span>
                        </div>
                        <%-- label informativo --%>
                        <asp:Label runat="server" ID="lblTxt" />
                        <%-- botón de registro --%>
                        <div class="form-element form-submit text-center">
                            <button type="button" class="botones" onclick="registrar();">Registrar</button>
                        </div>
                        <%-- links --%>
                        <div class="form-element form-submit">
                            <a href="login.aspx" style="color:green;">¿Ya tienes cuenta? Iniciar sesión.</a>
                            <a class="float-right" href="password.aspx" style="color:green;">Recuperar contraseña.</a>
                        </div>
                        <br>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
        function registrar(){
            var nombre = $('#inputNom').val();
            var apellido = $('#inputApe').val();
            var email = $('#inputEmail').val();
            var psw = $('#inputPassword').val();
            var pswConfirm = $('#inputPasswordConfirm').val();
            var grado = $('#inputGrado').val();
            var institucion = $('#inputInstitucion').val();
            var dependencia = $('#inputDependencia').val();
            var ciudad = $('#inputCiudad').val();
            var estado = $('#inputEstado').val();
            var telefono = $('#inputTel').val();

            var regex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;

            if (!regex.test(email)) {
                $('#inputEmail').addClass("is-invalid");
                $('#inputEmail')[0].reportValidity();
                return;
            }

            if (psw != pswConfirm) {
                $('#inputPassword').addClass("is-invalid");
                $('#inputPasswordConfirm').addClass("is-invalid");
                $('#inputPasswordConfirm').focus();
                return;
            }

            var obj = {};
            obj.nombre = nombre;
            obj.apellido = apellido;
            obj.email = email;
            obj.psw = psw;
            obj.grado = grado;
            obj.institucion = institucion;
            obj.dependencia = dependencia;
            obj.ciudad = ciudad;
            obj.estado = estado;
            obj.telefono = telefono;

            if ($('form')[0].checkValidity()){
                $.ajax({
                    type: 'POST',
                    url: 'register.aspx/Guardar',
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("Error" + jqXHR.responseText);
                    },
                    success: function (valor) {
                        var JsonD = $.parseJSON(valor.d)
                        if (JsonD.success == 1) {
                            alert('La informacion se guardó correctamente.');
                            window.location.href = "login.aspx";
                        } else if (JsonD.success == 2) {
                            alert('Este correo ya está en uso.')
                        }
                    }
                });
            } else {
                $('form')[0].reportValidity();
                return;
            }
        }
    </script>

    <script>
        const batchTrack = document.getElementById("inputInstitucion");
        const getPost = async () => {
            const response = await fetch("https://api.datamexico.org/tesseract/data.jsonrecords?cube=anuies_enrollment&drilldowns=Institution&locale=es&measures=Students");
            <%-- console.log(response); --%>
            const data = response.json();
            return data;
        };

        const displayOption = async () => {
        const options = await getPost();
        options.data.forEach(option => {
            const newOption = document.createElement("option");
            console.log(option);
            newOption.value = option["Institution ID"];
            newOption.text = option.Institution;
            batchTrack.appendChild(newOption);

        });
        sortear();
        $("#inputInstitucion option[value=0]").attr('selected', 'selected');
        };
        displayOption();

    function cargarDependencia(){
        $("#inputDependencia option").each(function() {
            $(this).remove();
        });
        var id = $('#inputInstitucion').val();
        if(id == 0){
            const batchTrack = document.getElementById("inputDependencia");
            const newOption = document.createElement("option");
            newOption.value = 0;
            newOption.text = "Seleccione una institución";
            batchTrack.appendChild(newOption);
            $("#inputDependencia").attr('disabled',true);
        } else {
        const batchTrack = document.getElementById("inputDependencia");
        const getPost = async () => {
            const response = await fetch("https://api.datamexico.org/tesseract/data.jsonrecords?Institution="+ id +"&cube=anuies_enrollment&drilldowns=Institution%2CCampus&locale=es&measures=Students");
            <%-- console.log(response); --%>
            const data = response.json();
            return data;
        };

        const displayOption = async () => {
        const options = await getPost();
        const newOption = document.createElement("option");
        newOption.value = "0"
        newOption.text = "- Seleccionar -"
        batchTrack.appendChild(newOption);
        options.data.forEach(option => {
            const newOption = document.createElement("option");
            console.log(option);
            newOption.value = option["Campus ID"];
            newOption.text = option.Campus;
            batchTrack.appendChild(newOption);
            $("#inputDependencia").removeAttr('disabled');
        });
        sortear2();
        $("#inputDependencia option[value=0]").attr('selected', 'selected');
        };
        displayOption();
        }
    }

    const batchTrack2 = document.getElementById("inputEstado");
        const getPost2 = async () => {
            const response = await fetch("https://api.datamexico.org/tesseract/data.jsonrecords?cube=inegi_population_total&drilldowns=State&locale=es&measures=Population");
            console.log(response);
            const data = response.json();
            return data;
        };

        const displayOption2 = async () => {
        const options = await getPost2();
        options.data.forEach(option => {
            const newOption = document.createElement("option");
            console.log(option);
            newOption.value = option["State ID"];
            newOption.text = option.State;
            batchTrack2.appendChild(newOption);

        });
        sortear3();
        $("#inputEstado option[value=0]").attr('selected', 'selected');
        };
        displayOption2();

    function cargarCiudad(){
        $("#inputCiudad option").each(function() {
            $(this).remove();
        });
        var id = $('#inputEstado').val();
        if(id == 0){
            const batchTrack2 = document.getElementById("inputCiudad");
            const newOption = document.createElement("option");
            newOption.value = 0;
            newOption.text = "Seleccione un estado";
            batchTrack2.appendChild(newOption);
            $("#inputCiudad").attr('disabled',true);
        } else {
        const batchTrack2 = document.getElementById("inputCiudad");
        const getPost2 = async () => {
            const response = await fetch("https://api.datamexico.org/tesseract/data.jsonrecords?State="+id+"&cube=inegi_population_total&drilldowns=State%2CMunicipality&locale=es&measures=Population");
            <%-- console.log(response); --%>
            const data = response.json();
            return data;
        };

        const displayOption2 = async () => {
        const options = await getPost2();
        const newOption = document.createElement("option");
        newOption.value = "0"
        newOption.text = "- Seleccionar -"
        batchTrack2.appendChild(newOption);
        options.data.forEach(option => {
            const newOption = document.createElement("option");
            <%-- console.log(option); --%>
            newOption.value = option["Municipality ID"];
            newOption.text = option.Municipality;
            batchTrack2.appendChild(newOption);
            $("#inputCiudad").removeAttr('disabled');
        });
        sortear4();
        $("#inputCiudad option[value=0]").attr('selected', 'selected');
        };
        displayOption2();
        }
    }

    function sortear() {
        $("#inputInstitucion").append($("#inputInstitucion option").remove().sort(function(a, b) {
            var at = $(a).text(),
                bt = $(b).text();
            return (at > bt) ? 1 : ((at < bt) ? -1 : 0);
        }));
    }
    function sortear2() {
        $("#inputDependencia").append($("#inputDependencia option").remove().sort(function(a, b) {
            var at = $(a).text(),
                bt = $(b).text();
            return (at > bt) ? 1 : ((at < bt) ? -1 : 0);
        }));
    }
    function sortear3() {
        $("#inputEstado").append($("#inputEstado option").remove().sort(function(a, b) {
            var at = $(a).text(),
                bt = $(b).text();
            return (at > bt) ? 1 : ((at < bt) ? -1 : 0);
        }));
    }
    function sortear4() {
        $("#inputCiudad").append($("#inputCiudad option").remove().sort(function(a, b) {
            var at = $(a).text(),
                bt = $(b).text();
            return (at > bt) ? 1 : ((at < bt) ? -1 : 0);
        }));
    }
    </script>

    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/paper.js/0.11.3/paper-full.min.js'></script>
    <script src="https://kit.fontawesome.com/b858070c46.js" crossorigin="anonymous"></script>
    <script src="../login/vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="../login/vendor/animsition/js/animsition.min.js"></script>
    <script src="../login/vendor/bootstrap/js/popper.js"></script>
    <script src="../login/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="../login/vendor/select2/select2.min.js"></script>
    <script src="../login/vendor/countdowntime/countdowntime.js"></script>
    <script src="../js/mainV2.js"></script>
    <script src="../js/indexV2.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>
    <%-- <script src="../js/api.js"></script> --%>
</body>
</html>
