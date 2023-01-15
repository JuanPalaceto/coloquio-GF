<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="invitaciones.aspx.cs" Inherits="modulos_administrador_invitaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!--ESTE ES EL PRINCIPAL CSS del plugin-->
    <link href="../../FileInput/css/fileinput.css" rel="stylesheet" />

    <!--Tema utilizado-->
    <link href="../../FileInput/themes/explorer-fa5/theme.css" rel="stylesheet" />

    <!--Estos son para conversión de archivos-->
    <script src="../../FileInput/js/plugins/buffer.min.js"></script>
    <script src="../../FileInput/js/plugins/filetype.min.js"></script>
    <!--ESTOS SON OPCIONALES, AÑADEN EXTRAS DE ORIENTACIÓN (Deben cargarse antes del fileinput.js-->
    <script src="../../FileInput/js/plugins/piexif.js"></script>
    <script src="../../FileInput/js/plugins/sortable.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- Lista de ponencias sin evaluar -->
    <div class="card shadow p-3 mb-5 bg-body rounded">
        <div class="">
            <h3><strong>Lista de ponencias</strong></h3>
        </div>
        <div class="card-body">
            <label for="selectEd"><b>Seleccione la edición:</b></label>
            <asp:DropDownList ID="selectEd" ClientIDMode="Static" CssClass="form-select w-auto" runat="server"></asp:DropDownList>
            <br>
            <br>
            <div id="generarTabla" class="table-responsive"></div>
            <br>
            <%-- leyendas --%>
            <div class="row">
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Estados:</b></li>
                        <li><i class="fa-sharp fa-solid fa-check text-success" style="font-size:1.2em;"></i> = Aprobada</li>
                        <li><i class="fa-sharp fa-solid fa-xmark text-danger" style="font-size:1.2em;"></i> = Rechazada</li>
                        <li><i class="fa-sharp fa-solid fa-hourglass-half" style="font-size:1.2em;"></i> = No evaluada</li>
                    </ul>
                </div>
                <div class="col-auto">
                    <ul class="list-unstyled">
                        <li><b>Acciones:</b></li>
                        <li><i class="fa-sharp fa-solid fa-magnifying-glass text-secondary" style="font-size:1.2em;"></i> = Ver archivo</li>
                        <li><i class="fa-sharp fa-solid fa-user-plus text-info" style="font-size:1.2em;"></i> = Editar evaluadores</li>
                        <%-- <li><i class="fa-sharp fa-solid fa fa-download" style="font-size:1.2em;color: var(--bs-gray-600);"></i> = Descargar ponencia</li> --%>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal ver archivo --%>
    <div id="modalArchivo" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="labelArchivo" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="labelArchivo">Título: <span id="spanTitulo"></span></h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" ></button>
                </div>
                <div class="modal-body">
                    <!--Para hacer zoom y previsualizar en un modal-->
                    <!-- Está en la master, el conflicto era el jquery repetido -->
                    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
                    <!--JS PRINCIPAL DEL PLUGIN-->
                    <script src="../../FileInput/js/fileinput.js"></script>
                    <!--ESTE ES PARA LENGUAJE A ESPAÑOL-->
                    <script src="../../FileInput/js/locales/es.js"></script>
                    <!--Para usar el tema de fontawesome5-->
                    <script src="../../FileInput/themes/explorer-fa5/theme.js"></script>
                    <script src="../../FileInput/themes/fa5/theme.js"></script>

                    <div id="handler"></div>
                    <div class="form-group" id="fileInput">
                        <div class="file-loading" >
                            <input id="file-input" type="file" multiple data-preview-file-type="any"/>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn  btn-secondary" data-bs-dismiss="modal" style="float: right;">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal adminsitrar evaluadores --%>
    <div id="modalEvaluadores" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="labelEvaluadores" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="labelEvaluadores">Título: <span id="spanTituloEv"></span></h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" ></button>
                </div>
                <div class="modal-body">
                    <div id="listaEvaluadores"></div>

                    <%-- leyendas --%>
                    <div class="row">
                        <div class="col-auto">
                            <ul class="list-unstyled">
                                <li><b>Estado de la invitación:</b></li>
                                <li><i class="fa-sharp fa-solid fa-check text-success" style="font-size:1.2em;"></i> = Aceptada</li>
                                <li><i class="fa-sharp fa-solid fa-xmark text-danger" style="font-size:1.2em;"></i> = Rechazada</li>
                                <li><i class="fa-sharp fa-solid fa-hourglass-half" style="font-size:1.2em;"></i> = Pendiente</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" style="float: right;" id="btnInvitar">Enviar</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="float: right;">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="../../js/invitaciones.js"></script>
    <script src="../../js/scripts.js"></script>
</asp:Content>
