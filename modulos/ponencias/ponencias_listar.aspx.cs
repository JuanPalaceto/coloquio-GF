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
using System.IO;

public partial class ponencias_listar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string TablaListarPonencias()
    {
        int user = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);

        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarPonencias", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@idUsuario", user);
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    if (drseldatos.HasRows)
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Título</th><th scope=\"col\" style=\"max-width: 100px;\">Estado</th><th scope=\"col\" style=\"max-width: 150px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        int resultado = Convert.ToInt32(drseldatos["estado"].ToString());

                        sb.Append("<tr>");
                        sb.Append("<td>" + drseldatos["titulo"].ToString() + "</td>");
                        // sb.Append("<td>" + drseldatos["tema"].ToString() + "</td>");
                        // sb.Append("<td>" + drseldatos["modalidad"].ToString() + "</td>");

                        // estados
                        switch (resultado)
                        {
                            // registro no completado
                            case 0:
                                sb.Append("<td align=\"center\" class=\"align-middle\"><i class=\"fa-solid fa-file-circle-question\" style=\"font-size:1.4em;\"></i></td>");
                                sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-info fa fa-pencil text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"editarPonencia(" + drseldatos["idPonencia"].ToString() + ");\"></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa fa-trash text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ConfirmarEliminar(" + drseldatos["idPonencia"].ToString() + ");\"></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-comment text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"notificacionComentarios();\"></button>");
                                break;
                            // registro completo
                            case 1:
                                sb.Append("<td align=\"center\" class=\"align-middle\"><i class=\"fa-solid fa-file-circle-check\" style=\"font-size:1.4em;\"></i></td>");                                
                                sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-pencil text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"notificacionEditar();\"></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-trash text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"notificacionBorrar();\"></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-comment text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"notificacionComentarios();\"></button>");
                                break;

                            // asignada
                            case 2:
                                sb.Append("<td align=\"center\" class=\"align-middle\"><i class=\"fa-solid fa-clipboard-user\" style=\"font-size:1.4em;\"></i></td>");
                                break;

                            // aprobada
                            case 3:
                                sb.Append("<td align=\"center\" class=\"align-middle\"><i class=\"fa-sharp fa-solid fa-check text-success\" style=\"font-size:1.4em;\"></i></td>");
                                break;

                            // reprobada
                            case 4:
                                sb.Append("<td align=\"center\" class=\"align-middle\"><i class=\"fa-sharp fa-solid fa-xmark text-danger\" style=\"font-size:1.4em;\"></i></td>");
                                break;

                            default:
                                sb.Append("<td>Sin estado.</td>");
                                break;
                        }

                        // sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-info fa fa-pencil text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"editarPonencia(" + drseldatos["idPonencia"].ToString() + ");\"></button>");
                        // sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa fa-trash text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ConfirmarEliminar(" + drseldatos["idPonencia"].ToString() + ");\"></button>");
                        // sb.Append("<button type=\"button\" class=\"btn btn-icon btn-success fa fa-comment text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"VerComentarios(" + drseldatos["idPonencia"].ToString() + ");\"></button>");
                        // sb.Append("<button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-download text-white\" style=\"width: 1.2em; height: 1.5em;\"></button></td></tr>");
                        sb.Append("</td></tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<table id=\"tabla\" width=\"100%\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Ponencias</th></tr></thead><tbody>");
                        sb.Append("<td style=\"text-align: center;\">No se han registrado ponencias.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }

    [WebMethod]
    public static string borrarPonencia(int id)
    {
        int Eliminado = 0;
        int user = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);
        string ruta = @"C:\inetpub\wwwroot\Coloquio\ponencias\" + user + "\\" + id;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("EliminarPonencia", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idPonencia", SqlDbType.Int).Value = id;

                SqlParameter peliminado = comand.Parameters.Add("@Eliminado", SqlDbType.Int);
                peliminado.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Eliminado = int.Parse(peliminado.Value.ToString());
            }
            Conn.Close();
            if (Eliminado == 1)
            {
                if (Directory.Exists(ruta))
                {
                    Directory.Delete(ruta,true);
                }
            }
            return "{\"success\": \"" + Eliminado + "\"}";
        }
    }
}