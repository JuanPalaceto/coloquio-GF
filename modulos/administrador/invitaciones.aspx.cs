using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Script.Serialization;
using System.Net;
using System.Net.Mail;

public partial class modulos_administrador_invitaciones : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DropEdicion();
    }

    [WebMethod]
    public static string GetEvaluadores(string term)
    {
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand command = new SqlCommand("TraeEvaluadores", con))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@parametro", term.Trim());


                command.Parameters.AddWithValue("@parametro", term.Trim());

                con.Open();

                SqlDataReader reader = command.ExecuteReader();

                List<Evaluador> evaluadores = new List<Evaluador>();

                while (reader.Read())
                {
                    evaluadores.Add(new Evaluador
                    {
                        ID = reader.GetInt32(0),
                        Nombre = reader.GetString(1),
                        Correo = reader.GetString(2)
                    });
                }
                reader.Close();
                reader.Dispose();

                con.Close();

                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string jsonString = serializer.Serialize(evaluadores);

                return jsonString;
            }
        }
    }

    public class Evaluador
    {
        public int ID { get; set; }
        public string Nombre { get; set; }
        public string Correo { get; set; }
    }

    public class Evaluador
    {
        public int ID { get; set; }
        public string Nombre { get; set; }
        public string Correo { get; set; }
    }

    private void DropEdicion()
    {
        int edicionActiva = Convert.ToInt32(Session["edicionActiva"]);
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand cmdSelEdicion = new SqlCommand("SelEdicioness", con))
            {
                cmdSelEdicion.CommandType = CommandType.StoredProcedure;
                con.Open();

                // Para agenerar el select con las ediciones
                selectEd.Items.Clear();
                selectEd.AppendDataBoundItems = true;

                SqlDataReader drEd = cmdSelEdicion.ExecuteReader();

                while (drEd.Read())
                {
                    if (int.Parse(drEd["idEdicion"].ToString()) == edicionActiva){
                         selectEd.Items.Add(new ListItem(drEd["edicion"].ToString() + "(activa)", drEd["idEdicion"].ToString()));
                    } else {
                         selectEd.Items.Add(new ListItem(drEd["edicion"].ToString(), drEd["idEdicion"].ToString()));
                    }
                }

                drEd.Close();
                drEd.Dispose();

                selectEd.SelectedValue = edicionActiva.ToString();
            }
        }
    }


    [WebMethod]
    public static string TablaListarPonencias(int idEdicion)
    {
        int tipoUser = Convert.ToInt32(HttpContext.Current.Session["tipoUsuario"]);

        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarPonenciasInvitar", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@tipoUsuario", tipoUser);
                seldata.Parameters.AddWithValue("@edicion", idEdicion);
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Título</th><th scope=\"col\">Tema</th><th scope=\"col\">Modalidad</th><th scope=\"col\" style=\"max-width: 100px;\">Estatus</th><th scope=\"col\" style=\"max-width: 100px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        int resultado = Convert.ToInt32(drseldatos["estado"].ToString());

                        sb.Append("<tr>");
                        sb.Append("<td width=\"\" class=\"align-middle\">" + drseldatos["titulo"].ToString() + "</td>");
                        sb.Append("<td width=\"\" class=\"align-middle\">" + drseldatos["tema"].ToString() + "</td>");
                        sb.Append("<td width=\"\" class=\"align-middle\">" + drseldatos["modalidad"].ToString() + "</td>");
                        // estados
                        switch (resultado)
                        {
                            // registro no completado
                            // case 0:
                            //     sb.Append("<td align=\"center\" class=\"align-middle\"><i class=\"fa-solid fa-list-check text-secondary\" style=\"font-size:1.2em;\"></i></td>");
                            //     break;
                            // no evaluada
                            case 1:
                                sb.Append("<td align=\"center\" class=\"align-middle\" data-order=\"1\"><i class=\"fa-sharp fa-solid fa-hourglass-half text-secondary\" style=\"font-size:1.2em;\"></i></td>");
                                break;

                            // evaluando
                            case 2:
                                sb.Append("<td align=\"center\" class=\"align-middle\" data-order=\"2\"><i class=\"fa-sharp fa-solid fa-clock text-secondary\" style=\"font-size:1.2em;\"></i></td>");
                                break;

                            // aceptada
                            case 3:
                                sb.Append("<td align=\"center\" class=\"align-middle\" data-order=\"3\"><i class=\"fa-sharp fa-solid fa-check text-success\" style=\"font-size:1.2em;\"></i></td>");
                                break;

                            // rechazada
                            case 4:
                                sb.Append("<td align=\"center\" class=\"align-middle\" data-order=\"4\"><i class=\"fa-sharp fa-solid fa-xmark text-danger\" style=\"font-size:1.2em;\"></i></td>");
                                break;

                            default:
                                sb.Append("<td data-order=\"5\">Sin estado.</td>");
                                break;
                        }
                        sb.Append("<td align=\"center\" class=\"align-middle\">");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-secondary fa-solid fa-magnifying-glass text-white w50\" onclick=\"verPonencia(" + drseldatos["idPonencia"].ToString() + ", "+ drseldatos["idUsuario"].ToString() + ");\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-info fa-solid fa-user-gear text-white w50\" onclick=\"editarEvaluador(" + drseldatos["idPonencia"].ToString() + ", '"+ drseldatos["titulo"].ToString() +"');\"></button>");
                        sb.Append("</td>");
                        sb.Append("</tr>");
                    }
                    sb.Append("</tbody></table>");
                    // Para esconder el botón de guardaar si es una edición que no es la activa
                    sb.Append("<script>ocultaBoton("+Convert.ToInt32(HttpContext.Current.Session["edicionActiva"])+");</script>");

                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }


    [WebMethod]
    public static string ListarEvaluadores(int idPonencia, int idEdicion)
    {
        int edicionActiva = Convert.ToInt32(HttpContext.Current.Session["edicionActiva"]);
        int edicionActiva = Convert.ToInt32(HttpContext.Current.Session["edicionActiva"]);
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarEvaluadores", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@idPonencia", idPonencia);

                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<table id=\"tablaEvaluadores\" class=\"table table-striped table-bordered \">");
                    sb.Append("<thead>");
                    sb.Append("<tr>");
                    sb.Append("<th scope=\"col\"style=\"width: 500px;\">Nombre</th>");
                    sb.Append("<th scope=\"col\" style=\"width: 80px;\">Estado</th>");
                    sb.Append("<th scope=\"col\" style=\"width: 80px;\">Retirar</th>");
                    sb.Append("<th scope=\"col\" style=\"width: 80px;\">Retirar</th>");
                    sb.Append("</tr>");
                    sb.Append("</thead>");
                    sb.Append("<tbody>");
                    while (drseldatos.Read())
                    {
                        int estado = Convert.ToInt32(drseldatos["estado"].ToString());

                        int estado = Convert.ToInt32(drseldatos["estado"].ToString());

                        sb.Append("<tr>");
                        sb.Append("<td class=\"align-middle\">");
                        sb.Append("" + drseldatos["nombre"].ToString() + "");
                        sb.Append("</td>");
                        sb.Append("<td class=\"text-center align-middle\">");
                        // estados
                        switch (estado)
                        {
                            // pendiente
                            case 0:
                                sb.Append("<i class=\"fa-sharp fa-solid fa-hourglass-half text-secondary\" style=\"font-size:1.2em;\"></i>");
                                break;

                            // aceptada
                            case 1:
                                sb.Append("<i class=\"fa-sharp fa-solid fa-check text-success\" style=\"font-size:1.2em;\"></i>");
                                break;
                            // rechazada
                            case 2:
                                sb.Append("<i class=\"fa-sharp fa-solid fa-xmark text-danger\" style=\"font-size:1.2em;\"></i>");
                                break;
                            // Podría agregarse el estado 3, cuando ya realizó la evaluación
                            default:
                                //Pues aquí la loógica o catcheado por el case
                                break;
                        }
                        sb.Append("</td>");
                        sb.Append("<td class=\"text-center align-middle\">");
                        if (idEdicion != edicionActiva){
                            sb.Append("<button type=\"button\" class=\"btn btn-danger text-white\" disabled><i class=\"fa-solid fa-circle-minus\"></i></button>");
                        } else {
                            sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa-solid fa-circle-minus text-white w50\" onclick=\"retirarEvaluador(" + idPonencia + ", "+ drseldatos["idUsuario"].ToString() + ");\"></button>");
                        }
                        sb.Append("</td>");
                        sb.Append("<td class=\"text-center align-middle\">");
                        if (idEdicion != edicionActiva){
                            sb.Append("<button type=\"button\" class=\"btn btn-danger text-white\" disabled><i class=\"fa-solid fa-circle-minus\"></i></button>");
                        } else {
                            sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa-solid fa-circle-minus text-white w50\" onclick=\"retirarEvaluador(" + idPonencia + ", "+ drseldatos["idUsuario"].ToString() + ");\"></button>");
                        }
                        sb.Append("</td>");
                        sb.Append("</tr>");
                    }
                    sb.Append("</tbody>");
                    sb.Append("</table>");

                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }


    [WebMethod]
    public static string EnviaInvitacion(int idPonencia, int idEvaluador)
    {
        int Exitoso = 0;
        string Nombre = "", Apellido = "", Email = "", Titulo = "";

        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("EnviarInvitacion", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idPonencia", SqlDbType.Int).Value = idPonencia;
                comand.Parameters.Add("@idEvaluador", SqlDbType.Int).Value = idEvaluador;

                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                SqlParameter pnombre = comand.Parameters.Add("@Nombre", SqlDbType.NVarChar, 150);
                SqlParameter papellido = comand.Parameters.Add("@Apellido", SqlDbType.NVarChar, 150);
                SqlParameter pemail = comand.Parameters.Add("@Email", SqlDbType.NVarChar, 150);
                SqlParameter ptitulo = comand.Parameters.Add("@Titulo", SqlDbType.NVarChar, 150);
                pexitoso.Direction = ParameterDirection.Output;
                pnombre.Direction = ParameterDirection.Output;
                papellido.Direction = ParameterDirection.Output;
                pemail.Direction = ParameterDirection.Output;
                ptitulo.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Exitoso = int.Parse(pexitoso.Value.ToString());
                Nombre = pnombre.Value.ToString();
                Apellido = papellido.Value.ToString();
                Email = pemail.Value.ToString();
                Titulo = ptitulo.Value.ToString();
            }
            Conn.Close();
            if (Exitoso == 2)
            {
                using (MailMessage mm = new MailMessage("a2143040255@alumnos.uat.edu.mx", Email.Trim()))
                {
                    mm.Subject = "Invitación de evaluador";
                    mm.Body = "Apreciable: <b>" + Nombre + " " + Apellido + "</b><br /><br />Le informamos que ha sido cordialmente invitado a evaluar la ponencia: <b>" + Titulo + "</b>.<br /><br />Para responder la invitación favor de confirmarlo en el sistema. <br /><br /> Saludos cordiales".Trim();
                    mm.IsBodyHtml = true;
                    SmtpClient smtp = new SmtpClient();
                    smtp.Host = "smtp.office365.com";
                    smtp.EnableSsl = true;
                    NetworkCredential networkCred = new NetworkCredential("a2143040255@alumnos.uat.edu.mx", "Pcsv43k5zg");
                    smtp.UseDefaultCredentials = true;
                    smtp.Credentials = networkCred;
                    smtp.Port = 587;
                    smtp.Send(mm);
                }
            }
            return "{\"success\": \"" + Exitoso + "\"}";
        }
    }


    [WebMethod]
    public static string RetiraInvitacion(int idPonencia, int idEvaluador)
    {
        int Exitoso = 0;

        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("RetirarEvaluador", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idPonencia", SqlDbType.Int).Value = idPonencia;
                comand.Parameters.Add("@idEvaluador", SqlDbType.Int).Value = idEvaluador;

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
    public static string TablaListarAutores(int id)
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarAutores", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@idPonencia", id);
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    if (drseldatos.HasRows)
                        sb.Append("<table id=\"tablaAutores\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Nombre</th><th scope=\"col\">Tipo</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        sb.Append("<tr class=\"align-middle\">");
                        sb.Append("<td width=\"60%\">" + drseldatos["autor"].ToString() + "</td>");
                        sb.Append("<td width=\"20%\">" + drseldatos["tipoAutor"].ToString() + "</td>");
                        sb.Append("</tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Autores</th></tr></thead><tbody>");
                        sb.Append("<tr><td style=\"text-align: center;\">No se han registrado autores.</td></tr></tbody></table>");
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
}
