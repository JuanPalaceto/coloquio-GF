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

public partial class modulos_administrador_editar_temas : System.Web.UI.Page
{
    public string idTema, tema;
    protected void Page_Load(object sender, EventArgs e)
    {
        idTema= Convert.ToString(HttpContext.Current.Session["idTema"]);
        tema= Convert.ToString(HttpContext.Current.Session["tema"]);
    }

    [WebMethod]
    public static string ModificarTema(int id, string newTema){
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand command = new SqlCommand("updateTema", Conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@idTema", SqlDbType.Int).Value = id;
                command.Parameters.Add("@tema", SqlDbType.NVarChar, 20).Value = newTema;

                Conn.Open();
                command.ExecuteNonQuery();
            }
            Conn.Close();
            return "";
        }
    }
}