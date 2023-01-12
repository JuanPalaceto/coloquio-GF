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

public partial class ponencias_autores : System.Web.UI.Page
{
    protected string idponencia;    

    protected void Page_Load(object sender, EventArgs e)
    {
        idponencia = Convert.ToString(HttpContext.Current.Session["idponencia"]);
            CargarTipos();
    }


    [WebMethod]
    public static string TablaListarAutores()
    {
        int ponencia = Convert.ToInt32(HttpContext.Current.Session["idponencia"]);

        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarAutores", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.AddWithValue("@idPonencia", ponencia);
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {                
                    if(drseldatos.HasRows)                        
                    sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Nombre</th><th scope=\"col\">Tipo</th><th scope=\"col\" style=\"max-width: 100px;\">Institución</th><th scope=\"col\" style=\"max-width: 150px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {                        
                        sb.Append("<tr class=\"align-middle\">");
                        sb.Append("<td>" + drseldatos["autor"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["tipoAutor"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["institucion"].ToString() + "</td>");
                        sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-primary fa fa-user-pen text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"editarAutor("+drseldatos["idAutor"].ToString()+");\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa fa-trash text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ConfirmarEliminar("+drseldatos["idAutor"].ToString()+");\"></button></td></tr>");
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
    public static string ListarTitulo(int id)
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("SelTitulo", con))
            {                
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idPonencia", SqlDbType.Int).Value = id;
                con.Open();
                using (SqlDataReader dr = comand.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        sb.Append("{\"titulo\": \"" + dr["titulo"].ToString().Trim() + "\"}");
                    }
                    dr.Close();
                }
            }
            con.Close();
        }
        return sb.ToString();
    }

    private void CargarTipos()
    {
        
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand cmdSeltipo = new SqlCommand("SelTipoautor", Conn))
            {
                cmdSeltipo.CommandType = CommandType.StoredProcedure;
                Conn.Open();
                txtTipo.Items.Clear();
                txtTipo.AppendDataBoundItems = true;
                txtTipo.Items.Add(new ListItem("Seleccionar...", "0"));
                SqlDataReader drtipo = cmdSeltipo.ExecuteReader();
                while (drtipo.Read())
                {
                    txtTipo.Items.Add(new ListItem(drtipo["tipoAutor"].ToString(), drtipo["idTipoAutor"].ToString()));
                }
                drtipo.Close();
                drtipo.Dispose();
                Conn.Close();
                Conn.Dispose();
            }
        }
    }    

    [WebMethod]
    public static string editarAutor(int idAutor){
        int Exitoso = 1;
        HttpContext.Current.Session["idAutor"] = idAutor;
        return "{\"Success\": \"" + Exitoso + "\"}";
    }
    
    [WebMethod]
    public static string AgregarAutor(int idPonencia, string autor, string institucion, int tipo)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("AgregarAutor", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idPonencia", SqlDbType.Int).Value = idPonencia;
                comand.Parameters.Add("@autor", SqlDbType.NVarChar, 50).Value = autor;
                comand.Parameters.Add("@institucion", SqlDbType.NVarChar, 50).Value = institucion;
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
}