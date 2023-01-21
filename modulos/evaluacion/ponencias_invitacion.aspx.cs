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

public partial class modulos_evaluacion_ponencias_invitacion : System.Web.UI.Page
{
    protected string idusuario;
    protected void Page_Load(object sender, EventArgs e)
    {
        idusuario = Convert.ToString(HttpContext.Current.Session["idusuario"]);
    }

    [WebMethod]
    public static string TablaListarInvitacion()
    {
        string user = Convert.ToString(HttpContext.Current.Session["idusuario"]);

        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarInvitacion", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@idUsuario", user);
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    if (drseldatos.HasRows)
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Título</th><th scope=\"col\">Resumen</th><th scope=\"col\">Modalidad</th><th scope=\"col\" style=\"max-width: 150px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        sb.Append("<tr>");
                        sb.Append("<td width=\"20%\">" + drseldatos["titulo"].ToString() + "</td>");
                        sb.Append("<td width=\"40%\">" + drseldatos["resumen"].ToString() + "</td>");
                        sb.Append("<td width=\"20%\">" + drseldatos["modalidad"].ToString() + "</td>");
                        sb.Append("<td  width=\"20%\" align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-success fa-sharp fa-solid fa-check text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"AceptarInvitacion(" + drseldatos["idInvitacion"].ToString() + "," + drseldatos["idPonencia"].ToString() + ");\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa-sharp fa-solid fa-xmark text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"RechazarInvitacion(" + drseldatos["idInvitacion"].ToString() + ");\"></button></td></tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Ponencias</th></tr></thead><tbody>");
                        sb.Append("<td colspan=\"3\" style=\"text-align: center;\">No hay invitaciones pendientes.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }

    [WebMethod]
    public static string AceptarInvitacion(int idInvitacion, int idPonencia, int idUsuario)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("AceptarInvitacion", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idInvitacion", SqlDbType.Int).Value = idInvitacion;
                comand.Parameters.Add("@idPonencia", SqlDbType.Int).Value = idPonencia;
                comand.Parameters.Add("@idUsuario", SqlDbType.Int).Value = idUsuario;

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

    [WebMethod]
    public static string RechazarInvitacion(int id)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("RechazarInvitacion", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idInvitacion", SqlDbType.Int).Value = id;

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