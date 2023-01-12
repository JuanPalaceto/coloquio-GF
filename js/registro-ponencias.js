window.onload = function(){
  //$.get('Handler2.ashx', function(data) {
  //    $('#handler').html(data);
  //});
  //$('#tablaAutores').hide();

  let idpon = localStorage.getItem('idActual');
  $('#idPonencia').val(idpon);

  setTimeout(function myfunction() {
    //verifica que se haya hecho click desde un botón de modificar
    if (idpon != 0) {
      //Trae los registros
      modificarPonencia(idpon);
    }
  }, 500);
};


/* Cargar la última tab activa */
const pillsTab = document.querySelector('#pills-tab');
const pills = pillsTab.querySelectorAll('button[data-bs-toggle="pill"]');

pills.forEach(pill => {
  pill.addEventListener('shown.bs.tab', (event) => {
    const { target } = event;
    const { id: targetId } = target;

    savePillId(targetId);

    // Ocultar / mostrar la lista de autores según la pestaña activa
    if (targetId == 'pills-2') {
      let id = $('#idPonencia').val();
      TablaAut(id);
    }

  });
});

const savePillId = (selector) => {
  localStorage.setItem('activePillId', selector);
};

const getPillId = () => {
  const activePillId = localStorage.getItem('activePillId');

  // if local storage item is null, show default tab <- Al hacer click en registrar ponencia se le da a la variable "pills-1", el id de la primera pill
  if (!activePillId) return;

  // call 'show' function
  const someTabTriggerEl = document.querySelector(`#${activePillId}`)
  const tab = new bootstrap.Tab(someTabTriggerEl);

  tab.show();

  // setTimeout(() => {
  //   $('#'+activePillId).trigger('click');
  // }, 600);
};

// get pill id on load
getPillId();
/* ******************** */


/* Comprueba si existe una ponencia cargada o no */
setTimeout(function myfunction() {
  $.get('buscar_archivo.ashx', function(data) {
    $('#handler').html(data);
  });
}, 1000);
/* ********************* */


/* Se inicializa el plugin */
$('#file-input').fileinput({
  theme: 'fa5',
  language: 'es',
  uploadUrl: 'subir_archivo.ashx',
  //deleteUrl: "/site/file-delete",
  maxFileSize: 8192,
  maxFileCount: 1,
  overwriteInitial: false,
  initialPreviewAsData: true, //...
  browseOnZoneClick: true,
  validateInitialCount: true,
  // fileActionSettings: {
  //   showZoom: false
  // },
  allowedFileExtensions: ['pdf']//['doc', 'docx']
});
/* ******************** */


