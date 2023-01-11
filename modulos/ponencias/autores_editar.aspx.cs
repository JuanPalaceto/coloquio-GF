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

public partial class autores_editar : System.Web.UI.Page
{
    protected string idAutor;

    protected void Page_Load(object sender, EventArgs e)
    {
        idAutor = Convert.ToString(HttpContext.Current.Session["idAutor"]);
        CargarTipos();
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
    public static string ModificarAutor(int id)
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("ModAutor", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idAutor", SqlDbType.Int).Value = id;
                con.Open();
                using (SqlDataReader dr = comand.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        sb.Append("{\"autor\": \"" + dr["autor"].ToString().Trim() + "\", \"institucion\": \"" + dr["institucion"].ToString().Trim() + "\", \"tipo\": \"" + dr["idTipoAutor"].ToString().Trim() + "\"}");
                    }
                    dr.Close();
                }
            }
            con.Close();
        }
        return sb.ToString();
    }

    [WebMethod]
    public static string updateAutor(int idAutor, string autor, string institucion, int tipo)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("updateAutor", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idAutor", SqlDbType.Int).Value = idAutor;
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
}