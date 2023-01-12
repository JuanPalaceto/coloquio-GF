using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Services;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string Guardar(string nombre, string apellido, string email, string psw, string grado, string institucion, string dependencia, string ciudad, string pais, string telefono)
    {
        int Exitoso = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("GuardarDatos", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@nombre", SqlDbType.NVarChar, 50).Value = nombre;
                comand.Parameters.Add("@apellido", SqlDbType.NVarChar, 50).Value = apellido;
                comand.Parameters.Add("@email", SqlDbType.NVarChar, 50).Value = email;
                comand.Parameters.Add("@pass", SqlDbType.NVarChar, 50).Value = psw;
                comand.Parameters.Add("@grado", SqlDbType.NVarChar, 50).Value = grado;
                comand.Parameters.Add("@institucion", SqlDbType.NVarChar, 50).Value = institucion;
                comand.Parameters.Add("@dependencia", SqlDbType.NVarChar, 50).Value = dependencia;
                comand.Parameters.Add("@ciudad", SqlDbType.NVarChar, 50).Value = ciudad;
                comand.Parameters.Add("@pais", SqlDbType.NVarChar, 50).Value = pais;
                comand.Parameters.Add("@telefono", SqlDbType.NChar, 10).Value = telefono;

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