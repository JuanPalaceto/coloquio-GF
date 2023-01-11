<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="temas.aspx.cs" Inherits="temas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   <!-- Ponencias section -->
                        <div class="bordercustom">
                            <h3><strong>Crear nuevo tema:</strong></h3>
                            <%--<div align="center">--%>
                                <%--<ul>

                                </ul>--%>
                                <%--<div class="text-center"><a class="btn btn-primary btn-block" href="ponencias_registrar_3.aspx" style="width: 25%;">Agregar</a></div>
                                <br>
                            </div>--%>
                        </div>
                        <div>
                             <button type="button" class="btn  btn-primary confirmar" onclick="ModalNuevoTema();" style="float:left;" >Agregar Nuevo Tema</a>
                        </div>
                        <br>
                        <br />
                        <div class="bordercustom">
                             <br />
                            <br />
                            <h3><strong>Lista de temas:</strong></h3>

                            <div>
                                <div id="tablatemas"></div>
                            </div>
                            <br>
                        </div>

    <div id="modalNuevoTema" class="modal fade bd-modal-del" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <!---Modal content--->
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Elija una de las Opciones:</h3>
                    <button type="button" class="close" data-bs-dismiss="modal" ><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col col-6 m-1 card">
                            <asp:label text="Tema:" runat="server" />
                            <input type="text" name="tema" class="form-control" value="" size="30">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn  btn-primary confirmar" data-bs-dismiss="modal" style="float: right; margin-left: 5px;">Confirmar</button>
                    <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
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
                        <li><i class="fa-sharp fa-solid fa-pencil text-info" style="font-size:1.2em;"></i> = Editar tema</li>
                        <li><i class="fa-sharp fa-solid fa fa-trash text-danger" style="font-size:1.2em;"></i> = Eliminar tema</li>
                    </ul>
                </div>
            </div>

    <script>
        window.onload = function () {
            TablaTemas();
        }
        function TablaTemas() {  //aqui se crea la tabla
            $.ajax({
                type: 'POST',
                url: 'temas.aspx/TablaListarTemas',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (tabla) {
                    $("#tablatemas").html(tabla.d); //nombre del id del div de la tabla
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
        function ModalNuevoTema() {
            $("#modalNuevoTema").modal('show');
        }
        function alternarActivo(id) {
            $.ajax({
                type: 'POST',
                url: 'temas.aspx/alternarActivo',
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
                        TablaTemas();
                    }
                }
            });
        };

        // Editar
        function ModalEditar(idTema, tema) {
            $("#modaledit").modal('show');
            var id = idTema;
            var tema = tema;
            $("#idTema").val(id);
            $("#tema").val(tema);
            $(".confirmar").attr("id", "" + id + "");
            $(".confirmar").attr("onclick", "ActualizarTema(" + id + ");");
        };
        function ActualizarTema(id){
            var UpTema=$("#nombreTema").val();
            $.ajax({
                type: 'POST',
                url: 'editar_temas.aspx/ModificarTema',
                data: "{'id':'" + id + "','newTema':'"+ UpTema +"'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function () {
                    TablaTemas();
                    console.log("Se actualizo");
                    PNotify.success({
                        text: 'El tema se actualizo correctamente.',
                        delay: 3000,
                        addClass: 'translucent'
                    });
                }
            });
        };

        // Eliminar
        function ConfirmarEliminar(idTema) {
            $("#modaldel").modal('show');
            var id = idTema;
            $(".eliminar").attr("id", "" + id + "");
            $(".eliminar").attr("onclick", "borrarTema(" + id + ");");
        };
        function borrarTema(id) {
        var idTema = id;
            $.ajax({
                type: 'POST',
                url: 'temas.aspx/borrarTema',
                data: "{'id':'" + idTema + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        TablaTemas();
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
    </script>
</asp:Content>
