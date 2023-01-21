using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class modulos_administrador_parametros : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string TablaListarParametros()
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarParametros", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Sección</th><th scope=\"col\">Parametro</th><th scope=\"col\">Puntaje Maximo</th><th scope=\"col\">Estado</th><th scope=\"col\" style=\"max-width: 150px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        int activo = Convert.ToInt32(drseldatos["activo"].ToString());

                        sb.Append("<tr>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["seccion"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["parametro"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["puntajeMax"].ToString() + "</td>");
                        if(activo == 1){
                            sb.Append("<td data-order=\"1\" align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-success fa fa-check text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"alternarActivo(" + drseldatos["idParametro"].ToString() + ");\"></button>");
                        } else {
                            sb.Append("<td data-order=\"0\" align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-ban text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"alternarActivo(" + drseldatos["idParametro"].ToString() + ");\"></button>");
                        }

                        sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-info fa fa-pencil text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ModificarSeccion(" + drseldatos["idParametro"].ToString() + ");\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa fa-trash text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ConfirmarEliminar(" + drseldatos["idParametro"].ToString() + ");\"></button></td></tr>");

                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<td colspan=\"6\" style=\"text-align: center;\">No hay parametros disponibles.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }
}