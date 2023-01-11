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

public partial class modulos_evaluacion_ponencias_evaluadas : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string TablaListarPonencias()
    {
        string user = Convert.ToString(HttpContext.Current.Session["idusuario"]);

        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarEvaluadas", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@idUsuario", user);
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    if (drseldatos.HasRows)
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Título</th><th scope=\"col\">Modalidad</th><th scope=\"col\">Edición</th><th scope=\"col\">Fecha de Evaluación</th><th scope=\"col\" style=\"max-width: 150px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        sb.Append("<tr>");
                        sb.Append("<td>" + drseldatos["titulo"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["modalidad"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["edicion"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["fechaEvaluacion"].ToString() + "</td>");
                        sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-success fa-regular fa-clipboard text-white\" style=\"width: 1.2em; height: 1.5em;\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-download text-white m-1\" style=\"width: 1.2em; height: 1.5em;\"></button></td></tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Evaluaciones</th></tr></thead><tbody>");
                        sb.Append("<td colspan=\"3\" style=\"text-align: center;\">No se han evaluado ponencias.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }
}