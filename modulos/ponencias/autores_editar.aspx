<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="autores_editar.aspx.cs" Inherits="autores_editar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- Editar Ponencias -->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        
        <h3><strong>Modificar el autor: <span id="titulolbl"></span></strong></h3>
        <br>

        <div class="tab-pane fade show active" id="pills-datos" role="tabpanel" aria-labelledby="pills-1" tabindex="0">
                <div class="row mb-3 g-3 align-items-center">
                    <label for="txtTit" class="offset-3 col-sm-1 col-form-label text-end">Autor:</label>                    
                    <div class="col-4">
                        <input type="text" id="txtAutor" class="form-control">
                    </div>
                </div>
                <div class="row mb-3 g-3 align-items-center">
                    <label for="txtTit" class="offset-3 col-sm-1 col-form-label text-end">Institución:</label>                    
                    <div class="col-4">
                        <input type="text" id="txtInstitucion" class="form-control">
                    </div>
                </div>
                <div class="row g-3 mb-3 align-items-center">                    
                    <label for="selectTema" class="offset-3 col-sm-1 col-form-label text-end">Tipo:</label>                    
                    <div class="col-4">
                        <asp:DropDownList class="form-select" ID="txtTipo" ClientIDMode="Static" runat="server"></asp:DropDownList>
                    </div>                    
                </div>                
                <div class="text-center"><a class="btn btn-primary btn-block" onclick="updateAutor();" style="width: 25%;">Guardar cambios</a></div>                
            </div>
        <br>
    </div>
    <script>
        window.onload=function(){
            ModificarAutor();
        }

        function ModificarAutor() {
            var id = <%=idAutor%>;
            $.ajax({
                type: 'POST',
                url: 'autores_editar.aspx/ModificarAutor',
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                }, success: function (informacion) {
                    var jsonD = $.parseJSON(informacion.d);
                    $('#txtAutor').val(jsonD.autor);
                    $('#txtInstitucion').val(jsonD.institucion);
                    $('#txtTipo').val(jsonD.tipo);
                    $('#titulolbl').html(jsonD.autor);
                }
            });
        }

        function updateAutor(){
            var idAutor = <%=idAutor%>;
            var autor = $('#txtAutor').val();
            var institucion = $('#txtInstitucion').val();
            var tipo = $('#txtTipo').val();            
            

            if(autor == "" || institucion == "" || tipo == 0) {
                PNotify.notice({
                    text: 'Por favor complete los campos.',
                    delay: 2500,
                    addClass: 'translucent'
                });                
                return;
            }

            var obj = {};
            obj.idAutor = idAutor;
            obj.autor = autor;
            obj.institucion = institucion;
            obj.tipo = tipo;

            $.ajax({
                type: 'POST',
                url: 'autores_editar.aspx/updateAutor',
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        PNotify.success({
                            text: 'La información se actualizó correctamente.',
                            delay: 2500,
                            addClass: 'translucent'
                        });
                        setTimeout(function myfunction() {
                            window.location.href = "ponencias_autores.aspx";
                        }, 2500);                        
                    }
                }
            });
        }
    </script>

    
</asp:Content>

