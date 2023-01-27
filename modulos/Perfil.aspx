<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="Perfil.aspx.cs" Inherits="modulos_Perfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<!---------------------->
<div class="card shadow p-3 mb-5 bg-body rounded">
        <div class="">
        <h3><strong>Mis datos</strong></h3>
        </div>
        <br />        
        <div class="card-body">
        <div class="col-md-12">
                <div class="row">
                    <!-- <span><%=user%></span> -->
                    <%-- <input type="text" id="txtidIns" value="0" />
                    <input type="text" id="txtidDep" value="0" />
                    <input type="text" id="txtidEst" value="0" /> --%>
                    <input type="text" id="txtidUsu" value="0" hidden/>
                    <div class="form-group col-md-6">
                        <label for="txtNombre" class="">Nombre:</label>
                        <input type="text" id="txtNombre" class="form-control" onkeypress="isNumberKey();">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="txtApellidos" class="">Apellidos:</label>
                        <input type="text" id="txtApellidos" class="form-control">
                    </div>
                    <%-- <div class="form-group col-md-6 mt-3">
                        <label for="txtTipo" class="">Institución:</label>
                        <select class="form-select" id="inputInstitucion" onchange="cargarDependencia();">
                            <option value="0">- Seleccionar -</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6 mt-3">
                        <label for="txtAutor" class="">Dependencia:</label>
                        <select class="form-select" id="inputDependencia">
                            <option value="0">Seleccione una institución</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6 mt-3">
                        <label for="txtTipo" class="">Estado:</label>
                        <select class="form-select" id="inputEstado" onchange="cargarCiudad();">
                            <option value="0">- Seleccionar -</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6 mt-3">
                        <label for="txtAutor" class="">Ciudad:</label>
                        <select class="form-select" id="inputCiudad">
                            <option value="0">Seleccione un estado</option>
                        </select>
                    </div> --%>
                    <div class="form-group col-md-6 mt-3">
                        <label for="txtCurp" class="">CURP:</label>
                        <input type="text" id="txtCurp" class="form-control">
                    </div>
                    <div class="form-group col-md-6 mt-3">
                        <label for="txtTelefono" class="">Teléfono:</label>
                        <input type="number" id="txtTelefono" class="form-control" maxlength = "10">
                    </div>      
                    <div class="form-group col-md-6 mt-3">
                        <label for="txtContraseña" class="">Contraseña:</label>
                        <input type="password" id="txtContraseña" class="form-control">
                    </div>
                    <div class="form-group col-md-6 mt-3">
                        <label for="txtContraseña" class="">Confirmar contraseña:</label>
                        <input type="password" id="txtContraseñaDos" class="form-control">
                    </div>                    
                    <div class="col-md-12 mt-4">
                        <a type="button" class="btn  btn-secondary" href="administrador/ediciones.aspx" style="float: right;">Regresar</a>
                        <button type="button" class="btn  btn-primary" onclick="GuardarSeccion();" style="float: right; margin-right: 10px;">Actualizar</button>                        
                    </div>
                </div>            
        </div>        
    </div>

    <script>
    window.onload = function () {
        ModificarUsuario();
        }

    function ModificarUsuario() {
            idUsuario = <%=user%>;
            $.ajax({
                type: 'POST',
                url: 'perfil.aspx/modusuario',
                data: "{'id':'" + idUsuario + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                }, success: function (informacion) {
                    var jsonD = $.parseJSON(informacion.d);
                    $('#txtidUsu').val(idUsuario);
                    $('#txtNombre').val(jsonD.nom);
                    $('#txtApellidos').val(jsonD.apell);
                    $('#txtTelefono').val(jsonD.tel);
                    $('#txtTipo').val(jsonD.idT);
                    $('#txtEmail').val(jsonD.eml);
                    $('#txtContraseña').val(jsonD.contra);
                    $('#txtCurp').val(jsonD.cp);
                }
            });
        }

        function GuardarSeccion() {
            var idUsu = $('#txtidUsu').val();
            var nombre = $('#txtNombre').val();
            var apellidos = $('#txtApellidos').val();
            var telefono = $('#txtTelefono').val();
            var contrasena = $('#txtContraseña').val();
            var contrasenaDos = $('#txtContraseñaDos').val();
            var curp = $('#txtCurp').val();

            if (nombre == "" || apellidos == "" || telefono == "" || contrasena == "" || curp == "") {
                PNotify.notice({
                    text: 'Porfavor complete los campos.',
                    delay: 2500,
                    styling: 'bootstrap3'
                });
                return;
            }

            
            if (telefono.length != 10) {
        PNotify.notice({
            text: 'El numero telefonico no es valido.',
            delay: 2500,
            styling: 'bootstrap3'
        });
        return;
    }

        if (curp.length != 15) {
        PNotify.notice({
            text: 'El curp ingresado no es valido.',
            delay: 2500,
            styling: 'bootstrap3'
        });
        return;
    }

    if (contrasena != contrasenaDos) {
        PNotify.notice({
            text: 'Las contraseñas deben ser iguales.',
            delay: 2500,
            styling: 'bootstrap3'
        });
        return;
    }
            var obj = {};
            obj.nombre = nombre;
            obj.apellidos = apellidos;
            obj.telefono = telefono;
            obj.contrasena = contrasena;
            obj.id = idUsu;
            obj.curp = curp;
            
            $.ajax({
                type: 'POST',
                url: 'perfil.aspx/ActualizarUsuario',
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        PNotify.success({
                            text: 'El usuario se guardó correctamente.',
                            delay: 2500,
                            styling: 'bootstrap3'
                        });
                    }
                    else if (JsonD.success == 2) {
                        PNotify.success({
                            text: 'El curp ya se encuentra en uso.',
                            delay: 2500,
                            styling: 'bootstrap3'
                        });
                    }
                    }

            });
        }
    
    </script>
        
</asp:Content>

