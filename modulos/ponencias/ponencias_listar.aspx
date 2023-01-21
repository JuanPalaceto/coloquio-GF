<%@ Page Title="Coloquio - Listar Ponencias" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="ponencias_listar.aspx.cs" Inherits="ponencias_listar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Mis Ponencias -->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <div class="">
            <h3><strong>Mis ponencias</strong></h3>
        </div>
        <div class="card-body">
            <br>
            <div id="generarTabla" class="table-responsive"></div>
            <br>
            <%-- leyendas --%>
            <div class="row">
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Estados:</b></li>                        
                        <li><i class="fa-solid fa-list-check text-secondary" style="font-size:1.2em;"></i> = Registro incompleto</li>                        
                        <li><i class="fa-regular fa-file-lines" style="font-size:1.2em;"></i> = Registrada</li>
                        <li><i class="fa-regular fa-hourglass-half" style="font-size:1.2em;"></i> = En evaluación</li>
                        <li><i class="fa-sharp fa-solid fa-check text-success" style="font-size:1.2em;"></i> = Aprobada</li>
                        <li><i class="fa-sharp fa-solid fa-xmark text-danger" style="font-size:1.2em;"></i> = Rechazada</li>
                    </ul>
                </div>
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Acciones:</b></li>
                        <li><i class="fa-sharp fa-solid fa-pencil text-info" style="font-size:1.2em;"></i> = Editar ponencia</li>
                        <li><i class="fa-sharp fa-solid fa-trash text-danger" style="font-size:1.2em;"></i> = Eliminar ponencia</li>
                        <%-- <li><i class="fa-sharp fa-solid fa fa-download" style="font-size:1.2em;color: var(--bs-gray-600);"></i> = Descargar ponencia</li> --%>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <!--- Modal --->
    <div id="modaldel" class="modal fade bd-modal-del" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="myLargeModalLabel21">Eliminar Ponencia</h3>
                    <button type="button" class="close" data-bs-dismiss="modal" ><span aria-hidden="true">&times;</span></button>
                </div>
                <div class="modal-body">
                    <h4>¿Está seguro de eliminar la ponencia?</h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn  btn-primary eliminar" data-bs-dismiss="modal" style="float: right; margin-left: 5px;">Confirmar</button>
                    <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cancelar</button>
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
                url: 'ponencias_listar.aspx/TablaListarPonencias',
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

        function editarPonencia(id){
            //$.ajax({
            //    type: 'POST',
            //    url: 'ponencias_listar.aspx/editarPonencia',
            //    data: "{'id':'" + id + "'}",
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    error: function (jqXHR, textStatus, errorThrown) {
            //        console.log("Error" + jqXHR.responseText);
            //    },
            //    success: function (valor) {
            //        var jsonD = $.parseJSON(valor.d);
            //        if (jsonD.Success == 1) {
                        // Para comprobar si se va a editar o no
                        localStorage.setItem('activePillId', 'pills-1');
                        localStorage.setItem('idActual', id);
                        localStorage.setItem('estadoRegistro', 1);
                        window.location.href = "ponencias_registrar.aspx";
            //        }
            //    }
            //});
        };        

        function ConfirmarEliminar(idPonencia) {
            $("#modaldel").modal('show');
            var id = idPonencia;
            $(".eliminar").attr("id", "" + id + "");
            $(".eliminar").attr("onclick", "borrarPonencia(" + id + ");");
        };

        function borrarPonencia(id) {        
            $.ajax({
                type: 'POST',
                url: 'ponencias_listar.aspx/borrarPonencia',
                data: "{'id':'" + id + "'}",
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
                            text: 'La ponencia se eliminó correctamente.',
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

