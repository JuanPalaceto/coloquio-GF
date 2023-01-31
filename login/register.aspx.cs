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
using System.Net;
using System.Net.Mail;

public partial class register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string Guardar(string nombre, string apellido, string email, string psw, string grado, string institucion, string dependencia, string ciudad, string estado, string telefono, string curp)
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
                comand.Parameters.Add("@institucion", SqlDbType.NVarChar, 200).Value = institucion;
                comand.Parameters.Add("@dependencia", SqlDbType.NVarChar, 50).Value = dependencia;
                comand.Parameters.Add("@ciudad", SqlDbType.NVarChar, 50).Value = ciudad;
                comand.Parameters.Add("@estado", SqlDbType.NVarChar, 50).Value = estado;
                comand.Parameters.Add("@telefono", SqlDbType.NChar, 10).Value = telefono;
                comand.Parameters.Add("@curp", SqlDbType.NVarChar, 20).Value = curp;

                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                pexitoso.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Exitoso = int.Parse(pexitoso.Value.ToString());
            }
            Conn.Close();

            using (MailMessage mm = new MailMessage("a2143040255@alumnos.uat.edu.mx", email.Trim()))
            {
                mm.Subject = "Registro Exitoso";
                mm.Body = "Apreciable: <b>" + nombre + " " + apellido + "</b><br /><br />Le informamos que se ha realizado correctamente su registro.<br /><br />Para ingresar al sistema utilice el siguiente usuario y contraseña: <br />" + email.Trim() + "<br />" + psw.Trim() + "<br /><br />Si nesecita asistencia con su cuenta, envíe un correo a la siguiente cuenta: a2143040255@alumnos.uat.edu.mx<br /><br />Saludos cordiales".Trim();
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
            return "{\"success\": \"" + Exitoso + "\"}";
        }
    }
}