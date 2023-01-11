<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="ponencias_clasificadas.aspx.cs" Inherits="ponencias_clasificadas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Ponencias section -->
    <div class="bordercustom">
                        <h3><strong>Lista de ponencias agregadas al sistema:</strong></h3><br>
                        <p>A continuación se muestra una lista de las ponencias que se han registrado en el sistema seleccione una para ver más detalles.</p>
                        <br />
                        <div>
                            <table id="tabla" class="display">
                                <thead>
                                    <tr align="center">
                                        <th>Fecha</th>
                                        <th>Título</th>
                                        <th>Editar</th>
                                        <th>Autores</th>
                                        <th>Email</th>
                                        <th>Descagar</th>
                                        <th>Eliminar</th>
                                        <th>Evaluadores</th>                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>27/09/2022</td>
                                        <td>Impacto del Perfil del Emprendedor Digital y de la Innovación en el Rendimiento de las Pymes en Tamaulipas.</td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/edit.png" alt="editar ponencia"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/autor.png" alt="autores"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/email.png" alt="email"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/export.png" alt="export"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/delete.png" alt="delete"/></a></td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>27/09/2022</td>
                                        <td>El efecto de las dimensiones del e-servicescape en la confianza y satisfacción para predecir la intención de recompra en línea</td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/edit.png" alt="editar ponencia"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/autor.png" alt="autores"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/email.png" alt="email"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/export.png" alt="export"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/delete.png" alt="delete"/></a></td>
                                        <td>0</td>
                                    </tr>
                                    <tr>
                                        <td>30/09/2022</td>
                                        <td>El capital psicológico y los rasgos de la personalidad como antecedentes del bienestar subjetivo de los emprendedores</td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/edit.png" alt="editar ponencia"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/autor.png" alt="autores"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/email.png" alt="email"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/export.png" alt="export"/></a></td>
                                        <td align="center"><a href="ponencias_clasificadas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/delete.png" alt="delete"/></a></td>
                                        <td>0</td>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    <br>
                    <br>
                    </div>                                    
</asp:Content>




