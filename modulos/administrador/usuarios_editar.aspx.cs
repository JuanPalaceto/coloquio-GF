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


public partial class modulos_administrador_usuarios_editar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
          CargarTipos();
    }
     private void CargarTipos()
    {
        
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand cmdSeltipo = new SqlCommand("SelTipo", Conn))
            {
                cmdSeltipo.CommandType = CommandType.StoredProcedure;
                Conn.Open();
                txtTipo.Items.Clear();
                txtTipo.AppendDataBoundItems = true;
                txtTipo.Items.Add(new ListItem("Seleccionar...", "0"));
                SqlDataReader drtipo = cmdSeltipo.ExecuteReader();
                while (drtipo.Read())
                {
                    txtTipo.Items.Add(new ListItem(drtipo["tipo"].ToString(), drtipo["idTipo"].ToString()));
                }
                drtipo.Close();
                drtipo.Dispose();
                Conn.Close();
                Conn.Dispose();
            }
        }
    }
}