// Esto es para que los input text solo acepten números
// Poner onkeypress="return isNumberKey(event)" en el input que se quiera restringir
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
};

//--------------[No funciona]-------------------------------------------------
// window.onload = function () {
//     // Caracteres para correo
//     var regex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;

//     //Validación cliente
//     $('#inputPasswordConfirm').blur(function () {
//         if ($('#inputPassword').val() != $('#inputPasswordConfirm').val()) {
//             $('#inputPassword').addClass("is-invalid");
//             $('#inputPasswordConfirm').addClass("is-invalid");            
//             return;
//         } else {
//             $('#inputPassword').removeClass("is-invalid");
//             $('#inputPasswordConfirm').removeClass("is-invalid");
//         }
//     });

//     $('#inputPassword').blur(function () {
//         if ($('#inputPassword').val() != $('#inputPasswordConfirm').val() && $('#inputPasswordConfirm').val() != "") {
//             $('#inputPassword').addClass("is-invalid");
//             $('#inputPasswordConfirm').addClass("is-invalid");
//             return;
//         } else {
//             $('#inputPassword').removeClass("is-invalid");
//             $('#inputPasswordConfirm').removeClass("is-invalid");
//         }
//     });

//     $('#inputEmail').keyup(function () {
//         if (!regex.test($('#inputEmail').val())) {
//             $('#inputEmail').addClass("is-invalid");
//         } else {
//             $('#inputEmail').removeClass("is-invalid");
//         }
//     });
// };
//-----------------------------------------------------------------------------

