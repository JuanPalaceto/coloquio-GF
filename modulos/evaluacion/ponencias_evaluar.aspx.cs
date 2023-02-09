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
using System.Runtime.Remoting.Messaging;

public partial class ponencias_evaluar : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string TablaListarPonencias()
    {
        string user = Convert.ToString(HttpContext.Current.Session["idusuario"]);
        string clases = string.Empty, ronda = string.Empty;
        int numRonda;
        int comentarios;

        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarEvaluacion", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@idUsuario", user);
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    if (drseldatos.HasRows)
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Título</th><th scope=\"col\">Resumen</th><th scope=\"col\" style=\"max-width: 130px;\">Modalidad</th><th scope=\"col\" style=\"max-width: 50px;\">Ronda</th><th scope=\"col\" style=\"max-width: 130px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        // Guardo los comentarios y la ronda
                        comentarios = Convert.ToInt32(drseldatos["comentarios"].ToString());
                        ronda = drseldatos["ronda"].ToString();

                        sb.Append("<tr>");
                        sb.Append("<td>" + drseldatos["titulo"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["resumen"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["modalidad"].ToString() + "</td>");
                        if (int.TryParse(ronda, out numRonda))
                        {
                            sb.Append("<td>" + numRonda + "</td>");
                        } else
                        {                            
                            sb.Append("<td>1</td>");
                        }
                        
                        sb.Append("<td align=\"center\">");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-success fa-regular fa-clipboard text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"evaluar(" + drseldatos["idPonencia"].ToString() + ",'" + drseldatos["titulo"].ToString() + "'," + drseldatos["idEvaluacion"].ToString() + ");\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-dark fa fa-magnifying-glass text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"verPonencia(" + drseldatos["idPonencia"].ToString() + ", "+ drseldatos["idUsuario"].ToString() + ");\"></button>");
                        if (comentarios == 0)
                        {
                            clases = "btn-secondary";
                        }
                        else
                        {
                            clases = "btn-success";
                        }
                        sb.Append("<button type=\"button\" class=\"btn btn-icon " + clases + " fa-solid fa-comment text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"verComentarios(" + drseldatos["idPonencia"].ToString() + ");\"></button>");
                        sb.Append("</td>");
                        sb.Append("</tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Ponencias</th></tr></thead><tbody>");
                        sb.Append("<td colspan=\"3\" style=\"text-align: center;\">No hay evaluaciones pendientes.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }


    [WebMethod]
    public static string evaluar(int id, string titulo, int idEvaluacion)
    {
        int Exitoso = 1;
        HttpContext.Current.Session["idponencia"] = id;
        HttpContext.Current.Session["titulo"] = titulo;
        HttpContext.Current.Session["idEvaluacion"] = idEvaluacion;
        return "{\"Success\": \"" + Exitoso + "\"}";
    }


    [WebMethod]
    public static string TraeDatos(int id)
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("TraeDatos", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@id", SqlDbType.Int).Value = id;
                Conn.Open();
                using (SqlDataReader dr = comand.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        sb.Append("{\"titulo\": \"" + dr["titulo"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"modalidad\": \"" + dr["modalidad"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"tema\": \"" + dr["tema"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"resumen\": \"" + dr["resumen"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"palabrasClave\": \"" + dr["palabrasClave"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"}");
                    }
                    dr.Close();
                }
            }
            Conn.Close();
        }
        HttpContext.Current.Session["idponencia"] = id;

        return sb.ToString();
    }


    [WebMethod]
    public static string VerComentarios(int id)
    {        
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("VerComentarios", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@idPonencia", id);
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    if (drseldatos.HasRows)
                        sb.Append("<table id=\"tablaComentarios\" class=\"table table-striped table-bordered w-100\"><thead><tr><th scope=\"col\">Fecha</th><th scope=\"col\">Evaluador</th><th scope=\"col\">Comentarios</th><th scope=\"col\">Ronda</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        sb.Append("<tr>");
                        sb.Append("<td>" + drseldatos["fecha"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["evaluador"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["comentarios"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["ronda"].ToString() + "</td>");
                        sb.Append("</tr>");                        
                    }
                    
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        //Aquí tengo que encontrar la lógica para cuando no haya comentarios poder saberlo en js
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }
}
