<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="parametros.aspx.cs" Inherits="modulos_administrador_parametros" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<!---------------------->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <div class="">
        <h3><strong>Lista de parametros</strong></h3>
        </div>
        <div>
            <button type="button" class="btn btn-primary" onclick="AgregarParametro();Limpia();" style="float:left;" >Agregar Nuevo Parametro</button>
        </div>
        <br />        
        <div class="card-body">
        <!-- Tabla de secciones -->
            <div id="tabparametros" class="table-responsive "></div>            
            <!-- Leyenda de los botones -->
            <div class="row">
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Acciones:</b></li>
                        <li><i class="fa-sharp fa-solid fa-pencil text-info" style="font-size:1.2em;"></i> = Editar parametro</li>
                        <li><i class="fa-sharp fa-solid fa fa-trash text-danger" style="font-size:1.2em;"></i> = Eliminar parametro</li>
                    </ul>
                </div>
            </div>
        </div>        
    </div>

    <script>

    window.onload = function () {
            TablaParametros();
        }

        //Se crea la tabla
        function TablaParametros() {  
            $.ajax({
                type: 'POST',
                url: 'parametros.aspx/TablaListarParametros',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (tabla) {
                    $("#tabparametros").html(tabla.d); //id del div de la tabla
                    setTimeout(function myfunction() {
                        estiloDataTable();
                    }, 100);
                }
            });
        }

    </script>
</asp:Content>