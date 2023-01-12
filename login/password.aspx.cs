using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Net.Mail;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Net;


public partial class password : System.Web.UI.Page
{
    string tipoUsu;
    protected void Page_Load(object sender, EventArgs e)
    {
        tipoUsu = Convert.ToString(HttpContext.Current.Session["tipoUsu"]);
        // Si existe sesión regresa al la página anterior
        if (!(tipoUsu.Equals("")) && HttpContext.Current.Session["returnPath"] != null)
        {
           HttpContext.Current.Response.Redirect(Session["returnPath"].ToString());
        }    
    }

    [WebMethod]
    public static string Recuperar(string Correo)
    {
        int Exitoso = 0;
        string Contra;
        using (SqlConnection Conn= conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("Restablecer",Conn))
            {
                comand.CommandType= CommandType.StoredProcedure;
                comand.Parameters.Add("@Correo", SqlDbType.NVarChar, 50).Value = Correo;
                SqlParameter contra = comand.Parameters.Add("@Contra", SqlDbType.NVarChar, 50);
                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                contra.Direction = ParameterDirection.Output;
                pexitoso.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Contra = contra.Value.ToString();
                Exitoso = int.Parse(pexitoso.Value.ToString());
                if(Exitoso == 1){
                    using (MailMessage mm = new MailMessage("repositorio.fcav@uat.edu.mx", Correo.Trim()))
                    {
                        mm.Subject = "Contraseña";
                        mm.Body = "Correo: <b>" + Correo + "</b><br/>Contraseña: <b>" + Contra +"</b>";
                        mm.IsBodyHtml = true;
                        SmtpClient smtp = new SmtpClient();
                        smtp.Host = "smtp.office365.com";
                        smtp.EnableSsl = true;
                        string user = "repositorio.fcav@uat.edu.mx";
                        string pass = "repositorio@";
                        NetworkCredential networkCred = new NetworkCredential (user, pass);
                        smtp.UseDefaultCredentials = true;
                        smtp.Credentials = networkCred;
                        smtp.Port = 587;
                        smtp.Send(mm);
                    }
                }
            }
            Conn.Close();
        }
        return "{\"success\":\"" + Exitoso + "\"}";
    }
}