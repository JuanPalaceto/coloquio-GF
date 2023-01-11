using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Text;

public partial class reporte_ponencias : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string reportePonencias(){

        int usu = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);

        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ReportePonencias", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered\"><thead><tr><th scope=\"col\" hidden=\"hidden\">IdPonencia</th><th scope=\"col\">Título de Ponencias</th><th scope=\"col\">Autores</th><th scope=\"col\">Area Tematica</th><th scope=\"col\" style=\"max-width: 100px;\">Modalidad</th><th scope=\"col\">Resultado</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        int resultado = Convert.ToInt32(drseldatos["estado"].ToString());
                        
                        sb.Append("<tr>");
                        sb.Append("<td hidden=\"hidden\">" + drseldatos["idPonencia"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["titulo"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["autor"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["tema"].ToString() + "</td>");  
                        sb.Append("<td>" + drseldatos["modalidad"].ToString() + "</td>");                                     
                        //sb.Append("<td>" + drseldatos["estatuss"].ToString() + "</td>");
                        switch (resultado)
                        {
                            case 2:
                                sb.Append("<td align=\"center\" class=\"align-middle\"><i class=\"fa-sharp fa-solid fa-check text-success\" style=\"font-size:1.2em;\"></i></td>");
                                break;
                            case 3:
                                sb.Append("<td align=\"center\" class=\"align-middle\"><i class=\"fa-sharp fa-solid fa-xmark text-danger\" style=\"font-size:1.2em;\"></i></td>");
                                break;
                            default: 
                                sb.Append("<td align=\"center\" class=\"align-middle\"><i class=\"fa-sharp fa-solid fa-hourglass-half text-secondary\" style=\"font-size:1.2em;\"></i></td>");
                                break;
                        }
                        /*sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-info fa fa-pencil text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"editarPonencia("+drseldatos["idPonencia"].ToString()+");\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-primary fa fa-user-pen text-white m-1\" style=\"width: 1.2em; height: 1.5em;\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-download text-white\" style=\"width: 1.2em; height: 1.5em;\"></button></td></tr>");*/
                         sb.Append("</tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<td colspan=\"5\" style=\"text-align: center;\">No hay registros disponibles.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }
}