<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="usuarios_editar.aspx.cs" Inherits="modulos_administrador_usuarios_editar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="card shadow p-3 mb-5 bg-body rounded">
        <h3><strong>Modificacion de usuarios: <span id="titulolbl"></span></strong></h3>
        <br> 
        <td><div class="row mb-2 g-3 align-items-center">
            <label for="txtAutor" class="offset-3 col-sm-1 col-form-label text-end">Nombre:</label>                    
            <div class="col-4">
                <input type="text" id="txtNombre" class="form-control">
            </div>
        </div>
        </table>
        <div class="row mb-2 g-3 align-items-center">
            <label for="txtInstitucion" class="offset-3 col-sm-1 col-form-label text-end">Apellidos:</label>                    
            <div class="col-4">
                <input type="text" id="txtApellidos" class="form-control">
            </div>
        </div>
        <div class="row g-3 mb-2 align-items-center">                    
            <label for="txtTipo" class="offset-3 col-sm-1 col-form-label text-end">Institucion:</label>     
            <div class="col-4">
                <asp:DropDownList class="form-select" ID="txtInstitucion" ClientIDMode="Static" runat="server"></asp:DropDownList>
            </div>                    
        </div>
        <div class="row mb-2 g-3 align-items-center">
            <label for="txtAutor" class="offset-3 col-sm-1 col-form-label text-end">Dependencia:</label>                    
            <div class="col-4">
                <asp:DropDownList class="form-select" ID="txtDependencia" ClientIDMode="Static" runat="server"></asp:DropDownList>
            </div>
        </div>
        <div class="row mb-2 g-3 align-items-center">
            <label for="txtAutor" class="offset-3 col-sm-1 col-form-label text-end">Direccion:</label>                    
            <div class="col-4">
                <input type="text" id="txtDireccion" class="form-control">
            </div>
        </div>
        <div class="row mb-2 g-3 align-items-center">
            <label for="txtAutor" class="offset-3 col-sm-1 col-form-label text-end">Ciudad:</label>                    
            <div class="col-4">
                <input type="text" id="txtCiudad" class="form-control">
            </div>
        </div>
        <div class="row mb-2 g-3 align-items-center">
            <label for="txtAutor" class="offset-3 col-sm-1 col-form-label text-end">Telefono:</label>                    
            <div class="col-4">
                <input type="text" id="txtTelefono" class="form-control">
            </div>
        </div>
         <div class="row g-3 mb-2 align-items-center">                    
            <label for="txtTipo" class="offset-3 col-sm-1 col-form-label text-end">Tipo:</label>     
            <div class="col-4">
                <asp:DropDownList class="form-select" ID="txtTipo" ClientIDMode="Static" runat="server"></asp:DropDownList>
            </div>                    
        </div>
        <div class="row mb-2 g-3 align-items-center">
            <label for="txtAutor" class="offset-3 col-sm-1 col-form-label text-end">Email:</label>                    
            <div class="col-4">
                <input type="text" id="txtEmail" class="form-control">
            </div>
        </div>
        <div class="row mb-2 g-3 align-items-center">
            <label for="txtAutor" class="offset-3 col-sm-1 col-form-label text-end">Contraseña:</label>                    
            <div class="col-4">
                <input type="text" id="txtContraseña" class="form-control">
            </div>
        </div>
        <div class="text-center"><a class="btn btn-primary btn-block" style="width: 25%;">Modificar</a></div>
        <script>
     function ModificarUsuario(ctrl) {
            var id = ctrl;
            $.ajax({
                type: 'POST',
                url: 'editar_usuarios.aspx/selidusuario',
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                }, success: function (informacion) {
                    var jsonD = $.parseJSON(informacion.d);
                    <%-- $('#txtidSec').val(id); --%>
                    $('#txtNombre').val(jsonD.nom);
                    $('#txtApellidos').val(jsonD.apell);
                    $('#txtInstitucion').val(jsonD.inst);
                    $('#txtDependencia').val(jsonD.depen);
                    $('#txtCiudad').val(jsonD.ciud);
                    $('#txtTelefono').val(jsonD.tel);
                    $('#id').val(jsonD.txtTipo);
                    $('#txtEmail').val(jsonD.eml);
                    $('#txtContraseña').val(jsonD.contra);

                }
            });
        }
    </script>
</asp:Content>

