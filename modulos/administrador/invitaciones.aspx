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

    <!-- SweetAlert2 -->
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <%-- jQuery autocomplete --%>
    <link href="../../css/jquery-ui.min.css" rel="stylesheet" />
    <script src="../../js/jquery-ui.min.js"></script>
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
                        <li><i class="fa-sharp fa-solid fa-magnifying-glass text-secondary" style="font-size:1.2em;"></i> = Ver ponencia</li>
                        <li><i class="fa-sharp fa-solid fa-user-gear text-info" style="font-size:1.2em;"></i> = Administrar evaluadores</li>
                        <%-- <li><i class="fa-sharp fa-solid fa fa-download" style="font-size:1.2em;color: var(--bs-gray-600);"></i> = Descargar ponencia</li> --%>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal ver archivo --%>
    <div id="modalArchivo" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="labelArchivo" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="labelArchivo">Detalle de la ponencia:</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" ></button>
                </div>
                <div class="modal-body">
                    <%-- tabs --%>
                    <ul class="nav nav-pills mb-3 nav-justified" id="menuPills" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="btnPillData" data-bs-toggle="pill" data-bs-target="#pillData" type="button" role="tab" aria-controls="pillData" aria-selected="true">Datos generales</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="btnPillAutor" data-bs-toggle="pill" data-bs-target="#pillAutor" type="button" role="tab" aria-controls="pillAutor" aria-selected="false">Autores</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="btnPillFile" data-bs-toggle="pill" data-bs-target="#pillFile" type="button" role="tab" aria-controls="pillFile" aria-selected="false">Archivo</button>
                        </li>
                    </ul>

                    <br/>

                    <div class="tab-content" id="pillsContenido">
                        <%-- Tab 1 --%>
                        <div class="tab-pane fade show active" id="pillData" role="tabpanel" aria-labelledby="pills-1" tabindex="0">
                            <div class="row mb-3 g-3 align-items-center">
                                <label for="txtTit" class="offset-xxl-2 col-xxl-2 col-sm-3  col-form-label">Título de la ponencia:</label>
                                <div class="col-xxl-6 col-sm-8">
                                    <input type="text" id="txtTit" class="form-control" disabled>
                                    <%-- <p id="txtTit"></p> --%>
                                </div>
                            </div>
                            <div class="row g-3 mb-3 align-items-center">
                                <label for="selectMod" class="offset-xxl-2 col-xxl-2 col-sm-3  col-form-label text-start">Modalidad de la ponencia:</label>
                                <div class="col-xxl-6 col-sm-8">
                                    <asp:DropDownList ID="selectMod" ClientIDMode="Static" CssClass="form-select" runat="server" disabled></asp:DropDownList>
                                    <%-- <p id="selectMod"></p> --%>
                                </div>
                            </div>
                            <div class="row g-3 mb-3 align-items-center">
                                <label for="selectTema" class="offset-xxl-2 col-xxl-2 col-sm-3  col-form-label text-start">Tema o área de la ponencia:</label>
                                <div class="col-xxl-6 col-sm-8">
                                    <asp:DropDownList ID="selectTema" ClientIDMode="Static" CssClass="form-select" runat="server" disabled></asp:DropDownList>
                                    <%-- <p id="selectTema"></p> --%>
                                </div>
                            </div>
                            <div class="row g-3 align-items-center">
                                <label for="txtRes" class="offset-xxl-2 col-xxl-2 col-sm-3  col-form-label text-start">Resumen de la ponencia:</label>
                                <div class="col-xxl-6 col-sm-8">
                                    <textarea id="txtRes" class="form-control" rows=8 maxlength="500" oninput="contador(this);" disabled></textarea>
                                    <%-- <p id="txtRes"></p> --%>
                                </div>
                            </div>
                            <div class="row g-3 align-items-center">
                                <label for="txtPal" class="offset-xxl-2 col-xxl-2 col-sm-3  col-form-label text-start">Palabras clave de la ponencia:</label>
                                <div class="col-xxl-6 col-sm-8 col-12 d-grid d-sm-block">
                                    <input type="text" id="txtPal" class="form-control" disabled/>
                                    <%-- <p id="txtPal"></p> --%>
                                </div>
                            </div>
                            <div class="row g-3 mb-3 mt-3 align-items-center">
                                <div class="text-center">
                                    <button id="btnMuestraAutores" type="button" class="btn btn-primary btn-block w-auto">Siguiente</button>
                                </div>
                            </div>
                        </div>

                        <%-- Tab 2 --%>
                        <div class="tab-pane fade" id="pillAutor" role="tabpanel" aria-labelledby="pills-3" tabindex="0">
                            <!-- Lista Autores -->
                            <!-- <div id="tablaAutores" class="card-body shadow p-3 mb-5 bg-body rounded"> -->
                            <!-- <h3><strong>Lista de autores</strong></h3> -->
                            <div class="container">
                                <div id="generarTablaAutores" class="table-responsive"></div>
                                <br/>
                            </div>
                            <div class="row g-3 mb-3 mt-3 align-items-center">
                                <div class="text-center">
                                    <button id="btnMuestraDatos" type="button" class="btn btn-secondary btn-block w-auto">Anterior</button>
                                    <button id="btnMuestraArchivo" type="button" class="btn btn-primary btn-block w-auto">Siguiente</button>
                                </div>
                            </div>
                        </div>

                        <%-- Tab 3 --%>
                        <div class="tab-pane fade" id="pillFile" role="tabpanel" aria-labelledby="pills-2" tabindex="0">
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

                            <div class="row g-3 mb-3 mt-3 align-items-center">
                                <div class="text-center">
                                    <button id="btnRegresaAutores" type="button" class="btn btn-secondary btn-block w-auto">Anterior</button>
                                </div>
                            </div>
                        </div>
                    </div>
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
                    <label for="txtEvaluador" class="col-form-label fw-bold">Ingrese un nombre o correo electrónico:</label>
                    <div class="row g-2 mb-1">
                        <div class="col-xl-5 col-7 ui-widget">
                            <input id="txtEvaluador" type="text" class="form-control" placeholder="" />
                        </div>
                        <div class="col-1">
                            <button class="btn btn-info text-white" style="height: 35.59px"><i class="fa-solid fa-envelope"></i></button>
                        </div>
                    </div>
                    <span class="text-muted ps-2" id="spanCorreo"></span>

                    <div>
                        <label class="mt-4 fw-bold">Lista de Evaluadores</label>
                    </div>
                    <div id="listaEvaluadores"></div>

                    <%-- leyendas --%>
                    <div class="row mt-3">
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
                    <%-- <button type="button" class="btn btn-primary" style="float: right;" id="btnEnviar">Guardar</button> --%>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="float: right;">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <script src="../../js/invitaciones.js"></script>
    <script src="../../js/buscaEvaluador.js"></script>
</asp:Content>
