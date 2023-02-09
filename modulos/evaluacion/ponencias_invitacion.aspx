<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="ponencias_invitacion.aspx.cs" Inherits="modulos_evaluacion_ponencias_invitacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* Esto es pal width de las columnas de la tabla, ya no hay que moverle >:v */
        #generarTabla td:nth-child(1) {
            width: 25%;
        }
        #generarTabla td:nth-child(2) {
            width: 45%;
        }
        #generarTabla td:nth-child(3) {
            width: 15%;
        }
        #generarTabla td:nth-child(4) {
            width: 15%;
            /* min-width: 100px; Si quieres que la columna no se achique taaanto cuando empieza a hacerse pequeña la pantalla y 15% es demasiado poco que solo queda al t amaño del texto */
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- body -->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <h3><strong>Mis invitaciones</strong></h3>
        <br>
        <div class="card-body">
            <br>
            <div id="generarTabla" class="table-responsive"></div>
            <br>
            
            <%-- leyendas --%>
            <div class="row">                
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Acciones:</b></li>
                        <li><i class="fa-sharp fa-solid fa-check text-success" style="font-size:1.2em;"></i> = Aceptar</li>
                        <li><i class="fa-sharp fa-solid fa-xmark text-danger" style="font-size:1.2em;"></i> = Rechazar</li>
                    </ul>
                </div>
            </div>
        </div> 
    </div>

    <script>
        window.onload = function(){
            TablaUsu();
        }

        function TablaUsu() {  //aqui se crea la tabla
            $.ajax({
                type: 'POST',
                url: 'ponencias_invitacion.aspx/TablaListarInvitacion',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (tabla) {
                    $("#generarTabla").html(tabla.d); //nombre del id del div de la tabla
                    setTimeout(function myfunction() {
                        estiloDataTable();
                    }, 100);
                }
            });
        }

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

        function AceptarInvitacion(idInvitacion, idPonencia) {    

            var obj = {};
            obj.idInvitacion = idInvitacion;
            obj.idPonencia = idPonencia;
            obj.idUsuario = <%=idusuario%>;

            $.ajax({
                type: 'POST',
                url: 'ponencias_invitacion.aspx/AceptarInvitacion',
                data: JSON.stringify(obj),
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
                            text: 'La ponencia se aceptó correctamente.',
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
        };

        function RechazarInvitacion(id) {        
            $.ajax({
                type: 'POST',
                url: 'ponencias_invitacion.aspx/RechazarInvitacion',
                data: "{'id':'" + id + "'}",
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
                            text: 'La ponencia se rechazó correctamente.',
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
        };
        </script>
</asp:Content>

