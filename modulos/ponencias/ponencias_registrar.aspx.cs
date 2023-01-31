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

public partial class ponencias_registrar : System.Web.UI.Page
{
    int idponencia;
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Form.Enctype = "Multipart/Form-Data";
        DropTipoAutor();

        // Si la variable de sesión tiene algo ( es decir se hizo click en modificar una ponencia, asigna el id al textbox, de lo contrario se asigna 0 desde html)
        //idponencia = Convert.ToInt32(HttpContext.Current.Session["idponencia"]);
        //idPonencia.Text = idponencia.ToString();


        // Limpia la variable de sesión
        // HttpContext.Current.Session["idponencia"] = null;
    }

    private void DropTipoAutor()
    {
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand cmdSeltipoaut = new SqlCommand("SelTipoautor", con))
            {
                cmdSeltipoaut.CommandType = CommandType.StoredProcedure;

                con.Open();
                selectAut.Items.Clear();
                selectMod.Items.Clear();
                selectTema.Items.Clear();
                selectAut.AppendDataBoundItems = true;
                selectMod.AppendDataBoundItems = true;
                selectTema.AppendDataBoundItems = true;
                selectAut.Items.Add(new ListItem("- Seleccionar -", ""));
                selectMod.Items.Add(new ListItem("Seleccionar", ""));
                selectTema.Items.Add(new ListItem("Seleccionar", ""));
                SqlDataReader drtipo = cmdSeltipoaut.ExecuteReader();
                while (drtipo.Read())
                {
                    selectAut.Items.Add(new ListItem(drtipo["tipoAutor"].ToString(), drtipo["idTipoAutor"].ToString()));
                }
                drtipo.NextResult();
                while (drtipo.Read())
                {
                    selectMod.Items.Add(new ListItem(drtipo["modalidad"].ToString(), drtipo["idModalidad"].ToString()));
                }
                drtipo.NextResult();
                while (drtipo.Read())
                {
                    selectTema.Items.Add(new ListItem(drtipo["tema"].ToString(), drtipo["idTema"].ToString()));
                }
                drtipo.Close();
                drtipo.Dispose();
                con.Close();
                con.Dispose();
            }
        }
    }

    [WebMethod]
    public static string GuardaPonencia(int id, string titulo, int modalidad, int tema, string resumen, string palabras)
    {
        int Exitoso = 0;

        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand command = new SqlCommand("GuardarPonencia", Conn))
            {
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.Add("@idPonencia", SqlDbType.Int).Value = id;
                command.Parameters.Add("@idUsuario", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);
                command.Parameters.Add("@idTema", SqlDbType.Int).Value = tema;
                command.Parameters.Add("@idModalidad", SqlDbType.Int).Value = modalidad;
                command.Parameters.Add("@titulo", SqlDbType.NVarChar, 100).Value = titulo;
                command.Parameters.Add("@resumen", SqlDbType.NVarChar, 500).Value = resumen;
                command.Parameters.Add("@palabrasClave", SqlDbType.NVarChar, 120).Value = palabras;

                SqlParameter pexitoso = command.Parameters.Add("@Exitoso", SqlDbType.Int);
                SqlParameter pidponencia = command.Parameters.Add("@idPon", SqlDbType.Int);
                SqlParameter ptitulo = command.Parameters.Add("@title", SqlDbType.NVarChar, 100);
                pexitoso.Direction = ParameterDirection.Output;
                pidponencia.Direction = ParameterDirection.Output;
                pidponencia.Direction = ParameterDirection.Output;
                ptitulo.Direction = ParameterDirection.Output;
                Conn.Open();
                command.ExecuteNonQuery();
                Exitoso = int.Parse(pexitoso.Value.ToString());
                id = int.Parse(pidponencia.Value.ToString());
                titulo = ptitulo.Value.ToString();
            }

            Conn.Close();
        }
        HttpContext.Current.Session["idponencia"] = id;

        // Esto es para evitar problemas con el json, ya que se serializa automaticamente y no tengo que hacerlo manual
        var obj = new
        {
            success = Exitoso,
            id = id,
            titulo = titulo
        };

        var serializer = new JavaScriptSerializer();
        string jsonString = serializer.Serialize(obj);

        return jsonString;
    }

    [WebMethod]
    public static string ModificaPonencia(int id)
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("ModificarPonencia", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@id", SqlDbType.Int).Value = id;
                Conn.Open();
                using (SqlDataReader dr = comand.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        sb.Append("{\"idPonencia\": \"" + dr["idPonencia"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"idTema\": \"" + dr["idTema"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"idModalidad\": \"" + dr["idModalidad"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"titulo\": \"" + dr["titulo"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"resumen\": \"" + dr["resumen"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"palabrasClave\": \"" + dr["palabrasClave"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\"}");
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
    public static string AgregaAutor(int idPonencia, int idAutor, string autor, string institucion, int tipo, string sexo)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("AgregarAutor", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idPonencia", SqlDbType.Int).Value = idPonencia;
                comand.Parameters.Add("@idAutor", SqlDbType.Int).Value = idAutor;
                comand.Parameters.Add("@autor", SqlDbType.NVarChar, 50).Value = autor;
                comand.Parameters.Add("@sexo", SqlDbType.NVarChar, 20).Value = sexo;
                comand.Parameters.Add("@institucion", SqlDbType.NVarChar, 200).Value = institucion;
                comand.Parameters.Add("@tipo", SqlDbType.Int).Value = tipo;

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
                        sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Nombre</th><th scope=\"col\">Tipo</th><th scope=\"col\" style=\"max-width: 150px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        sb.Append("<tr class=\"align-middle\">");
                        sb.Append("<td width=\"60%\">" + drseldatos["autor"].ToString() + "</td>");
                        sb.Append("<td width=\"20%\">" + drseldatos["tipoAutor"].ToString() + "</td>");
                        // sb.Append("<td>" + drseldatos["institucion"].ToString() + "</td>");
                        sb.Append("<td align=\"center\" width=\"20%\"><button type=\"button\" class=\"btn btn-icon btn-primary fa fa-user-pen text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"editarAutor(" + drseldatos["idAutor"].ToString() + ");\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa fa-trash text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ConfirmarEliminar(" + drseldatos["idAutor"].ToString() + ");\"></button></td></tr>");
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
    public static string ModificaAutor(int id)
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("ModAutor", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idAutor", SqlDbType.Int).Value = id;
                Conn.Open();
                using (SqlDataReader dr = comand.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        sb.Append("{\"idAutor\": \"" + dr["idAutor"].ToString() + "\", \"autor\": \"" + dr["autor"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"idTipoAutor\": \"" + dr["idTipoAutor"].ToString() + "\",\"institucion\": \"" + dr["institucion"].ToString() + "\",\"sexo\": \"" + dr["sexo"].ToString() + "\" }");
                    }
                    dr.Close();
                }
            }
            Conn.Close();
        }
        return sb.ToString();
    }

    [WebMethod]
    public static string EliminarAutor(int idAutor)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("EliminarAutor", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idAutor", SqlDbType.Int).Value = idAutor;

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
    public static string VerificarAutor(int idPonencia)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("VerificarAutor", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idPonencia", SqlDbType.Int).Value = idPonencia;

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
    public static string NuevaPonencia()
    {
        HttpContext.Current.Session["idponencia"] = 0;
        return "";
    }

    [WebMethod]
    public static string ValidaPonencia(int id, string titulo, int modalidad, int tema, string resumen, string palabras)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("ValidarPonencia", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;

                comand.Parameters.Add("@idPonencia", SqlDbType.Int).Value = id;
                comand.Parameters.Add("@idTema", SqlDbType.Int).Value = tema;
                comand.Parameters.Add("@idModalidad", SqlDbType.Int).Value = modalidad;
                comand.Parameters.Add("@titulo", SqlDbType.NVarChar, 100).Value = titulo;
                comand.Parameters.Add("@resumen", SqlDbType.NVarChar, 500).Value = resumen;
                comand.Parameters.Add("@palabrasClave", SqlDbType.NVarChar, 120).Value = palabras;


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
