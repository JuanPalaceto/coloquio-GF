// Scripts del sistema
// 

window.addEventListener('DOMContentLoaded', event => {

    // Toggle the side navigation
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        // Uncomment Below to persist sidebar toggle between refreshes
        // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
        //     document.body.classList.toggle('sb-sidenav-toggled');
        // }
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }

});

/* Contador de caracteres */
function contador(obj){
    var textTam=obj.value.length;
    var maxlen = obj.maxLength;
    var idspan = "cont" + obj.id;
  
    if(textTam == maxlen || textTam == 0){
      document.getElementById(idspan).innerHTML='<span style="color: red;">('+textTam + '/' + maxlen + ')</span>';
    }else{
      document.getElementById(idspan).innerHTML='('+textTam + '/' + maxlen + ')';
    }
  }
  /* ******************** */

    