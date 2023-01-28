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
                // estiloDataTable();
            }, 100);
        }
    });
}


/* Esconde el botón de guardar si la edición seleccionada no es la activa */
function ocultaBoton(edicionActiva){
    let idEdicion = $('#selectEd').val();

    if (idEdicion == edicionActiva){
        $('#btnEnviar').show();
    } else {
        $('#btnEnviar').hide();
    }
}
/* ******************** */


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
function verPonencia(idPonencia, idUsuario){
    $('#modalArchivo').modal('show');
    verDatos(idPonencia);
    TablaAut(idPonencia);

    $.ajax({
        type: "POST",
        url: "ver_archivo.ashx",
        data: { idPon: idPonencia, idUsu: idUsuario },
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
// guardar el id de la ponencia en una variable global
let globalIdPonencia, globalTitulo;

function editarEvaluador(idPonencia, titulo){
    // Guardo estos datos para usarlos al hacer el insert de las invitaciones
    globalIdPonencia = idPonencia;
    globalTitulo = titulo;

    let idEdicion = $('#selectEd').val();


    $('#spanTituloEv').html(titulo);
    $('#modalEvaluadores').modal('show');

    var data = {
        idPonencia: globalIdPonencia,
        idEdicion: idEdicion
    };

    $.ajax({
        type: "POST",
        url: "invitaciones.aspx/ListarEvaluadores",
        data: JSON.stringify(data),
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

$('#listaEvaluadores').on("click", "td.seleccionable input[type=checkbox]", function(){
    let checkbox = $(this);
    checkbox.prop("checked", !checkbox.prop("checked"));
});
/* ******************** */


/* Enviar invitaciones */
var isDialogOpen = false;

$("#btnEnviar").click(function() {
    isDialogOpen = true;

    Swal.fire({
        titleText: '¿Desea continuar?',
        text: "Si desea guardar los cambios haga click en Aceptar",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#1F6C49',
        confirmButtonText: 'Aceptar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        isDialogOpen = false;
        if (result.value) {
            // Obtener los evaluadores seleccionados (En todas las páginas del datatable)
            // var values = [];
            // var table = $('#tablaEvaluadores').DataTable();

            // // Recorrer las páginas de la tabla
            // for (var i = 0; i < table.page.info().pages; i++) {
            //     // Limpia el array (porque se duplica al recorrer cada página)
            //     values = [];
            //     // Ir a la página
            //     table.page(i).draw();

            //     // Selecciona los checkboxes
            //     var checkboxes = table.rows().nodes().to$().find('input[type="checkbox"]');

            //     // Recorre los checkboxes para encontrar los que estén marcados y asignalos al array
            //     checkboxes.each(function() {
            //         if (this.checked) {
            //             values.push($(this).val());
            //         }
            //     });
            // }
            // console.log(values);

            // Obtener los evaluadores seleccionados (En todas las páginas del datatable)
            var values = [];

            // Selecciona los checkboxes en todas las páginas de la datatable
            // HAY QUE VER SI SELECCIONA CUANDO TRAIGO LA TABLA LLENA Y NO ABRO LA SIGUIENTE PÁGINA, SI NO REGRESAR YU PROBAR EL CÓDIGO DE ARRIBA
            // Si sí funciona pus borrar el código de arriba:p
            var checkboxes = $('#tablaEvaluadores').DataTable().rows().nodes().to$().find('input[type="checkbox"]');

            // Selecciona los checkboxes que estén marcados y los guarda en el array
            checkboxes.each(function() {
                if(this.checked) {
                    values.push($(this).val());
                }
            });

            // Valida que el array contenga algún check, de lo contrario envía un 0 en al array, lo que quiere decir que de existir, elimina todas las invitaciones de dicha ponencia en la BD
            if(!(values.length > 0)){
                values.push("0");
            }

            var data = {
                idPonencia: globalIdPonencia,
                evaluadores: values
            };

            // Manda invitaciones
            $.ajax({
                type: "POST",
                url: "invitaciones.aspx/AdministrarEvaluadores",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function(response) {
                    editarEvaluador(globalIdPonencia, globalTitulo);
                }
            });
        }
    })
});

/* Esto es pa' cerrar el sweetalert al mismo tiempo que el modal */
$(document).on('keydown', function(event) {
    if (event.keyCode === 27 && isDialogOpen) {
        // close the SweetAlert2 first
        Swal.close();
        isDialogOpen = false;
        return false;
    }
});
/* ******************** */

/* Controla las pills */
$('#btnMuestraAutores').on('click', function(){
    $('#btnPillAutor').trigger('click');
});

$('#btnMuestraDatos').on('click', function(){
    $('#btnPillData').trigger('click');
});

$('#btnMuestraArchivo').on('click', function(){
    $('#btnPillFile').trigger('click');
});

$('#btnRegresaAutores').on('click', function(){
    $('#btnPillAutor').trigger('click');
});
/* ******************** */


/* Tabla de Autores */
function TablaAut(id) {  //aqui se crea la tabla
    $.ajax({
        type: 'POST',
        url: 'invitaciones.aspx/TablaListarAutores',
        data: "{'id':'" + id + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error" + jqXHR.responseText);
        },
        success: function (tabla) {
            $("#generarTablaAutores").html(tabla.d); //nombre del id del div de la tabla
            setTimeout(function myfunction() {
                let idTable = "tablaAutores";
                let orden = [[0, 'asc']];
                let contexto = "No existen autores para esta ponencia.";
                dataTable('tablaAutores');
            }, 100);
        }
    });
  };
/* ******************** */


/* trae datos generales */
function verDatos(id) {

    $.ajax({
        type: 'POST',
        url: 'invitaciones.aspx/TraeDatos',
        data: "{'id':'" + id + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        },
        success: function (datos) {
            var JsonD = $.parseJSON(datos.d);

            // Trae los datos
            $('#txtTit').val(JsonD.titulo);
            $("#selectMod option:selected").remove();
            $('#selectMod').append($('<option>', {
                value: 1,
                text: JsonD.modalidad
            }));
            $("#selectTema option:selected").remove();
            $('#selectTema').append($('<option>', {
                value: 1,
                text: JsonD.tema
            }));
            $('#txtRes').val(JsonD.resumen);
            $('#txtPal').val(JsonD.palabrasClave);
        }
    });
}
/* ******************** */
