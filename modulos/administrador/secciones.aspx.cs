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

public partial class modulos_administrador_secciones : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string TablaListarEdiciones()
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarSecciones", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Sección</th><th scope=\"col\" style=\"max-width: 150px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        sb.Append("<tr>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["seccion"].ToString() + "</td>");
                        sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-info fa fa-pencil text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ModalEditar(" + drseldatos["idSeccion"].ToString() + ",'" + drseldatos["idSeccion"].ToString() + "');\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa fa-trash text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ConfirmarEliminar(" + drseldatos["idSeccion"].ToString() + ");\"></button></td></tr>");

                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<td colspan=\"2\" style=\"text-align: center;\">No hay ediciones disponibles.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }

    [WebMethod]
    public static string GuardarSeccion(string seccion)
    {
        int Exitoso = 0;
        using (SqlConnection con = conexion.conecta())
        {
            using (SqlCommand comand = new SqlCommand("AgregarModalidad", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@seccion", SqlDbType.NVarChar, 120).Value = Nombre;
                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                pexitoso.Direction = ParameterDirection.Output;
                con.Open();
                comand.ExecuteNonQuery();
                Exitoso = int.Parse(pexitoso.Value.ToString());
            }
            con.Close();
            return "{\"success\": \"" + Exitoso + "\"}";
        }
    }

    [WebMethod]
    public static string ActualizarUsu(string seccion, int id)
    {
        int Exitoso = 0;
        using (SqlConnection con = conexion.conecta())
        {
            using (SqlCommand comand = new SqlCommand("ActualizarModalidad", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@seccion", SqlDbType.NVarChar, 120).Value = Nombre;
                comand.Parameters.Add("@id", SqlDbType.Int).Value = id;
                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                pexitoso.Direction = ParameterDirection.Output;
                con.Open();
                comand.ExecuteNonQuery();
                Exitoso = int.Parse(pexitoso.Value.ToString());
            }
            con.Close();
            return "{\"success\": \"" + Exitoso + "\"}";
        }
    }
}