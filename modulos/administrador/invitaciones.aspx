<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="invitaciones.aspx.cs" Inherits="modulos_administrador_invitaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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

    <script src="../../js/invitaciones.js"></script>
</asp:Content>