//función del botón registrar
function registrar(){
    //asignación de los campos a variables
    var nombre = $('#inputNom').val();
    var apellido = $('#inputApe').val();
    var email = $('#inputEmail').val();            
    var psw = $('#inputPassword').val();
    var pswConfirm = $('#inputPasswordConfirm').val();
    var telefono = $('#inputTel').val();
    var grado = $('#inputGrado').val();    
    var institucion = $('#inputInstitucion option:selected').val();
    var dependencia = $('#inputDependencia').val();
    var estado = $('#inputEstado option:selected').val();
    var ciudad = $('#inputCiudad').val();
    
    //validaciones
    var regex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;

    if(nombre == ""){
        $('#inputNom').addClass("is-invalid");
        $("#inputNom").focus();
        PNotify.notice({
            text: 'Por favor, ingrese su(s) nombre(s).',
            delay: 2500,
            addClass: 'translucent'
        });        
        return;
    }

    if(apellido == ""){
        $('#inputApe').addClass("is-invalid");
        $("#inputApe").focus();
        PNotify.notice({
            text: 'Por favor, ingrese sus apellidos.',
            delay: 2500,
            addClass: 'translucent'
        });
        return;
    }

    if(email == "") {
        $('#inputEmail').addClass("is-invalid");
        $("#inputEmail").focus();
        PNotify.notice({
            text: 'Por favor, ingrese su correo electrónico.',
            delay: 2500,
            addClass: 'translucent'
        });
        return;
    } else if (!regex.test(email)) {
        $("#inputEmail").focus();
        PNotify.notice({
            text: 'El correo no es válido.',
            delay: 2500,
            addClass: 'translucent'
        });
        return;
    }
    
    if(telefono == ""){
        $('#inputTel').addClass("is-invalid");
        $("#inputTel").focus();
        PNotify.notice({
            text: 'Por favor, ingrese su número de teléfono.',
            delay: 2500,
            addClass: 'translucent'
        });
        return;
    } else if (telefono.length != 10) {
        $('#inputTel').addClass("is-invalid");
        $("#inputTel").focus();
        PNotify.notice({
            text: 'Por favor, haga coincidir su número con el formato solicitado (10 dígitos sin separadores).',
            delay: 2500,
            addClass: 'translucent'
        });
        return;
    }

    if(psw == ""){
        $('#inputPassword').addClass("is-invalid");
        $("#inputPassword").focus();
        PNotify.notice({
            text: 'Por favor, ingrese una contraseña.',
            delay: 2500,
            addClass: 'translucent'
        });
        return;
    }

    if(pswConfirm == ""){
        $('#inputPasswordConfirm').addClass("is-invalid");
        $("#inputPasswordConfirm").focus();
        PNotify.notice({
            text: 'Por favor, ingrese nuevamente su contraseña.',
            delay: 2500,
            addClass: 'translucent'
        });
        return;
    }

    if(psw != pswConfirm){        
        $('#inputPassword').addClass("is-invalid");
        $('#inputPasswordConfirm').addClass("is-invalid");
        $("#inputPassword").focus();
        PNotify.notice({
            text: 'Las contraseñas no coinciden.',
            delay: 2500,
            addClass: 'translucent'
        });
        return;
    }

    if(grado == "0"){
        $("#inputGrado").focus();
        PNotify.notice({
            text: 'Seleccione un grado académico.',
            delay: 2500,
            addClass: 'translucent'
        });        
        return;
    }

    if(institucion == "0"){
        $("#inputInstitucion").focus();
        PNotify.notice({
            text: 'Seleccione una institución.',
            delay: 2500,
            addClass: 'translucent'
        });  
        return;
    }

    if(dependencia == "0"){
        $("#inputDependencia").focus();
        PNotify.notice({
            text: 'Seleccione una dependencia.',
            delay: 2500,
            addClass: 'translucent'
        });  
        return;
    }

    if(estado == "0"){
        $("#inputEstado").focus();
        PNotify.notice({
            text: 'Seleccione un estado.',
            delay: 2500,
            addClass: 'translucent'
        });  
        return;
    }

    if(ciudad == "0"){
        $("#inputCiudad").focus();
        PNotify.notice({
            text: 'Seleccione una ciudad.',
            delay: 2500,
            addClass: 'translucent'
        });  
        return;
    }
    
    //construcción del objeto con la info del formulario
    var obj = {};
    obj.nombre = nombre;
    obj.apellido = apellido;
    obj.email = email;
    obj.psw = psw;
    obj.grado = grado;
    obj.institucion = institucion;
    obj.dependencia = dependencia;
    obj.ciudad = ciudad;
    obj.estado = estado;
    obj.telefono = telefono;                        

    //ejecución de la operación
    if ($('form')[0].checkValidity()){
        $.ajax({
            type: 'POST',
            url: 'register.aspx/Guardar',
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error" + jqXHR.responseText);
            },
            success: function (valor) {
                var JsonD = $.parseJSON(valor.d)
                if (JsonD.success == 1) {
                    PNotify.success({
                        text: 'Te has registrado con éxito.',
                        delay: 2500,
                        addClass: 'translucent'
                    });
                    setTimeout(function myfunction() {
                        window.location.href = "login.aspx";
                    }, 2500);                    
                } else if (JsonD.success == 2) {
                    $("#inputEmail").focus();
                    PNotify.notice({
                        text: 'Este correo ya está en uso.',
                        delay: 2500,
                        addClass: 'translucent'
                    });
                }
            }
        });
    } else {
        $('form')[0].reportValidity();
        return;
    }            
}

//------------------------[Selects con apis]---------------------------------

//Api de instituciones
const batchTrack = document.getElementById("inputInstitucion");
const getPost = async () => {
    const response = await fetch("https://api.datamexico.org/tesseract/data.jsonrecords?cube=anuies_enrollment&drilldowns=Institution&locale=es&measures=Students");
    const data = response.json();            
    return data;
};                

const displayOption = async () => {
const options = await getPost();
options.data.forEach(option => {            
    const newOption = document.createElement("option");
    newOption.value = option["Institution ID"];
    newOption.text = option.Institution;
    batchTrack.appendChild(newOption);

});
sortear("#inputInstitucion");
$("#inputInstitucion option[value=0]").attr('selected', 'selected');
};
displayOption();    

