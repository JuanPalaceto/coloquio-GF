<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="editar_temas.aspx.cs" Inherits="modulos_administrador_editar_temas" %>

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
        <h3><strong>Editar el siguiente tema: Tecnologías, innovación y redes de conocimiento</strong></h3>
        <div align="center">
            <ul>
                <tbody>
                    <tr>
                        <td nowrap="nowrap" align="right">Tema:</td>
                        <td><input type="text" name="tema" value="Tecnologías, innovación y redes de conocimiento" size="45">
                        </tr>
                        <br />
                        <br />
                    </td>
                    <tr>
                        <td nowrap="nowrap" align="center">Edición:</td>
                        <td>
                            <select name="tema_id">
                                <option value="4">V Coloquio</option>
                                <option value="5">VI Coloquio</option>
                                <option value="6">VII Coloquio</option>
                                <option value="7">VIII Coloquio</option>
                                <option value="8">IX Coloquio</option>
                                <option value="9" selected="">X Coloquio</option>
                            </select>
                        </td>
                    </tr>
                    <br />
                    <tr>
                        <td colspan="2" align="center" nowrap="nowrap">&nbsp;</td>
                    </tr>
                    <br />
                    <tr>
                        <td nowrap="nowrap" align="right">Activo:</td>
                        <td><select name="activo">
                            <option value="1">Desactivado</option>
                            <option value="0" selected="">Activado</option>
                        </select>
                    </td>
                </tr>
                <br />
                <br />
                <div class="text-center"><a class="btn btn-primary btn-block" href="temas.aspx" style="width: 25%;">Guardar cambios</a></div>
            </tbody>
        </ul>
    </div>
</div>
<br/>
<script>
function ActualizarTema(id){
    var UpTema=$("#nombreTema").val();$.ajax({
        type: 'POST',
        url: 'editar_temas.aspx/ModificarTema',
        data: "{'id':'" + id + "','newTema':'"+ UpTema +"'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        },
        success: function () {
            window.location.href = "temas.aspx";
        }
    });
};
</script>
</asp:Content>
