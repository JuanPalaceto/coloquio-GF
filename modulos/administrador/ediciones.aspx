<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="ediciones.aspx.cs" Inherits="ediciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>

        .contain{
            display: flex;
            justify-content:center;
            align-items:center;
        }

        .radio-tile-group{
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .input-container{
            position: relative; 
            height: 14rem;
            width: 14rem;
            margin: 0.5rem;
        }

        .input-container input{
            position: absolute;
            height: 100%;
            width: 100%;
            margin: 0;
            cursor: pointer;
            z-index: 2;
            opacity: 0;
        }

        .input-container .radio-tile{
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            border: 2px solid #858585;
            border-radius: 8px;
            transition: all 300ms ease;
        }

        /*.input-container label{
            font-size: 0.80rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }*/

        .radio-tile label{
            position: relative;
            bottom: 30px;
            left: 10px;
        }

        input:checked + .radio-tile{
            /*background-color: #217cb188;*/
            box-shadow: 0 0 16px #217cb188;
            border: 2px solid #217cb188;
        }

        input:hover + .radio-tile{
            border: 2px solid #217cb188;
            box-shadow: 0 0 16px #217cb188;
        }
        /*.lab1{
            height: 250px;
            width: 300px;
            position: relative;
            color: rgb(0, 0, 0);
            border: 2px solid #000000;
            padding: 10px;
            border-radius: 5px;
            transition: 0.3s;
            cursor: pointer;
        }

        .lab1 input:checked {
            background-color: #005c00;
        }

        .lab1:hover{
            border: 10px;
            opacity: 1;
            border-color: #269916;
        }


        input[type="radio"]:checked + label{
            background-color: #005c00;
            color: #01cc65;
            opacity: 1;
        }

        input[type="radio"]:checked + label::before{
            height: 16px;
            width: 16px;
            border: 10 px solid rgb(0, 0, 0);
            background-color: #01cc65;
        }*/

        /*.op{
            border-color: white;
            background-color:white;
            opacity: 0.6;
            transition: 0.4s;
        }

        .op:hover{
            border: 10px;
            opacity: 1;
            border-color: #9c9c9c;
            background-color:#ffffff;
        }*/
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%-- ---- modal ------- --%>
    <!--- Modal --->
    <div id="modaldel" class="modal fade bd-modal-del" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="myLargeModalLabel21">ELIMINAR</h3>
                    <button type="button" class="close" data-bs-dismiss="modal" ><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <h4>¿Está seguro de eliminar la Edicion <strong>COMPLETA?</strong></h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn  btn-primary eliminar" data-bs-dismiss="modal" style="float: right; margin-left: 5px;">Confirmar</button>
                    <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    <%-- ------------------ --%>

    <%-- ---- modal ediciones ------- --%>
    <!--- Modal --->
    <div id="modaledit" class="modal fade bd-modal-del" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="myLargeModalLabel21">Editar Edición</h3>
                    <button type="button" class="close" data-bs-dismiss="modal" ><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    
                    <div class="form-group">
                        <label nowrap="nowrap" align="center">Edición:</label>
                        <input type="text" id="idEdicion" name="edicion" value="" size="30" hidden="hidden">
                        <input class="form-control" type="text" id="nombreEdicion" name="edicion" value="" size="30">
                        <br>
                    </div>
                    <br />
                    <select name="activo">
                        <option value="1">Activado</option>
                        <option value="0" selected="">Desactivado</option>
                    </select>
                            
                        <br />
                        <br />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn  btn-primary confirmar" data-bs-dismiss="modal" style="float: right; margin-left: 5px;">Confirmar</button>
                    <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    <%-- ------------------ --%>

    <%-----------ModalNuevaEdicion-----------%>
    <div id="modalNuevaEdi" class="modal fade bd-modal-del" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <!---Modal content--->
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Agregar Nueva Edicion:</h3>
                    <button type="button" class="close" data-bs-dismiss="modal" ><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <br>
                    <div align="center">
                        <label nowrap="nowrap">Nombre de la Edicion: </label>
                        <input  id="nombreEdi" class="form" type="text" name="edicion" value="" size="30">
                    </div>
                    <br>
                    <hr>
                    <label>Elija una de las opciones para crear la nueva edicion:</label>
                    <br>
                    <br>
                    <!------------------------------------------->
                    <!------------------------------------------->
                    <div class="row contain">
                        <div id="opcion1" class="radio-tile-group">
                            <div class="form-check input-container">
                                <input class="form-check-input" type="radio" name="radio" id="walk" value="1">
                                <div class="radio-tile">
                                    <label for="walk">Plantilla de Parametros Predeterminada:</label>
                                    <img name="walk" src="google-docs.png" class="img-thumbnail" style="width: 100px;" alt="">
                                </div>                                
                            </div>
                        
                            <div class="form-check input-container">
                                <input class="form-check-input" type="radio" name="radio" id="run" value="2">
                                <div class="radio-tile">
                                    <label for="run">Plantilla de Parametros Nueva: </label>
                                    <img name="run" src="expediente.png" class="img-thumbnail" style="width: 100px;" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn  btn-primary" data-bs-dismiss="modal" style="float: right; margin-left: 5px;" onclick="Plantilla();">Confirmar</button>
                    <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    <%-------------%>

    <%-----------ModalEdicion-----------%>
    <div id="ModalEdicion" class="modal fade bd-modal-del" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <!---Modal content--->
            <div class="modal-content">
                <div class="modal-header">
                    <h3><b>Previsualizacion </b></h3>
                    <button type="button" class="close" data-bs-dismiss="modal" ><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <br>
                    <!--Se genera tabla-->
                    <div id="DatosEdicion" class="table-responsive"></div> 
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn  btn-primary" data-bs-dismiss="modal" style="float: right; margin-left: 5px;" onclick="GuardarEdicion();">Continuar</button>
                    <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;" onclick="ModalNuevaEdicion();">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    <%----------------------%>
   <!-- 
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <div class="">
            <h3><strong>Crear nueva edición</strong></h3>
        </div>
        <br>
        <div class="card-body">
            <div align="center">
                <ul>
                    <tbody>
                        <tr>
                            <td nowrap="nowrap" align="center">Edición:</td>
                            <td>
                                <input type="text" name="edicion" value="" size="30">
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" nowrap="nowrap">&nbsp;</td>
                        </tr>
                        <br />
                        <tr>
                            <td colspan="2" align="center" nowrap="nowrap">
                                <input type="hidden" name="MM_insert" value="form1">
                                <div class="text-center"><a class="btn btn-primary btn-block" href="modulos\ponencias\ponencias_registrar.aspx" style="width: 27%;">Agregar</a></div>
                                <br>
                            </td>
                        </tr>
                    </tbody>
                </ul>
            </div>   
        </div>
    </div-->

    <!---------------------->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <div class="">
        <h3><strong>Lista de ediciones</strong></h3>
        </div>
        <div>
            <button type="button" class="btn  btn-primary" onclick="ModalNuevaEdicion();" style="float:left;" >Agregar Nueva Edicion</a>
        </div>
        <br />        
        <div class="card-body">
        <%-- se genera la tabla --%>
            <div id="generarTabla" class="table-responsive "></div>            
            <%-- leyendas --%>
            <div class="row">
                <div class="col-auto">                
                    <ul class="list-unstyled">
                        <li><b>Estados:</b></li>
                        <li><i class="fa-sharp fa-solid fa-check text-success" style="font-size:1.2em;"></i> = Activa</li>
                        <li><i class="fa-sharp fa-solid fa-ban" style="font-size:1.2em;color: var(--bs-gray-600);"></i> = Inactiva</li>
                    </ul>
                </div>
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Acciones:</b></li>
                        <li><i class="fa-sharp fa-solid fa-pencil text-info" style="font-size:1.2em;"></i> = Editar edición</li>
                        <li><i class="fa-sharp fa-solid fa fa-trash text-danger" style="font-size:1.2em;"></i> = Eliminar edición</li>
                    </ul>
                </div>
            </div>
        </div>        
    </div>
        <script>
        window.onload = function(){
            TablaUsu();
        }

        function TablaUsu() {  //aqui se crea la tabla
            $.ajax({
                type: 'POST',
                url: 'ediciones.aspx/TablaListarEdiciones',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (tabla) {
                    $("#generarTabla").html(tabla.d); //nombre del id del div de la tabla
                    setTimeout(function myfunction() {
                        estiloDataTable();
                    }, 100);
                }
            });
        }

        function estiloDataTable(page, leng) {
            $('#tabla').DataTable({
                "lengthMenu": [5, 10, 25, 50, 75, 100],
                "pageLength": leng,
                pagingType: 'numbers',
                "order": [[4, 'asc'], [1, 'asc']],
                language: {
                    "decimal": ".",
                    "emptyTable": "",
                    "info": "Mostrando del _START_ al _END_ de un total de _TOTAL_ registros",
                    "infoEmpty": "",
                    "infoFiltered": "<br/>(Filtrado de _MAX_ registros en total)",
                    "infoPostFix": "",
                    "thousands": ",",
                    "lengthMenu": "Mostrando _MENU_ registros",
                    "loadingRecords": "Cargando...",
                    "processing": "Procesando...",
                    "search": "B&uacute;squeda:",
                    "zeroRecords": "No hay registros",
                }
            });
        };

        /*function editarEdicion(id){     
            $.ajax({
                type: 'POST',
                url: 'ediciones.aspx/editarEdicion',
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function () {
                  
                   
                        window.location.href = "editar_ediciones.aspx";
                        //console.log("Salio");
                }
            });
        };*/

        /*function borrarEdicion(id){            
            $.ajax({
                type: 'POST',
                url: 'ediciones.aspx/borrarEdicion',
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var jsonD = $.parseJSON(valor.d);
                    if(jsonD.Success == 1){
                        TablaUsu();
                    }
                }
            });
        };*/

        function ModalNuevaEdicion(){
            $("#modalNuevaEdi").modal('show');
        }

        function ModalEditar(idEdicion, Edicion) {
            $("#modaledit").modal('show');
            var id = idEdicion;
            var Edicion= Edicion;
            $("#idEdicion").val(id);
            $("#nombreEdicion").val(Edicion);
            $(".confirmar").attr("id", "" + id + "");
            $(".confirmar").attr("onclick", "ActualizarEdicion(" + id + ");");
        };

        function ActualizarEdicion(id){
            var UpEdicion=$("#nombreEdicion").val();
            $.ajax({
                type: 'POST',
                url: 'ediciones.aspx/ModificarEdicion',
                data: "{'id':'" + id + "','newEdicion':'"+ UpEdicion +"'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function () {
                    TablaUsu();
                    console.log("Se actualizo");
                    PNotify.success({
                        text: 'La edicion se actualizo correctamente.',
                        delay: 3000,
                        addClass: 'translucent'
                    });
                }
            });
        };

        function ConfirmarEliminar(idEdicion) {
            $("#modaldel").modal('show');
            var id = idEdicion;
            $(".eliminar").attr("id", "" + id + "");
            $(".eliminar").attr("onclick", "borrarEdicion(" + id + ");");
        };

        function borrarEdicion(id) {
        var idEdicion = id;
            $.ajax({
                type: 'POST',
                url: 'ediciones.aspx/borrarEdicion',
                data: "{'id':'" + idEdicion + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        TablaUsu();
                        PNotify.success({
                            text: 'La edicion se eliminó correctamente.',
                            delay: 3000,
                            addClass: 'translucent'
                        });
                    } else if (JsonD.success == 2) {
                        PNotify.notice({
                            text: 'Algo salió mal.',
                            delay: 3000,
                            addClass: 'translucent'
                        });
                    }
                }
            });
        };

        function alternarActivo(id){            
            $.ajax({
                type: 'POST',
                url: 'ediciones.aspx/alternarActivo',
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    console.log(JsonD);
                    if(JsonD.success == 1){
                        TablaUsu();
                    }
                }
            });
        };

        function Plantilla(){
            var nombreEdi=$("#nombreEdi").val();
            if($("#nombreEdi").val("")){
                console.log("Debe agregar nombre")
            }else{
                if($("#walk").is(":checked")){
                $("#ModalEdicion").modal('show');
                console.log(nombreEdi + "Plantilla predeterminada, Abre Pagina");
                TablaEdicion();
                }else if($("#run").is(":checked")){
                    console.log(nombreEdi + "Plantilla Nueva Seleccionada, Abre Pagina");
                    GuardarEdicion();                
                }
            }
            
        }

        function TablaEdicion() {  //aqui se crea la tabla
            $.ajax({
                type: 'POST',
                url: 'ediciones.aspx/TablaEdicion',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (tabla) {
                    $("#DatosEdicion").html(tabla.d); //nombre del id del div de la tabla
                    setTimeout(function myfunction() {
                        //estiloDataTable2();
                    }, 100);
                }
            });
        }

        function GuardarEdicion(){
            var nombreEdi=$("#nombreEdi").val();
            var opcion;
            if($("#walk").is(":checked")){
                opcion=1;
                $.ajax({
                    type: 'POST',
                    url: 'ediciones.aspx/GuardarEdicion',
                    data: "{'nombre':'" + nombreEdi + "','opcion':'"+ opcion +"'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                    },
                    success: function (valor){
                        var JsonD = $.parseJSON(valor.d)
                        if (JsonD.success == 1) {
                            TablaUsu();
                            PNotify.success({
                                text: 'Edicion guardada correctamente.',
                                delay: 3000,
                                addClass: 'translucent'
                            });
                        } else if (JsonD.success == 0) {
                            PNotify.notice({
                                text: 'Algo salió mal.',
                                delay: 3000,
                                addClass: 'translucent'
                            });
                        } 
                    }
                });

                /*PNotify.success({
                            text: 'Edicion agregada correctamente.',
                            delay: 3000,
                            addClass: 'translucent'
                        });*/
            }else if($("#run").is(":checked")){
                opcion=2
                $.ajax({
                    type: 'POST',
                    url: 'ediciones.aspx/GuardarEdicion',
                    data: "{'nombre':'" + nombreEdi + "','opcion':'"+ opcion +"'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                    },
                    success: function (valor){
                        var JsonD = $.parseJSON(valor.d)
                        if (JsonD.success == 1) {
                            TablaUsu();
                            PNotify.success({
                                text: 'Edicion guardada correctamente.',
                                delay: 3000,
                                addClass: 'translucent'
                            });
                        } else if (JsonD.success == 0) {
                            PNotify.notice({
                                text: 'Algo salió mal.',
                                delay: 3000,
                                addClass: 'translucent'
                            });
                        } 
                    }
                });

                /*PNotify.success({
                            text: 'Edicion agregada correctamente.',
                            delay: 3000,
                            addClass: 'translucent'
                        });*/
            }
            console.log(opcion);

            /*-----Problema de Envio-----
            $.ajax({
                type: 'POST',
                url: 'ediciones.aspx/GuardarEdicion',
                data: "{'nombre':'" + nombreEdi + "','opcion':'"+ opcion +"'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (valor){
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        TablaUsu();
                        PNotify.success({
                            text: 'Edicion guardada correctamente.',
                            delay: 3000,
                            addClass: 'translucent'
                        });
                    } else if (JsonD.success == 0) {
                        PNotify.notice({
                            text: 'Algo salió mal.',
                            delay: 3000,
                            addClass: 'translucent'
                        });
                    } 
                }
            });*/
        }

        </script>
</asp:Content>
