<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="modalidades.aspx.cs" Inherits="modalidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Ponencias section -->
    <div>

    </div>
    <br />
    <h3><strong>Lista de Modalidades:</strong></h3>
    <div id="generarTabla" class="table-responsive"></div>

       <!---------------------->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <div class="">
        <h3><strong>Lista de Modalidades</strong></h3>
        </div>
        <div>
            <button type="button" class="btn  btn-primary confirmar" onclick="ModalNuevaEdicion();" style="float:left;" >Agregar Nueva Modalidad</a>
        </div>
        <br />
        <div class="card-body">
        <%-- se genera la tabla --%>
            <div id="generarTabla" class="table-responsive "></div>
            <%-- leyendas --%>
            <div class="row">
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Estados:</b></li>
                        <li><i class="fa-sharp fa-solid fa-check text-success" style="font-size:1.2em;"></i> = Activa</li>
                        <li><i class="fa-sharp fa-solid fa-ban" style="font-size:1.2em;color: var(--bs-gray-600);"></i> = Inactiva</li>
                    </ul>
                </div>
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Acciones:</b></li>
                        <li><i class="fa-sharp fa-solid fa-pencil text-info" style="font-size:1.2em;"></i> = Editar modalidad</li>
                        <li><i class="fa-sharp fa-solid fa fa-trash text-danger" style="font-size:1.2em;"></i> = Eliminar modalidad</li>
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
url: 'modalidades.aspx/TablaListarModalidades',
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
</script>
</asp:Content>
