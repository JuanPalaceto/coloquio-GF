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
        int estado;

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
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Título</th><th scope=\"col\">Modalidad</th><th scope=\"col\">Edición</th><th scope=\"col\" style=\"max-width: 120px;\">Fecha de Evaluación</th><th scope=\"col\" style=\"max-width: 50px;\">Ronda</th><th scope=\"col\" style=\"max-width: 60px;\">Evaluación</th><th scope=\"col\" style=\"max-width: 100px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        estado = Convert.ToInt32(drseldatos["aptoPublicacion"].ToString());
                        sb.Append("<tr>");
                        sb.Append("<td>" + drseldatos["titulo"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["modalidad"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["edicion"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["fechaEvaluacion"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["ronda"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle text-center\">");
                        switch (estado)
                        {
                            case 1:
                                sb.Append("<i class=\"fa-sharp fa-solid fa-check text-success\" style=\"font-size:1.2em;\"></i>");
                                break;
                            case 2:
                                sb.Append("<i class=\"fa-sharp fa-solid fa-xmark text-danger\" style=\"font-size:1.2em;\"></i>");
                                break; 
                            case 3:
                                sb.Append("<i class=\"fa-solid fa-triangle-exclamation text-warning\" style=\"font-size:1.2em;\"></i>");
                                break;                            
                        }
                        sb.Append("</td>");                        
                        sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-success fa-regular fa-clipboard text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"verEvaluacion(" + drseldatos["idPonencia"].ToString() + ",'" + drseldatos["titulo"].ToString() + "'," + drseldatos["idEvaluacion"].ToString() + ");\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-magnifying-glass text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"verPonencia(" + drseldatos["idPonencia"].ToString() + ", "+ drseldatos["idUsuario"].ToString() + ");\"></button></td></tr>");
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
    public static string VerEval(int idEvaluacion)
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("VerEvaluacion", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@idEvaluacion", idEvaluacion);
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    string x = "";
                    int ptsTotales = 0;
                    int suma = 0;

                    if (drseldatos.HasRows)
                        sb.Append("<table id=\"tablaEv\" width=\"100%\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Sección</th><th  scope=\"col\">Parámetro</th><th scope=\"col\" style=\"text-align:center !important; max-width: 100px !important;\">Puntaje Máximo</th><th scope=\"col\" style=\"text-align:center !important; max-width: 80px !important\">Puntaje Otorgado</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        int puntajeMax = Convert.ToInt32(drseldatos["puntajeMax"]);
                        ptsTotales += puntajeMax;
                        string y = Convert.ToString(drseldatos["seccion"]);

                        sb.Append("<tr>");
                        if (x == y)
                        {
                            sb.Append("<td style=\"font-size:0px\">" + drseldatos["seccion"].ToString() + "</td>");
                        }
                        else
                        {
                            sb.Append("<td data-order=\"\">" + drseldatos["seccion"].ToString() + "</td>");
                            x = Convert.ToString(drseldatos["seccion"]);
                        }
                        sb.Append("<td data-order=\"\">" + drseldatos["parametro"].ToString() + "</td>");                        
                        sb.Append("<td align=\"center\" data-order=\"\">" + puntajeMax + "</td>");
                        sb.Append("<td align=\"center\" data-order=\"\"><select class=\"form-select w-auto\" disabled>");
                        suma += Convert.ToInt32(drseldatos["calificacion"].ToString());
                        sb.Append("<option value=" + drseldatos["calificacion"].ToString() + ">" + drseldatos["calificacion"].ToString() + "</option>");
                        sb.Append("</select></td>");                        
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody>");
                        sb.Append("<tfoot><tr>");
                        sb.Append("<td><b>Puntajes</b></td>");
                        sb.Append("<td style=\"text-align:right !important\"><b>Total:</b></td>");
                        sb.Append("<td style=\"text-align:center !important\"><b>" + ptsTotales + " Puntos</b></td>");
                        sb.Append("<td style=\"text-align:center !important\"><b>" + suma + " Puntos</b></td>");
                        sb.Append("</tr></tfoot>");
                        sb.Append("</table>");                        
                    }
                    else
                    {
                        sb.Append("<table id=\"tabla\" width=\"100%\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Evaluación</th></tr></thead><tbody>");
                        sb.Append("<td style=\"text-align: center;\">No hay parámetros disponibles.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }
}
