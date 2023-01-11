<%@ Page Title="" Language="C#" MasterPageFile="~/modulos/MasterPage.master" AutoEventWireup="true" CodeFile="ponencias_todas.aspx.cs" Inherits="ponencias_todas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Ponencias section -->
                    <div class="bordercustom">
                        <h3><strong>Lista de ponencias agregadas al sistema:</strong></h3><br>
                        <p>A continuación se muestra una lista de las ponencias que se han registrado en el sistema seleccione una para ver más detalles.</p>
                        <br />
                        <br />
                        <div>
                            <table id="tabla" class="display" width="100%">
                                <thead>
                                    <tr align="center">
                                        <th width="15%">Fecha</th>
                                        <th width="30%">Título</th>
                                        <th width="15%">Institución</th>
                                        <th width="5%">Editar</th>
                                        <th width="5%">Autores</th>
                                        <th width="5%">Email</th>
                                        <th width="5%">Descagar</th>
                                        <th width="5%">Eliminar</th>
                                        <th width="5%">Evaluadores</th>
                                        <th width="20%">Resultado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>30/09/2022</td>
                                        <td>CITY MARKETING Y CITY BRANDING, DIAGNOSTICO DE LA IDENTIDAD COMPETITIVA DE LA CIUDAD PARA LA CREACIÓN DE LA MARCA CIUDAD VICTORIA</td>
                                        <td>Instituto tecnologico de Ciudad Victoria</td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/edit.png" alt="editar ponencia"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/autor.png" alt="autores"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/email.png" alt="email"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/export.png" alt="export"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/delete.png" alt="delete"/></a></td>
                                        <td>0</td>
                                        <td>Sin evaluador</td>
                                    </tr>
                                    <tr>
                                        <td>30/09/2022</td>
                                        <td>INTENCIÓN DE ADOPTAR ESTRATEGIAS DE MARKETING INBOUND POR PARTE DE LAS MIPYMES TAMAULIPECAS</td>
                                        <td>Universidad Autónoma de Tamaulipas</td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/edit.png" alt="editar ponencia"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/autor.png" alt="autores"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/email.png" alt="email"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/export.png" alt="export"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/delete.png" alt="delete"/></a></td>
                                        <td>0</td>
                                        <td>Sin evaluador</td>
                                    </tr>
                                    <tr>
                                        <td>30/09/2022</td>
                                        <td>Las prácticas de gobierno corporativo en el desempeño de las empresas que cotizan en la BMV.</td>
                                        <td>Universidad Autónoma de Tamaulipas</td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/edit.png" alt="editar ponencia"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/autor.png" alt="autores"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/email.png" alt="email"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/export.png" alt="export"/></a></td>
                                        <td align="center"><a href="ponencias_todas.aspx"><img src="<%= Page.ResolveUrl("~")%>assets/img/delete.png" alt="delete"/></a></td>
                                        <td>0</td>
                                        <td>Sin evaluador</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
</asp:Content>




