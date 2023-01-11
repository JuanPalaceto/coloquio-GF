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

public partial class modulos_evaluacion_evaluacion : System.Web.UI.Page
{
    public string titulo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        titulo = Convert.ToString(HttpContext.Current.Session["titulo"]);

    }

    [WebMethod]
    public static string TablaListarPonencias()
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("Evaluacion", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    string x = "";
                    int ptsTotales = 0;
                    int regNum = 0;

                    if (drseldatos.HasRows)
                        sb.Append("<table id=\"tabla\" width=\"100%\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Sección</th><th  scope=\"col\">Parámetros</th><th hidden>idParametro</th><th scope=\"col\" style=\"text-align:center !important\">Puntaje Máximo</th><th scope=\"col\" style=\"text-align:center !important\">Puntaje Otorgado</th></tr></thead><tbody>");
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
                        sb.Append("<td hidden data-order=\"\" id=\"idPar" + regNum + "\">" + drseldatos["idParametro"].ToString() + "</td>");
                        sb.Append("<td align=\"center\" data-order=\"\">" + puntajeMax + "</td>");
                        sb.Append("<td align=\"center\" data-order=\"\"><select id=\"sel" + regNum + "\" oninput=sumatoria(); id=\"txtPuntaje" + puntajeMax + "\">");
                        sb.Append("<option value=\"\">Seleccione...</option>");
                        for (int i = 0; i <= puntajeMax; i++)
                        {
                            sb.Append("<option value=" + i + ">" + i + "</option>");
                        }
                        sb.Append("</option></select>");
                        regNum++;
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("<tfoot><tr>");
                        sb.Append("<td><b>Puntajes</b></td>");
                        sb.Append("<td style=\"text-align:right !important\"><b>Total:</b></td>");
                        sb.Append("<td style=\"text-align:center !important\"><b>" + ptsTotales + " Puntos</b></td>");
                        sb.Append("<td style=\"text-align:center !important\" id=\"pts\"><b>0 Puntos</b></td>");
                        sb.Append("</tr></tfoot>");
                        sb.Append("</tbody></table>");
                        sb.Append("<input type=\"hidden\" value=\"" + regNum + "\" id= \"regTot\"></input>");
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

    [WebMethod]
    public static string Guardar(string calif, string observaciones, string recomendaciones, string idParametro)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("GuardarEvaluacion", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;

                comand.Parameters.Add("@califs", SqlDbType.NVarChar).Value = calif;
                comand.Parameters.Add("@idParametro", SqlDbType.NVarChar).Value = idParametro;
                comand.Parameters.Add("@observaciones", SqlDbType.NVarChar, 500).Value = observaciones;
                comand.Parameters.Add("@recomendaciones", SqlDbType.NVarChar, 500).Value = recomendaciones;
                comand.Parameters.Add("@idEvaluacion", SqlDbType.Int).Value = Convert.ToString(HttpContext.Current.Session["idEvaluacion"]);

                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                pexitoso.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Exitoso = int.Parse(pexitoso.Value.ToString());
            }
            Conn.Close();
            return "{\"success\": \"" + Exitoso + "\"}";
        }
    }
}