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
                        <li><i class="fa-sharp fa-solid fa-check text-success" style="font-size:1.2em;"></i> = Aprobada</li>
                        <li><i class="fa-sharp fa-solid fa-xmark text-danger" style="font-size:1.2em;"></i> = Rechazada</li>
                        <li><i class="fa-sharp fa-solid fa-hourglass-half" style="font-size:1.2em;"></i> = No evaluada</li>
                    </ul>
                </div>
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Acciones:</b></li>
                        <li><i class="fa-sharp fa-solid fa-pencil text-info" style="font-size:1.2em;"></i> = Editar ponencia</li>
                        <li><i class="fa-sharp fa-solid fa-user-pen text-success" style="font-size:1.2em;"></i> = Editar autores</li>
                        <li><i class="fa-sharp fa-solid fa fa-download" style="font-size:1.2em;color: var(--bs-gray-600);"></i> = Descargar ponencia</li>
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
                        window.location.href = "ponencias_registrar.aspx";
            //        }
            //    }
            //});
        };

        function editarAutores(id){
            $.ajax({
                type: 'POST',
                url: 'ponencias_listar.aspx/editarAutores',
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var jsonD = $.parseJSON(valor.d);
                    if(jsonD.Success == 1){
                        window.location.href = "ponencias_autores.aspx";
                    }
                }
            });
        }
    </script>

</asp:Content>

