<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="registro_editar_autor.aspx.cs" Inherits="autores_editar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        table, tr, td, th {
            border: 3px solid white;
            padding: 8px;
        }

        th {
            background-color: #1f6c49;
            color: white;
        }

        tr:hover {
            background-color: #aab3aa;
        }

        td img {
            width: 50px;
        }

        .nohover:hover {
            background-color: #fff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- editar autores -->
    <div class="bordercustom">
        <h3><strong>Modificar el siguiente autor: (nombre del autor)</strong></h3>
        <br>
        <table align="center">
            <tr class="nohover">
                <td align="right">Autor: </td>
                <td>
                    <input type="text" name="titulo" size="40"></td>
            </tr>
            <tr class="nohover">
                <td align="right">Institución: </td>
                <td>
                    <input type="text" name="titulo" size="40"></td>
            </tr>
            <tr class="nohover">
                <td align="right">Tipo de Autor: </td>
                <td>
                    <select name="modalidad">
                        <option value="">Seleccionar</option>
                        <option value="1">Profesor</option>
                        <option value="2">Alumno</option>
                        <option value="3">Tesista</option>
                        <option value="4">Becario</option>
                    </select>
                </td>
            </tr>
        </table>
        <br>
        <div class="text-center"><a class="btn btn-primary btn-block" href="ponencias_registrar_2.aspx" style="width: 25%;">Guardar cambios</a></div>
        <br>
    </div>
    <br>
</asp:Content>

