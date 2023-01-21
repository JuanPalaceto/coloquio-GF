using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    string idusu;
    int tipoUsuario;
    public string nombreUsu, pagInicio, menuDisponible, cambiaRol = string.Empty, cambiaRolMovil = string.Empty, tipoRol = string.Empty, modulo;
    protected void Page_Load(object sender, EventArgs e)
    {
        idusu = Convert.ToString(HttpContext.Current.Session["idusuario"]);
        nombreUsu = Convert.ToString(HttpContext.Current.Session["nombreUsu"]);


        tipoUsuario = Convert.ToInt32(HttpContext.Current.Session["tipoUsuario"]);

        // Para el menú disponible, quizá haya que cambiar /coloquio/ por /Coloquio/
        switch (tipoUsuario)
        {
            // Ponente
            case 1:
                pagInicio = "/Coloquio/modulos/ponencias/ponencias_listar.aspx";
                modulo = "Ponencias";
                menuDisponible = @"<a class=""nav-link"" href=""/coloquio/modulos/ponencias/ponencias_listar.aspx""><div class=""sb-nav-link-icon""><i class=""fa-solid fa-file-lines""></i></div>Mis Ponencias</a>
									<a class=""nav-link"" href=""/coloquio/modulos/ponencias/ponencias_registrar.aspx"" onclick=""nuevaPonencia();""><div class=""sb-nav-link-icon""><i class=""fa-solid fa-file-circle-plus""></i></div>Registrar Ponencia</a>";
                break;
            // Evaluador
            case 2:
                pagInicio = "/Coloquio/modulos/evaluacion/ponencias_evaluar.aspx";
                modulo = "Evaluación";
                menuDisponible = @"<a class=""nav-link"" href=""/coloquio/modulos/evaluacion/ponencias_evaluar.aspx""><div class=""sb-nav-link-icon""><i class=""fa-solid fa-clipboard-list""></i></div>Ponencias Asignadas</a>
									<a class=""nav-link"" href=""/coloquio/modulos/evaluacion/ponencias_evaluadas.aspx""><div class=""sb-nav-link-icon""><i class=""fa-solid fa-clipboard-check""></i></div>Ponencias Evaluadas</a>
									<a class=""nav-link"" href=""/coloquio/modulos/evaluacion/ponencias_invitacion.aspx""><div class=""sb-nav-link-icon""><i class=""fa-solid fa-clipboard-question""></i></div>Invitaciones</a>";
                cambiaRol = @"<ul class=""navbar-nav ms-auto ms-md-0 me-lg-2 muestraMenu"">
								<li class=""nav-item dropdown"">
									<a class=""nav-link dropdown-toggle"" id=""navbarDropdown"" href=""#"" role=""button"" data-bs-toggle=""dropdown"" aria-expanded=""false""><i class=""fas fa-user fa-fw""></i></a>
									<ul class=""dropdown-menu dropdown-menu-end"" aria-labelledby=""navbarDropdown"">
										<li><a id=""btnCambiarRol"" class=""dropdown-item"" href=""#!"" data-bs-toggle=""modal"" data-bs-target=""#modalRol"">Cambiar de Rol</a></li>
									</ul>
								</li>
							</ul>";
                cambiaRolMovil = @"<a class=""nav-link collapsed"" href=""#"" data-bs-toggle=""collapse"" data-bs-target=""#collapseRol"" aria-expanded=""false"" aria-controls=""collapseRol"">
									<div class=""sb-nav-link-icon""><i class=""fas fa-user fa-fw""></i></div>
									Rol de Usuario
									<div class=""sb-sidenav-collapse-arrow""><i class=""fas fa-angle-down""></i></div>
								</a>
								<div class=""collapse"" id=""collapseRol"" aria-labelledby=""headingOne"" data-bs-parent=""#sidenavAccordion"">
									<nav class=""sb-sidenav-menu-nested nav"">
										<a class=""nav-link"" href=""#"" data-bs-toggle=""modal"" data-bs-target=""#modalRol"">Cambiar de Rol</a>
									</nav>
								</div>";
                tipoRol = "Ponente";
                break;
            // Administrador
            case 3:
                pagInicio = "/Coloquio/modulos/administrador/ediciones.aspx";
                modulo = "Administrador";
                menuDisponible = @"<a class=""nav-link"" href=""/coloquio/modulos/administrador/ediciones.aspx"">Ediciones</a>
									<a class=""nav-link"" href=""/coloquio/modulos/administrador/modalidades.aspx"">Modalidades</a>
									<a class=""nav-link"" href=""/coloquio/modulos/administrador/temas.aspx"">Temas</a>
									<a class=""nav-link"" href=""/coloquio/modulos/administrador/usuarios.aspx"">Usuarios</a>
									<a class=""nav-link"" href=""/coloquio/modulos/administrador/secciones.aspx"">Secciones</a>
									<a class=""nav-link"" href=""/coloquio/modulos/administrador/parametros.aspx"">Parámetros</a>
									<a class=""nav-link collapsed"" href=""#"" data-bs-toggle=""collapse"" data-bs-target=""#pagesCollapsePonenciasList"" aria-expanded=""false"" aria-controls=""pagesCollapsePonenciasList"">
									<div class=""sb-nav-link-icon""><i class=""fa-solid fa-file-lines""></i></div>
										Ponencias
										<div class=""sb-sidenav-collapse-arrow""><i class=""fas fa-angle-down""></i></div>
									</a>
									<div class=""collapse"" id=""pagesCollapsePonenciasList"" aria-labelledby=""headingSix"" data-bs-parent=""#sidenavAccordionPages"">
										<nav class=""sb-sidenav-menu-nested nav"">
											<a class=""nav-link"" href=""/coloquio/modulos/administrador/invitaciones.aspx"">Ponencias sin asignar</a>
											<a class=""nav-link"" href=""/coloquio/modulos/ponencias/ponencias_clasificadas.aspx"">Ponencias evaluadas</a>
										</nav>
									</div>
                                    <a class=""nav-link collapsed"" href=""#"" data-bs-toggle=""collapse"" data-bs-target=""#collapseReportes"" aria-expanded=""false"" aria-controls=""collapseReportes"">
									<div class=""sb-nav-link-icon""><i class=""fa-solid fa-file-export""></i></div>
                                        Reportes
                                        <div class=""sb-sidenav-collapse-arrow""><i class=""fas fa-angle-down""></i></div>
                                    </a>
                                    <div class=""collapse"" id=""collapseReportes"" aria-labelledby=""headingThree"" data-bs-parent=""#sidenavAccordionPages"">
                                        <nav class=""sb-sidenav-menu-nested nav"">
                                            <a class=""nav-link"" href=""/coloquio/modulos/reportes/reporte_ponencias.aspx"">Reporte de Ponencias</a>
                                            <a class=""nav-link"" href=""/coloquio/modulos/reportes/reporte_evaluadores.aspx"">Reporte de Evaluadores</a>
                                        </nav>
                                    </div>";
                break;
            // Temporal para cambiar de Evaluador a ponente
            default:
                pagInicio = "/coloquio/modulos/ponencias/ponencias_listar.aspx";
                modulo = "Ponencias";
                menuDisponible = @"<a class=""nav-link"" href=""/coloquio/modulos/ponencias/ponencias_listar.aspx""><div class=""sb-nav-link-icon""><i class=""fa-solid fa-file-lines""></i></div>Mis Ponencias</a>
									<a class=""nav-link"" href=""/coloquio/modulos/ponencias/ponencias_registrar.aspx"" onclick=""nuevaPonencia();""><div class=""sb-nav-link-icon""><i class=""fa-solid fa-file-circle-plus""></i></div>Registrar Ponencia</a>";
                cambiaRol = @"<ul class=""navbar-nav ms-auto ms-md-0 me-3 me-lg-2 muestraMenu"">
								<li class=""nav-item dropdown"">
									<a class=""nav-link dropdown-toggle"" id=""navbarDropdown"" href=""#"" role=""button"" data-bs-toggle=""dropdown"" aria-expanded=""false""><i class=""fas fa-user fa-fw""></i></a>
									<ul class=""dropdown-menu dropdown-menu-end"" aria-labelledby=""navbarDropdown"">
										<li><a id=""btnCambiarRol"" class=""dropdown-item"" href=""#!"" data-bs-toggle=""modal"" data-bs-target=""#modalRol"">Cambiar de Rol</a></li>
									</ul>
								</li>
							</ul>";
                cambiaRolMovil = @"<a class=""nav-link collapsed"" href=""#"" data-bs-toggle=""collapse"" data-bs-target=""#collapseRol"" aria-expanded=""false"" aria-controls=""collapseRol"">
									<div class=""sb-nav-link-icon""><i class=""fas fa-user fa-fw""></i></div>
									Rol de Usuario
									<div class=""sb-sidenav-collapse-arrow""><i class=""fas fa-angle-down""></i></div>
								</a>
								<div class=""collapse"" id=""collapseRol"" aria-labelledby=""headingOne"" data-bs-parent=""#sidenavAccordion"">
									<nav class=""sb-sidenav-menu-nested nav"">
										<a class=""nav-link"" href=""#"" data-bs-toggle=""modal"" data-bs-target=""#modalRol"">Cambiar de Rol</a>
									</nav>
								</div>";
                tipoRol = "Evaluador";
                break;
        }

        if (idusu == null || idusu == "")
        {
            Response.Redirect("~/login/login.aspx");
        }

    }

    protected void CambiarRol_Click(object sender, EventArgs e)
    {
        // Si es evaluador, cambialo a ponente(temporal), de lo contrario debe ser ponente(temporal), por lo tanto se regresa a evaluador
        if (Convert.ToInt32(Session["tipoUsuario"]) == 2)
        {
            Session["tipoUsuario"] = 4;
            Response.Redirect("/coloquio/modulos/ponencias/ponencias_listar.aspx");
        }
        else
        {
            Session["tipoUsuario"] = 2;
            Response.Redirect("/coloquio/modulos/evaluacion/ponencias_evaluar.aspx");
        }
    }
}
