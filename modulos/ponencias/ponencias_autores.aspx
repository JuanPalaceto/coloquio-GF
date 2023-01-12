<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="ponencias_autores.aspx.cs" Inherits="ponencias_autores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- Agregar Autores -->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <h3><strong>Agregar autores a la ponencia: <span id="titulolbl"></span></strong></h3>
        <br>        
        <div class="row mb-2 g-3 align-items-center">
            <label for="txtAutor" class="offset-3 col-sm-1 col-form-label text-end">Autor:</label>                    
            <div class="col-4">
                <input type="text" id="txtAutor" class="form-control">
            </div>
        </div>
        <div class="row mb-2 g-3 align-items-center">
            <label for="txtInstitucion" class="offset-3 col-sm-1 col-form-label text-end">Institución:</label>                    
            <div class="col-4">
                <input type="text" id="txtInstitucion" class="form-control">
            </div>
        </div>
        <div class="row g-3 mb-2 align-items-center">                    
            <label for="txtTipo" class="offset-3 col-sm-1 col-form-label text-end">Tipo:</label>     
            <div class="col-4">
                <asp:DropDownList class="form-select" ID="txtTipo" ClientIDMode="Static" runat="server"></asp:DropDownList>
            </div>                    
        </div>
        <div class="text-center"><a class="btn btn-primary btn-block" onclick="AgregarAutor();" style="width: 25%;">Agregar</a></div>
        <%-- ---- modal ------- --%>
        <div class="modal fade bd-modal-del" id="modaldel" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title h4" id="myLargeModalLabel21">ELIMINAR</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="modal-body">
                        <h2>¿Está seguro de eliminar al autor?</h2>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn  btn-primary eliminar" data-bs-dismiss="modal" style="float: right; margin-left: 5px;">Confirmar</button>
                        <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
        <%-- ------------------ --%>
        <br>
    </div>

    <!-- Lista Autores -->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <h3><strong>Lista de autores</strong></h3>
        <br>        
        <div id="generarTabla" class="table-responsive"></div>
        <br>
        <div class="text-center"><a class="btn btn-primary btn-block" style="width: 25%;" href="ponencias_listar.aspx">Volver</a></div>                
        <br>
    </div>        
                        
    </div>
    <script>
        window.onload=function(){
            TablaUsu();
            ListarTitulo();
        }

        function TablaUsu() {  //aqui se crea la tabla
            $.ajax({
                type: 'POST',
                url: 'ponencias_autores.aspx/TablaListarAutores',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (tabla) {
                    $("#generarTabla").html(tabla.d); //nombre del id del div de la tabla
                    setTimeout(function myfunction() {
                        estiloDataTable();
                    }, 100);
                }
            });
        };

        function estiloDataTable(page, leng) {
            $('#tabla').DataTable({
                "lengthMenu": [5, 10, 25, 50, 75, 100],
                "pageLength": leng,
                pagingType: 'numbers',
                "order": [[4, 'asc'], [1, 'asc']],
                language: {
                    "decimal": ".",
                    "emptyTable": "",
                    "info": "Mostrando del _START_ al _END_ de un total de _TOTAL_ registros",
                    "infoEmpty": "",
                    "infoFiltered": "<br/>(Filtrado de _MAX_ registros en total)",
                    "infoPostFix": "",
                    "thousands": ",",
                    "lengthMenu": "Mostrando _MENU_ registros",
                    "loadingRecords": "Cargando...",
                    "processing": "Procesando...",
                    "search": "B&uacute;squeda:",
                    "zeroRecords": "No hay registros",
                }
            });
        };

        function ListarTitulo() {
            var id = <%=idponencia%>;
            $.ajax({
                type: 'POST',
                url: 'ponencias_autores.aspx/ListarTitulo',
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                }, success: function (informacion) {
                    var jsonD = $.parseJSON(informacion.d);                    
                    $('#titulolbl').html(jsonD.titulo);                    
                }
            });
        };

        function AgregarAutor(){
            var idponencia = <%=idponencia%>;
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
            obj.idPonencia = idponencia;
            obj.autor = autor;
            obj.institucion = institucion;
            obj.tipo = tipo;

            $.ajax({
                type: 'POST',
                url: 'ponencias_autores.aspx/AgregarAutor',
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
                            text: 'Autor agregado correctamente.',
                            delay: 2000,
                            addClass: 'translucent'
                        });
                        TablaUsu();
                        limpiarTexto();
                    } else if (JsonD.success == 2){
                        PNotify.error({
                            text: 'Algo salió mal.',
                            delay: 2000,
                            addClass: 'translucent'
                        });                        
                    }
                }
            });
        };     
        
        function limpiarTexto(){
            $('#txtAutor').val('');
            $('#txtInstitucion').val('');
            $('#txtTipo').val(0);
        };

        function editarAutor(idAutor){
        $.ajax({
            type: 'POST',
            url: 'ponencias_autores.aspx/editarAutor',
            data: "{'idAutor':'" + idAutor + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error" + jqXHR.responseText);
            },
            success: function (valor) {
                var jsonD = $.parseJSON(valor.d);
                if(jsonD.Success == 1){
                    window.location.href = "autores_editar.aspx";
                }
            }
        });
    };

    function ConfirmarEliminar(idAutor) {
        $("#modaldel").modal('show');
        var id = idAutor;
        $(".eliminar").attr("id", "" + id + "");
        $(".eliminar").attr("onclick", "eliminarAutor(" + id + ");");
    }

    function eliminarAutor(id) {
        var idAutor = id;
        $.ajax({
            type: 'POST',
            url: 'ponencias_autores.aspx/EliminarAutor',
            data: "{'idAutor':'" + idAutor + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error" + jqXHR.responseText);
            },
            success: function (valor) {
                var JsonD = $.parseJSON(valor.d)
                if (JsonD.success == 1) {
                    TablaUsu();
                    PNotify.success({
                        text: 'El autor se eliminó correctamente.',
                        delay: 3000,
                        addClass: 'translucent'
                    });
                } else if (JsonD.success == 2) {
                    PNotify.notice({
                        text: 'Algo salió mal.',
                        delay: 3000,
                        addClass: 'translucent'
                    });
                }
            }
        });
    }
    </script>
</asp:Content>