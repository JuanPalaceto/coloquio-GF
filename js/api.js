// lector de apis

// var api = "https://api.datamexico.org/tesseract/data.jsonrecords?cube=anuies_enrollment&drilldowns=Institution%2CMunicipality%2CCampus&locale=es&measures=Students";

// fetch(api).then(function (result) {
//     if (result.ok) {
//         return result.json();
//     }
// }).then(function (data) {
//     console.log(data);
//     data.forEach(function (element) {
//         let institucion = document.getElementById("inputInstitucion");
//         let opt = document.createElement("option");
    
//         opt.appendChild(document.createTextNode(element.Institution));
//         opt.attr("data-subtext", element.Municipality);
//         opt.value = element.Institution;
        
//         // idInstituto.value = element.Institution%x20ID;

//         institucion.appendChild(opt);
//     })
// });


// function verificar(){
//     fetch(api).then(function (result) {
//         if (result.ok) {
//             return result.json();
//         }
//     }).then(function (data) {
//         //console.log(data);
//         data.forEach(function (element) {
//             let institucion = document.getElementById("inputDependencia");
//             let opt = document.createElement("option");
        
//             opt.appendChild(document.createTextNode(element.Institution));
//             opt.attr("data-subtext", element.Municipality);
//             opt.value = element.Institution;
  
//             institucion.appendChild(opt);
//         })        
//     });
// }

$(document).ready(function () {  
    $.ajax({  
        type: "GET",  
        url: "https://api.datamexico.org/tesseract/data.jsonrecords?cube=anuies_enrollment&drilldowns=Institution&locale=es&measures=Students",
        dataType: "json", 
        success: function (data) {  
            console.log(data);
              $.each(data, function(item){
                let institucion = document.getElementById("inputInstitucion");
                let opt = document.createElement("option");
            
                opt.appendChild(document.createTextNode(item.Institution));
                // opt.attr("data-subtext", item.Municipality);
                opt.value = item.Institution;
                
                // idInstituto.value = element.Institution%x20ID;
        
                institucion.appendChild(opt);
               });
        }, //End of AJAX Success function  
    });         
}); 