<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="editar_contraseña.aspx.cs" Inherits="modulos_administrador_editar_contraseña" %>

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
    <div class="bordercustom">
                        <div align="center">
                        <h3 style="text-align:left"><strong>Cambiar contraseña: Francisco Adán Reyes Guerra</strong></h3>
                        <br />
        <tbody>
            <tr>
          <td nowrap="nowrap" align="right">Contraseña:</td>
          <td><input type="password" name="password" size="32">
            <br>
            </td>
        </tr>
        <tr>
          <td nowrap="nowrap" align="right">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <br />
        <br />
            <tr>
          <td nowrap="nowrap" align="right">Confirmar: &nbsp;</td>
          <td><input name="confirmar" type="password" id="confirmar" size="32">
            <br>
            </td>
        </tr>
        <tr>
          <td nowrap="nowrap" align="right">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        </tbody>

      <div class="text-center"><a class="btn btn-primary btn-block" href="usuarios.aspx" style="width: 25%;">Guardar cambios</a></div>

    </asp:Content>