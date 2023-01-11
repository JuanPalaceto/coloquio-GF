<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="editar_modalidades.aspx.cs" Inherits="modulos_administrador_editar_modalidades" %>

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
                        <h3><strong>Editar la siguiente modalidad: Ponencia</strong></h3>
                        <div align="center">
                                <ul>
                                    <tbody>
                                        <tr>
                                            <td nowrap="nowrap" align="center">Modalidad:</td>
                                            <td>
                                                <input type="text" name="edicion" value="Ponencia" size="30">
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
                                            <option value="1">Desactivado</option>
                                            <option value="0" selected="">Activado</option>
                                            </select>
                                            </td>
                                        </tr>
                                        <br />
                                        <br />
                                        <div class="text-center"><a class="btn btn-primary btn-block" href="modalidades.aspx" style="width: 25%;">Guardar cambios</a></div>
                                    </tbody>
                                </ul>
                        </div>   
                    </div>
                    <br />
</asp:Content>

