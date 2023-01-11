// Esto es para que los input text solo acepten números
// Poner onkeypress="return isNumberKey(event)" en el input que se quiera restringir
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
};

window.onload = function () {
    // Caracteres para correo
    var regex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;

    //Validación cliente
    $('#inputPasswordConfirm').blur(function () {
        if ($('#inputPassword').val() != $('#inputPasswordConfirm').val()) {
            $('#inputPassword').addClass("is-invalid");
            $('#inputPasswordConfirm').addClass("is-invalid");
            return;
        } else {
            $('#inputPassword').removeClass("is-invalid");
            $('#inputPasswordConfirm').removeClass("is-invalid");
        }
    });

    $('#inputPassword').blur(function () {
        if ($('#inputPassword').val() != $('#inputPasswordConfirm').val() && $('#inputPasswordConfirm').val() != "") {
            $('#inputPassword').addClass("is-invalid");
            $('#inputPasswordConfirm').addClass("is-invalid");
            return;
        } else {
            $('#inputPassword').removeClass("is-invalid");
            $('#inputPasswordConfirm').removeClass("is-invalid");
        }
    });

    $('#inputEmail').keyup(function () {
        if (!regex.test($('#inputEmail').val())) {
            $('#inputEmail').addClass("is-invalid");
        } else {
            $('#inputEmail').removeClass("is-invalid");
        }
    });
};