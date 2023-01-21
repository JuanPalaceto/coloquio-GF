/* Generales */
$('#btnAutorSig').on('click',  function() {
    var id = $('#idPonencia').val();
    verificaAutor(id);
});

var myModalEl = document.getElementById('modaladd');
myModalEl.addEventListener('hidden.bs.modal', function (event) {
  limpiaAutor();
})

function limpiaAutor() {
    let valSelect = $('#selectAut').val();

    $('#idAutor').val("0");
    $('#selectAut').prop('selectedIndex', 0);
    // $('#txtIns').val("");
    $('#txtAut').val("");
}
/* ******************** */

/* Agregar autores */
function agregarAutor(idPonencia) {
    var idAutor = "", autor = "", tipo = "";

    if ($('#txtAut')[0].checkValidity() && $('#selectAut')[0].checkValidity()) {
        idAutor = $('#idAutor').val();
        autor = $('#txtAut').val();
        // institucion = $('#txtIns').val();
        tipo = $('#selectAut').val();

        var obj = {};
        obj.idPonencia = idPonencia;
        obj.idAutor = idAutor;
        obj.autor = autor;
        // obj.institucion = institucion;
        obj.tipo = tipo;

        $.ajax({
            type: 'POST',
            url: 'ponencias_registrar.aspx/AgregaAutor',
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error" + jqXHR.responseText);
            },
            success: function (valor) {
                var JsonD = $.parseJSON(valor.d)
                var texto = "";
                if (JsonD.success == 1) {
                    texto = "Autor agregado correctamente.";
                } else if (JsonD.success == 2) {
                    texto = "Ponencia no seleccionada. Favor de agregar una nueva o bien editar una existente.";
                } else if (JsonD.success == 3){
                    texto = "Autor actualizado correctamente.";
                }

                if (JsonD.success == 2) {
                    PNotify.notice({
                        text: texto,
                        delay: 3000,
                        addClass: 'translucent'
                    });
                } else {
                    PNotify.success({
                        text: texto,
                        delay: 3000,
                        addClass: 'translucent'
                    });
                }

                $("#modaladd").modal('hide');
                TablaAut(idPonencia);
            }
        });
    } else {
        $('#selectAut')[0].reportValidity();
        // $('#txtIns')[0].reportValidity();
        $('#txtAut')[0].reportValidity();
    }
};

$('#btnAutor').on('click', function () {
    var id = $('#idPonencia').val();
    agregarAutor(id);
});
/* ******************** */


/* Tabla de Autores */
function TablaAut(id) {  //aqui se crea la tabla
  $.ajax({
      type: 'POST',
      url: 'ponencias_registrar.aspx/TablaListarAutores',
      data: "{'id':'" + id + "'}",
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

// function estiloDataTable(page, leng) {
//   $('#tabla').DataTable({
//       "lengthMenu": [5, 10, 25, 50, 75, 100],
//       "pageLength": leng,
//       pagingType: 'numbers',
//       "order": [[4, 'asc'], [1, 'asc']],
//       language: {
//           "decimal": ".",
//           "emptyTable": "",
//           "info": "Mostrando del _START_ al _END_ de un total de _TOTAL_ registros",
//           "infoEmpty": "",
//           "infoFiltered": "<br/>(Filtrado de _MAX_ registros en total)",
//           "infoPostFix": "",
//           "thousands": ",",
//           "lengthMenu": "Mostrando _MENU_ registros",
//           "loadingRecords": "Cargando...",
//           "processing": "Procesando...",
//           "search": "B&uacute;squeda:",
//           "zeroRecords": "No hay registros",
//       }
//   });
// };
/* ******************** */


/* editar Autor */
function editarAutor(id) {
    $.ajax({
        type: 'POST',
        url: 'ponencias_registrar.aspx/ModificaAutor',
        data: "{'id':'" + id + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        },
        success: function (datos) {
            var JsonD = $.parseJSON(datos.d);

            // Trae los datos a los inputs
            $('#idAutor').val(JsonD.idAutor);
            $('#txtAut').val(JsonD.autor);
            $('#txtIns').val(JsonD.institucion);
            $('#selectAut').val(JsonD.idTipoAutor);
            $("#modaladd").modal('show');
        }
    });
}
/* ******************** */


/* Eliminar autor */
function eliminarAutor(id) {
    var idPonencia = $('#idPonencia').val();
    $.ajax({
        type: 'POST',
        url: 'ponencias_registrar.aspx/EliminarAutor',
        data: "{'idAutor':'" + id + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error" + jqXHR.responseText);
        },
        success: function (valor) {
            var JsonD = $.parseJSON(valor.d)
            if (JsonD.success == 1) {
                TablaAut(idPonencia);
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

function ConfirmarEliminar(idAutor) {
    $("#modaldel").modal('show');
    //$(".eliminar").attr("id", "" + idAutor + "");
    $("#btnEliminar").attr("onclick", "eliminarAutor(" + idAutor + ");");
}
/* ******************** */


/* Verificar autores */
function verificaAutor(idPonencia) {
    $.ajax({
        type: 'POST',
        url: 'ponencias_registrar.aspx/VerificarAutor',
        data: "{'idPonencia':'" + idPonencia + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error" + jqXHR.responseText);
        },
        success: function (valor) {
            var JsonD = $.parseJSON(valor.d)
            if (JsonD.success == 1) {
                $('#pills-3').trigger('click');
            } else if (JsonD.success == 2) {
                PNotify.notice({
                    text: 'Favor de agregar al menos 𝟭 autor.',
                    delay: 3000,
                    addClass: 'translucent'
                });
            }
        }
    });
}
/* ******************** */