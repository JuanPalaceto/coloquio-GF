<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="editar_usuarios.aspx.cs" Inherits="modulos_administrador_editar_usuarios" %>

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
                        <h3 style="text-align:left"><strong>Editar el siguiente usuario: Francisco Adán Reyes Guerra</strong></h3>
                        <h3 style="text-align:left"><strong>nombre de usuario: 2123048267</strong></h3>
                        
          <table width="500" align="center">
            <tbody><tr valign="baseline">
              <td nowrap="nowrap" align="right">Tipo de usuario:</td>
              <td><select name="tipo_id">
                <option value="1">Super Administrador</option>
                <option value="2">Administrador</option>
                <option value="3">Evaluador</option>
                <option value="4" selected="selected">Usuario</option>
                </select>
              </td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Nombre:</td>
              <td><input type="text" name="nombre" value="Francisco Adán" size="32">
                <br>
              </td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Apellidos:</td>
              <td><input type="text" name="apellidos" value="Reyes Guerra" size="32">
                <br>
              </td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Grado academico maximo:</td>
              <td><input name="grado" type="text" id="grado" value="Maestría" size="32">
                <br>
              </td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Institución:</td>
              <td><input type="text" name="institucion" value="UAT" size="32">
                <br>
              </td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Dependencía:</td>
              <td><input name="dependencia" type="text" id="dependencia" value="FCAV" size="32"></td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Dirección:</td>
              <td><input type="text" name="direccion" value="33 y 34 Berriozabal #1661" size="32"></td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Código postal:</td>
              <td><input type="text" name="codigo_postal" value="87037" size="32"></td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Ciudad:</td>
              <td><input type="text" name="ciudad" value="Victoria" size="32"></td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Pais:</td>
              <td><input type="text" name="pais" value="México" size="32"></td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Telefono:</td>
              <td><input type="text" name="telefono" value="8341652364" size="32"></td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Email:</td>
              <td><input type="text" name="email" value="franciscoadanrg@gmail.com" size="32">
                <br>
              </td>
            </tr>
            <tr valign="baseline">
              <td nowrap="nowrap" align="right">Activo:</td>
              <td><select name="activo">
                <option value="1" selected="">Activo</option>
                <option value="0">Bloqueado</option>
              </select>        </td>
            </tr>
            <tr valign="baseline">
            </tr>
          </tbody></table>
          <input type="hidden" name="MM_update" value="form1">
          <input type="hidden" name="username" value="2123048267">
      </div>
      <div class="text-center"><a class="btn btn-primary btn-block" href="usuarios.aspx" style="width: 25%;">Guardar cambios</a></div>
    
    </asp:Content>