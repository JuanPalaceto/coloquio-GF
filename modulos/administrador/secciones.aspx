<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="secciones.aspx.cs" Inherits="modulos_administrador_secciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!---------------------->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <div class="">
        <h3><strong>Lista de secciones</strong></h3>
        </div>
        <div>
            <button type="button" class="btn  btn-primary confirmar" onclick="ModalNuevaEdicion();" style="float:left;" >Agregar Nueva Sección</a>
        </div>
        <br />
        <div class="card-body">
        <%-- se genera la tabla --%>
            <div id="generarTabla" class="table-responsive "></div>
            <%-- leyendas --%>
            <div class="row">
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Acciones:</b></li>
                        <li><i class="fa-sharp fa-solid fa-pencil text-info" style="font-size:1.2em;"></i> = Editar sección</li>
                        <li><i class="fa-sharp fa-solid fa fa-trash text-danger" style="font-size:1.2em;"></i> = Eliminar sección</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <script>

        window.onload = function () {
            TablaSecciones();
        }

        function TablaSecciones() {  //aqui se crea la tabla
            $.ajax({
                type: 'POST',
                url: 'secciones.aspx/TablaListarEdiciones',
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
    </script>
</asp:Content>

