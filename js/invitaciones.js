window.onload = function(){
    setTimeout(() => {
        TablaUsu();
    }, 500);
}

function TablaUsu() {  //aqui se crea la tabla
    let idEdicion = $('#selectEd').val();

    $.ajax({
        type: 'POST',
        url: 'invitaciones.aspx/TablaListarPonencias',
        data: "{'idEdicion':'" + idEdicion + "'}",
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
            "infoFiltered": "<br/>(Filtrado de <b>_MAX_</b> registros en total)",
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

/* Actualizar tabla al seleccionar otra edición */
$('#selectEd').change(function(){
    TablaUsu();
});
/* ******************** */