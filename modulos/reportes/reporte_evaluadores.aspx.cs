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


public partial class reporte_evaluadores : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string reporteEvaluadores(){

        int usu = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);

        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ReporteEvaluadores", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<div><table id=\"tabla\" class=\"table table-striped table-bordered\"><thead><tr><th scope=\"col\" hidden=\"hidden\">IdUsuario</th><th scope=\"col\">Correo</th><th scope=\"col\">Nombre completo</th><th scope=\"col\">Grado</th><th scope=\"col\" style=\"max-width: 100px;\">Tipo</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        //int resultado = Convert.ToInt32(drseldatos["tipo"].ToString());
                        
                        sb.Append("<tr>");
                        sb.Append("<td hidden=\"hidden\">" + drseldatos["idUsuario"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["email"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["Nombre"].ToString() + "</td>");  
                        sb.Append("<td>" + drseldatos["grado"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["tipo"].ToString() + "</td>");                                     
                        //sb.Append("<td>" + drseldatos["estatuss"].ToString() + "</td>");
                        /*switch (resultado)
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
                        sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-info fa fa-pencil text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"editarPonencia("+drseldatos["idPonencia"].ToString()+");\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-primary fa fa-user-pen text-white m-1\" style=\"width: 1.2em; height: 1.5em;\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-download text-white\" style=\"width: 1.2em; height: 1.5em;\"></button></td></tr>");*/
                        sb.Append("</tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table></div>");
                    }
                    else
                    {
                        sb.Append("<td colspan=\"5\" style=\"text-align: center;\">No hay registros disponibles.</td></tbody></table></div>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }
}