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
            let contexto = "No hay evaluadores asignados.";
            dataTable(idTable, orden, contexto);
        }
    });
}
/* ******************** */


/* Enviar invitaciones */
$("#btnEnviarInvitacion").click(function() {
    return new Promise(function(resolve, reject) {
        $.confirm({
            escapeKey: true,
            backgroundDismiss: true,
            icon: 'fa fa-circle-question',
            title: '¡Confirmación!',
            content: '¿Desea asignar al evaluador esta ponencia?',
            type: 'blue',
            buttons: {
                Asignar: {
                    btnClass: 'btn-primary text-white',
                    keys: ['enter'],
                    action: function(){
                        if(idEvaluador == 0){
                            $.alert({
                                backgroundDismiss: true,
                                icon: 'fa fa-warning',
                                title: '¡Advertencia!',
                                content: 'Por favor, seleccione un evaluador primero',
                                type: 'orange'
                            });
                        } else {
                            var data = {
                                    idPonencia: globalIdPonencia,
                                    idEvaluador: idEvaluador
                                 };

                            // Manda invitaciones
                            $.ajax({
                                type: "POST",
                                url: "invitaciones.aspx/EnviaInvitacion",
                                data: JSON.stringify(data),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                error: function (jqXHR, textStatus, errorThrown) {
                                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                                },
                                success: function(response) {
                                    var JsonD = $.parseJSON(response.d);

                                    if (JsonD.success == 1) {
                                        $.alert({
                                            backgroundDismiss: true,
                                            icon: 'fa fa-warning',
                                            title: '¡Advertencia!',
                                            content: 'El evaluador ya se encuentra asignado a esta ponencia.',
                                            type: 'orange',
                                            onClose: function(){
                                                $("#txtEvaluador").val('');
                                                limpiaAutocomplete();
                                            }
                                        });
                                    } else if (JsonD.success == 2) {
                                        PNotify.success({
                                            text: 'Invitación enviada.',
                                            delay: 3000,
                                            addClass: 'translucent'
                                        });
                                        $("#txtEvaluador").val('');
                                        limpiaAutocomplete();
                                    }

                                    editarEvaluador(globalIdPonencia, globalTitulo);
                                }
                            });
                        }
                    }
                },
                Cancelar: function(){
                }
            }
        });
    });
});
/* ******************** */


/* Esto es para eliminar el confirm (conflicto con moda) - Lo elimina del DOM  */
//ESTO ES IMPORTANTE SI PLANEO REUTILIZAR LOS ALERTS DENTRO DE UN MODAL DE BOOTSTRAP:P
// Si no es dentro de bootstrap funciona bien con las opciones del mismo plugin
$(document).on('keydown', function(event) {
    if (event.keyCode === 27) {
        $('.jconfirm').remove();
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


/* Retirar evaluador */
function retirarEvaluador(idPonencia, idUsuario){
    return new Promise(function(resolve, reject) {
        $.confirm({
            escapeKey: true,
            backgroundDismiss: true,
            icon: 'fa fa-circle-question',
            title: '¡Confirmación!',
            content: '¿Desea retirar de esta ponencia al evaluador?',
            type: 'orange',
            buttons: {
                Retirar: {
                    btnClass: 'btn-primary text-white',
                    keys: ['enter'],
                    action: function(){
                        var data = {
                                idPonencia: idPonencia,
                                idEvaluador: idUsuario
                            };

                            // Manda invitaciones
                            $.ajax({
                                type: "POST",
                                url: "invitaciones.aspx/RetiraInvitacion",
                                data: JSON.stringify(data),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                error: function (jqXHR, textStatus, errorThrown) {
                                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                                },
                                success: function(response) {
                                    var JsonD = $.parseJSON(response.d);

                                if (JsonD.success == 1) {
                                    PNotify.success({
                                        text: 'Evaluador retirado de la ponencia.',
                                        delay: 3000,
                                        addClass: 'translucent'
                                    });
                                } else {
                                    PNotify.danger({
                                        text: 'Ocurrió un error, favor de intentar más tarde.',
                                        delay: 3000,
                                        addClass: 'translucent'
                                    });
                                }

                                editarEvaluador(globalIdPonencia, globalTitulo);
                            }
                        });
                    }
                },
                Cancelar: function(){
                }
            }
        });
    });
}
/* ******************** */
