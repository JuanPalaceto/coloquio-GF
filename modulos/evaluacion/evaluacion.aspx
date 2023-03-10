<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="evaluacion.aspx.cs" Inherits="modulos_evaluacion_evaluacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="card shadow p-3 mb-5 bg-body rounded">
    <h3><strong>Evaluación de ponencia</strong></h3>
    <br>
    <div class="card-body">
        <h4><b>Título de la ponencia: </b><span id="lblTitulo"><%=titulo%></span></h4>
        <h4><b>Evaluador: </b><span id="lblEvaluador"></span></h4>
        <br>
        <div id="generarTabla" class="table-responsive"></div>
        <br>
        <div class="row">                
            <div class="col-auto">
                Le pedimos ofrezca al autor ideas constructivas que le ayuden a mejorar su trabajo. Le recordamos que uno de los principios básicos de los congresos es el de mejorar en la labor investigadora mediante los valiosos comentarios de los evaluadores, por lo que le rogamos sea constructivo. Trate de identificar los puntos fuertes del trabajo y después indíquele todo aquello susceptible de mejorar. Finalmente, le sugerimos que elabore un breve informe (no más de 500 caracteres) en las que comunique de manera formal sus comentarios en los términos antes mencionados.
            </div>
        </div>
        <br>
        <div class="row">
            <div class="col-12 col-sm-10 offset-sm-1 ">
                <label for="txtObservaciones" class="col-form-label">Observaciones:</label>            
                <textarea id="txtObservaciones" class="form-control" rows=5 maxlength="500" oninput="contador(this);"></textarea>
                <span id="conttxtObservaciones" class="float-end text-muted">(0/500)</span>
            </div>                    
        </div>        
        <div class="row">
            <div class="col-12 col-sm-10 offset-sm-1 ">
            <label for="txtRecomendaciones" class="col-form-label">En caso de recomendar cambios enlistarlos a continuación:</label>            
            <textarea id="txtRecomendaciones" class="form-control" rows=5 maxlength="500" oninput="contador(this);"></textarea>
            <span id="conttxtRecomendaciones" class="float-end text-muted">(0/500)</span>
            </div>                    
        </div>
        <div class="text-center"><a class="btn btn-primary btn-block" onclick="Guardar();" style="width: 25%;">Guardar</a></div>
    </div> 
</div> 
<script>
    window.onload = function(){
        TablaUsu();
        $('#lblEvaluador').html($('#nomUsu').html());
    }    

    function TablaUsu() {  //aqui se crea la tabla
        $.ajax({
            type: 'POST',
            url: 'evaluacion.aspx/TablaListarPonencias',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
            },
            success: function (tabla) {
                $("#generarTabla").html(tabla.d); //nombre del id del div de la tabla
                setTimeout(function myfunction() {
                    estiloDataTable2();
                }, 100);
            }
        });
    }

    function estiloDataTable2(page, leng) {
        $('#tabla').DataTable({            
            "bPaginate": false,
            "ordering": false,
            language: {
                "decimal": ".",
                "emptyTable": "",
                "info": "Mostrando _TOTAL_ parámetros.",
                "infoEmpty": "",
                "infoFiltered": "<br/>(Filtrado de _MAX_ parámetros en total)",
                "infoPostFix": "",
                "thousands": ",",
                "lengthMenu": "Mostrando _MENU_ parámetros",
                "loadingRecords": "Cargando...",
                "processing": "Procesando...",
                "search": "B&uacute;squeda:",
                "zeroRecords": "No hay parámetros disponibles.",
            }
        });
    };

    function sumatoria(){
        var temp, sumatoria = 0;
        var numReg = parseInt($('#regTot').val());        
        if(numReg != 0 && numReg != NaN){
            for(var i = 0; i < numReg; i++){
                temp = $('#sel' + i).val();
                if(temp != "") {
                    sumatoria += parseInt(temp);
                }                            
            }
            $('#pts').html('<b>' + sumatoria + ' Puntos</b>');
        }
    }

    function Guardar(){
        numReg = parseInt($('#regTot').val());
        var calif = [];
        var idParametro = [];
        var observaciones = $('#txtObservaciones').val();
        var recomendaciones = $('#txtRecomendaciones').val();
        for(var i = 0; i < numReg; i++) {
            calif[i] = parseInt($('#sel' + i).val());            
            <%-- idParametro[i] = parseInt($('#idPar' + i).val()); --%>
        }        

        var table = $('#tabla'); 
        table.find('tbody > tr').each(function () { 
        ids = $(this).find("td").eq(2).html(); 
        idParametro.push(ids); 
        }); 
        

        if (calif == "" && idParametro == "") { 
            var acalif = "";
            var apar = ""; 
        } else { 
            var acalif = calif.toString();
            var apar = idParametro.toString(); 
        }
         

        var obj = {};
        obj.calif = acalif;
        obj.idParametro = apar;
        obj.observaciones = observaciones;
        obj.recomendaciones = recomendaciones;

        console.log(obj)

        if ($('form')[0].checkValidity()){
            $.ajax({
                type: 'POST',
                url: 'evaluacion.aspx/Guardar',
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        alert('La informacion se guardó correctamente.');
                        window.location.href = "ponencias_evaluar.aspx";
                    } else if (JsonD.success == 2) {
                        alert('Algo salió mal.')
                    }
                }
            });
        } else {
            $('form')[0].reportValidity();
            return;
        }            
    }
</script>
</asp:Content>

