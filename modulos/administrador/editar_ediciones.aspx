<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="editar_ediciones.aspx.cs" Inherits="modulos_administrador_editar_ediciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
        table, tr, td, th {
            border: 3px solid white;
            padding: 8px;
        }

        th {
            background-color: #1f6c49;
            color: white;
        }

        td img {
            width: 50px;
        }

        .nohover:hover {
            background-color: #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Ponencias section -->
    <div class="bordercustom">
        <h3><strong>Editar la siguiente edición: V Coloquio</strong></h3>
        <div align="center">
            <ul>
            <tbody>
                <tr>
                    <td nowrap="nowrap" align="center">Edición:</td>
                    <td>
                        <input type="text" id="idEdicion" name="edicion" value="<%=idEdicion%>" size="30" hidden="hidden">
                        <input type="text" id="nombreEdicion" name="edicion" value="<%=Edicion%>" size="30">
                        <br>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center" nowrap="nowrap">&nbsp;</td>
                </tr>
                <br />
                <tr>
                    <td nowrap="nowrap" align="right">Activo:</td>
                    <td><select name="activo">
                    <option value="1">Activado</option>
                    <option value="0" selected="">Desactivado</option>
                    </select>
                    </td>
                </tr>
                <br />
                <br />
                    <div class="text-center"><a class="btn btn-primary btn-block" href="ediciones.aspx" style="width: 25%;" onclick="ActualizarEdicion(<%=idEdicion%>)">Guardar cambios</a></div>
            </tbody>
            </ul>
        </div>   
    </div>
    <br />

    <script>
        
        function ActualizarEdicion(id){
            var UpEdicion=$("#nombreEdicion").val();
            $.ajax({
                type: 'POST',
                url: 'editar_ediciones.aspx/ModificarEdicion',
                data: "{'id':'" + id + "','newEdicion':'"+ UpEdicion +"'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function () {
                    window.location.href = "ediciones.aspx";
                }
            });
        };
    </script>

</asp:Content>

