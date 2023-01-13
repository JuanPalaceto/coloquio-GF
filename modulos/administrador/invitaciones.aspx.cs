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

public partial class modulos_administrador_invitaciones : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DropEdicion();
    }


     private void DropEdicion()
    {
        int edicionActiva = Convert.ToInt32(Session["edicionActiva"]);
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand cmdSelEdicion = new SqlCommand("SelEdiciones", con))
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
                    sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Título</th><th scope=\"col\">Tema</th><th scope=\"col\">Modalidad</th><th scope=\"col\" style=\"max-width: 100px;\">Estatus</th><th scope=\"col\" style=\"max-width: 100px;\">Ponencia</th><th scope=\"col\" style=\"max-width: 100px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        int resultado = Convert.ToInt32(drseldatos["estado"].ToString());

                        sb.Append("<tr>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["titulo"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["tema"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["modalidad"].ToString() + "</td>");
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
                        sb.Append("<td align=\"center\" class=\"align-middle\"><button type=\"button\" class=\"btn btn-icon btn-secondary fa-solid fa-magnifying-glass text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"verPonencia(" + drseldatos["idPonencia"].ToString() + ", '"+ drseldatos["titulo"].ToString() +"');\"></button></td>");
                        sb.Append("<td align=\"center\" class=\"align-middle\"><button type=\"button\" class=\"btn btn-icon btn-info fa-solid fa-user-plus text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"editarEvaluador(" + drseldatos["idPonencia"].ToString() + ");\"></button></td>");
                        sb.Append("</tr>");
                    }
                    sb.Append("</tbody></table>");

                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }
}