//funcion para la api de dependencias
function cargarDependencia(){        
    $("#inputDependencia option").each(function() {
        $(this).remove();            
    });        
    var id = $('#inputInstitucion').val();
    if(id == 0){
        const batchTrack = document.getElementById("inputDependencia");
        const newOption = document.createElement("option");
        newOption.value = 0;
        newOption.text = "Seleccione una institución";
        batchTrack.appendChild(newOption);
        $("#inputDependencia").attr('disabled',true);
    } else {
    const batchTrack = document.getElementById("inputDependencia");
    const getPost = async () => {
        const response = await fetch("https://api.datamexico.org/tesseract/data.jsonrecords?Institution="+ id +"&cube=anuies_enrollment&drilldowns=Institution%2CCampus&locale=es&measures=Students");
        const data = response.json();            
        return data;
    };                

    const displayOption = async () => {
    const options = await getPost();
    const newOption = document.createElement("option");
    newOption.value = "0"
    newOption.text = "- Seleccionar -"
    batchTrack.appendChild(newOption);
    options.data.forEach(option => {            
        const newOption = document.createElement("option");
        newOption.value = option["Campus ID"];
        newOption.text = option.Campus;
        batchTrack.appendChild(newOption);
        $("#inputDependencia").removeAttr('disabled');    
    });
    sortear("#inputDependencia");
    $("#inputDependencia option[value=0]").attr('selected', 'selected');
    };
    displayOption();
    }
}

//Api de estados al cargar la página
const batchTrack2 = document.getElementById("inputEstado");
const getPost2 = async () => {
    const response = await fetch("https://api.datamexico.org/tesseract/data.jsonrecords?cube=inegi_population_total&drilldowns=State&locale=es&measures=Population");
    const data = response.json();            
    return data;
};                

const displayOption2 = async () => {
const options = await getPost2();
options.data.forEach(option => {            
    const newOption = document.createElement("option");
    newOption.value = option["State ID"];
    newOption.text = option.State;
    batchTrack2.appendChild(newOption);

});
sortear("#inputEstado");
$("#inputEstado option[value=0]").attr('selected', 'selected');
};
displayOption2();    

//funcion para la api de ciudades
function cargarCiudad(){        
    $("#inputCiudad option").each(function() {
        $(this).remove();            
    });
    var id = $('#inputEstado').val();
    if(id == 0){
        const batchTrack2 = document.getElementById("inputCiudad");
        const newOption = document.createElement("option");
        newOption.value = 0;
        newOption.text = "Seleccione un estado";
        batchTrack2.appendChild(newOption);
        $("#inputCiudad").attr('disabled',true);
    } else {
    const batchTrack2 = document.getElementById("inputCiudad");
    const getPost2 = async () => {
        const response = await fetch("https://api.datamexico.org/tesseract/data.jsonrecords?State="+id+"&cube=inegi_population_total&drilldowns=State%2CMunicipality&locale=es&measures=Population");
        const data = response.json();            
        return data;
    };                

    const displayOption2 = async () => {
    const options = await getPost2();
    const newOption = document.createElement("option");
    newOption.value = "0"
    newOption.text = "- Seleccionar -"
    batchTrack2.appendChild(newOption);
    options.data.forEach(option => {            
        const newOption = document.createElement("option");
        newOption.value = option["Municipality ID"];
        newOption.text = option.Municipality;
        batchTrack2.appendChild(newOption);
        $("#inputCiudad").removeAttr('disabled');    
    });
    sortear("#inputCiudad");
    $("#inputCiudad option[value=0]").attr('selected', 'selected');
    };
    displayOption2();
    }
}

//función para sortear alfabéticamente las opciones de un select mandando el id del select
function sortear(id) {    
    $(id).append($(id+" option").remove().sort(function(a, b) {
        var at = $(a).text(),
            bt = $(b).text();                
        return (at > bt) ? 1 : ((at < bt) ? -1 : 0);
    }));
}