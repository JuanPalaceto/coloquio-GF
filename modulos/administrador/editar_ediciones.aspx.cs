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

public partial class modulos_administrador_editar_ediciones : System.Web.UI.Page
{
    public string idEdicion, Edicion;
    protected void Page_Load(object sender, EventArgs e)
    {
        idEdicion= Convert.ToString(HttpContext.Current.Session["idEdicion"]);
        Edicion= Convert.ToString(HttpContext.Current.Session["edicion"]);
    }
    
    [WebMethod]
    public static string ModificarEdicion(int id, string newEdicion){
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand command = new SqlCommand("updateEdicion", Conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@idEdicion", SqlDbType.Int).Value = id;
                command.Parameters.Add("@edicion", SqlDbType.NVarChar, 20).Value = newEdicion;

                Conn.Open();
                command.ExecuteNonQuery();
            }
            Conn.Close();
            return "";
        }
    }
}