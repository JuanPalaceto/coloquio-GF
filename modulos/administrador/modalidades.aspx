<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="modalidades.aspx.cs" Inherits="modalidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <!-- Modal -->
 <div class="modal fade" id="modalModalidad" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title h4">Modalidades</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" ><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="col-md-12">
                            <div class="row">
                                <input type="text" id="txtidMod" value="0" hidden />
                            <div class="form-group col-md-6">
                                <label for="txtmodalidad">Modalidad:</label>
                                <input type="text" class="form-control" id="txtmodalidad">
                            </div>
                            <br /><br />
                            <div class="col-md-12 modal-footer">
                                <button type="button" class="btn  btn-primary" onclick="GuardarModalidad();" style="float: right; margin-left: 10px;">Guardar</button>
                                <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Editar -->
    <!-- <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="myLargeModalLabel21">Editar Modalidad</h3>
                <button type="button" class="close" data-bs-dismiss="modal" ><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">                    
                <div class="form-group">
                    <label nowrap="nowrap" align="center">Tema:</label>
                    <input type="text" id="idTema" name="tema" value="" size="30" hidden="hidden">
                    <input class="form-control" type="text" id="nombreTema" name="tema" value="" size="50">
                    <br>
                </div>
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn  btn-primary confirmar" data-bs-dismiss="modal" style="float: right; margin-left: 5px;">Confirmar</button>
                <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cancelar</button>
            </div>
        </div> -->

    <!-- Modal Eliminar -->
    <div id="modaldel" class="modal fade bd-modal-del" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="myLargeModalLabel21">ELIMINAR</h3>
                    <button type="button" class="close" data-bs-dismiss="modal" ><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <h4>¿Está seguro de eliminar la Modalidad <strong>COMPLETA?</strong></h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn  btn-primary eliminar" data-bs-dismiss="modal" style="float: right; margin-left: 5px;">Confirmar</button>
                    <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <div class="">
        <h3><strong>Lista de Modalidades</strong></h3>
        </div>
        <div>
            <button type="button" class="btn  btn-primary confirmar" onclick="AgregarModalidad();" style="float:left;" >Agregar Nueva Modalidad</a>
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
                        <li><i class="fa-sharp fa-solid fa-pencil text-info" style="font-size:1.2em;"></i> = Editar modalidad</li>
                        <li><i class="fa-sharp fa-solid fa fa-trash text-danger" style="font-size:1.2em;"></i> = Eliminar modalidad</li>
                    </ul>
                </div>
            </div>
        </div>        
    </div>
        
        
        <script>
            window.onload = function () {
                TablaUsu();
            }

            function TablaUsu() {  //aqui se crea la tabla
                $.ajax({
                    type: 'POST',
                    url: 'modalidades.aspx/TablaListarModalidades',
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

            function AgregarModalidad() {
            $('#modalModalidad').modal('show');
        }

            function GuardarModalidad() {
            var idMod = $('#txtidMod').val();
            var Modalidad = $('#txtModalidad').val();
            var edicion = $('#ddledicion').val();

                if (Modalidad == "" || edicion == 0) {
                    PNotify.notice({
                        text: 'Porfavor complete los campos.',
                        delay: 2500,
                        styling: 'bootstrap3'
                    });
                    return;
                }

            var obj = {};
            obj.Modalidad = Modalidad;
            obj.edicion = edicion;
            obj.id = idMod;

            if (idMod == 0) {
                var url = 'modalidades.aspx/GuardarModalidad';
            }
            else {
                var url = 'modalidades.aspx/ActualizarModalidad';
            }
            $.ajax({
                type: 'POST',
                url: url,
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
                            text: 'La informacion se guardo correctamente.',
                            delay: 2500,
                            styling: 'bootstrap3'
                        });
                        $('#modalModalidad').modal('hide');
                        TablaModalidades();
                        Limpia();
                    }
                    else if (JsonD.success == 2) {
                        PNotify.notice({
                            text: 'La Modaliad ya existe, intente con otro nombre.',
                            delay: 2500,
                            styling: 'bootstrap3'
                        });
                    }
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

            function ModalNuevaModalidad() {
                $("#modalNuevaEdi").modal('show');
            }

            function ModalEditar(idModalidad, Modalidad) {
                $("#modaledit").modal('show');
                var id = idModalidad;
                var Modalidad = Modalidad;
                $("#idModalidad").val(id);
                $("#nombreModalidad").val(Modalidad);
                $(".confirmar").attr("id", "" + id + "");
                $(".confirmar").attr("onclick", "ActualizarModalidad(" + id + ");");
            };

            function ActualizarModalidad(id) {
                var UpModalidad = $("#nombreModalidad").val();
                $.ajax({
                    type: 'POST',
                    url: 'editar_modalidades.aspx/ModificarModalidad',
                    data: "{'id':'" + id + "','newModalidad':'" + UpModalidad + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                    },
                    success: function () {
                        TablaUsu();
                        console.log("Se actualizo");
                        PNotify.success({
                            text: 'La modalidad se actualizo correctamente.',
                            delay: 3000,
                            addClass: 'translucent'
                        });
                    }
                });
            };

            function ConfirmarEliminar(idModalidad) {
                $("#modaldel").modal('show');
                var id = idModalidad;
                $(".eliminar").attr("id", "" + id + "");
                $(".eliminar").attr("onclick", "borrarModalidad(" + id + ");");
            };

            function borrarModalidad(id) {
                var idModalidad = id;
                $.ajax({
                    type: 'POST',
                    url: 'modalidades.aspx/borrarModalidad',
                    data: "{'id':'" + idModalidad + "'}",
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
                                text: 'La modalidad se eliminó correctamente.',
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

            function alternarActivo(id) {
                $.ajax({
                    type: 'POST',
                    url: 'modalidades.aspx/alternarActivo',
                    data: "{'id':'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("Error" + jqXHR.responseText);
                    },
                    success: function (valor) {
                        var JsonD = $.parseJSON(valor.d)
                        console.log(JsonD);
                        if (JsonD.success == 1) {
                            TablaUsu();
                        }
                    }
                });
            };

        </script>
</asp:Content>