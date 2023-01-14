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


/* Se inicializa el plugin */
$('#file-input').fileinput({
    theme: 'fa5',
    language: 'es',
    showClose: false,
    showBrowse: false,
    showCaption: false,
    dropZoneTitle: 'No hay archivos disponibles.',
    maxFileSize: 8192,
    maxFileCount: 1,
    overwriteInitial: false,
    initialPreviewAsData: true, //...
    validateInitialCount: true,
    allowedFileExtensions: ['pdf']//['doc', 'docx']
});
/* ******************** */


/* Ver el archivo de la ponencia */
function verPonencia(idPonencia, titulo){
    $('#spanTitulo').html(titulo);
    $('#modalArchivo').modal('show');

    $.ajax({
        type: "POST",
        url: "ver_archivo.ashx",
        data: { idPon: idPonencia },
        success: function(response) {
            $('#handler').html(response);
        }
    });
}
/* ******************** */


/* Para reiniciar el file input cada que se cierra un modal */
const myModalArchivo = document.getElementById('modalArchivo');
myModalArchivo.addEventListener('hidden.bs.modal', function (event) {
    $('#file-input').fileinput('destroy');
    $('#file-input').fileinput({
        theme: 'fa5',
        language: 'es',
        showClose: false,
        showBrowse: false,
        showCaption: false,
        dropZoneTitle: 'No hay archivos disponibles.',
        maxFileSize: 8192,
        maxFileCount: 1,
        overwriteInitial: false,
        initialPreviewAsData: true, //...
        validateInitialCount: true,
        allowedFileExtensions: ['pdf']//['doc', 'docx']
    });
})
/* ******************** */


/* Administrar evaluadores de la ponencia */
function editarEvaluador(idPonencia, titulo){
    $('#spanTituloEv').html(titulo);
    $('#modalEvaluadores').modal('show');

    $.ajax({
        type: "POST",
        url: "invitaciones.aspx/ListarEvaluadores",
        data: "{'idPonencia': '"+idPonencia+"'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        },
        success: function(response) {
            $('#listaEvaluadores').html(response.d);
        }
    });
}
/* ******************** */

