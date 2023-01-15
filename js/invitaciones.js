window.onload = function(){
    setTimeout(() => {
        TablaInvitaciones();
    }, 500);
}


function TablaInvitaciones() {  //aqui se crea la tabla
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
                let idTable = "tabla";
                let orden = [[3, 'asc'], [0, 'asc']];
                let contexto = "No hay ponencias pendientes.";
                dataTable(idTable, orden, contexto);
            }, 100);
        }
    });
}


/* Actualizar tabla al seleccionar otra edición */
$('#selectEd').change(function(){
    TablaInvitaciones();
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
        success: function(tablaEvaluadores) {
            $('#listaEvaluadores').html(tablaEvaluadores.d);
            let idTable = "tablaEvaluadores";
            let orden = [[0, 'asc'], [1, 'asc']];
            let contexto = "No hay evaluadores.";
            dataTable(idTable, orden, contexto);

            // Esto es para quitarle espacio a la columna de "Seleccionar" al mínimo
            var table = $('#tablaEvaluadores').DataTable();
            table.column(1).nodes().to$().css('width', '350px');
            table.column(2).nodes().to$().css('width', '100px');
        }
    });
}
/* ******************** */


/* Para poder hacer check cuando se clickee en el td de seleccionar (agregados después de cargar aka dinámicamente) */
$('#listaEvaluadores').on("click", "td.seleccionable", function(){
    let checkbox = $(this).find("input[type=checkbox]");
    checkbox.prop("checked", !checkbox.prop("checked"));
});

// En caso que se quiera que se haga el check clickando en el nombre también hay que descomentar este bloque y comentar el anterior
// $('#listaEvaluadores').on("click", "td.seleccionable", function(){
//     let checkbox = $(this).find("input[type=checkbox]");
//     if(checkbox.length > 0){
//         checkbox.prop("checked", !checkbox.prop("checked"));
//     } else {
//         let prevTD = $(this).prev("td.seleccionable");
//         if(prevTD.length > 0){
//             checkbox = prevTD.find("input[type=checkbox]");
//             checkbox.prop("checked", !checkbox.prop("checked"));
//         }
//     }
// });
/* ******************** */


/* Enviar invitaciones */
var isDialogOpen = false;

$("#btnEnviar").click(function() {
    isDialogOpen = true;

    Swal.fire({
      titleText: '¿Desea continuar?',
      text: "Se enviará una invitación a los usuarios seleccionados a evaluar esta ponencia. Si desea continuar haga click en Aceptar",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#1F6C49',
      confirmButtonText: 'Aceptar',
      cancelButtonText: 'Cancelar'
    }).then((result) => {
        isDialogOpen = false;
      if (result.value) {
        Swal.fire(
          'Deleted!',
          'Your file has been deleted.',
          'success'
        )
      }
    })
  });

// Esto es pa' cerrar el sweetalert al mismo tiempo que el modal
$(document).on('keydown', function(event) {
    if (event.keyCode === 27 && isDialogOpen) {
        // close the SweetAlert2 first
        Swal.close();
        isDialogOpen = false;
        return false;
    }
});
/* ******************** */
