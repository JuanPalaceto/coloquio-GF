﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Text;
using System.Data;
using System.Data.SqlClient;

public partial class temas : System.Web.UI.Page
{
    public string idTema, tema;
    protected void Page_Load(object sender, EventArgs e)
    {
        idTema= Convert.ToString(HttpContext.Current.Session["idTema"]);
        tema= Convert.ToString(HttpContext.Current.Session["tema"]);
    }
    [WebMethod]
    public static string TablaListarTemas()
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ListarTemas", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered \"><thead><tr><th scope=\"col\">Tema</th><th scope=\"col\" style=\"max-width: 150px;\">Estado</th><th scope=\"col\" style=\"max-width: 150px;\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        int activo = Convert.ToInt32(drseldatos["activo"].ToString());

                        sb.Append("<tr>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["tema"].ToString() + "</td>");

                        if (activo == 1)
                        {
                            sb.Append("<td data-order=\"1\" align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-success fa fa-check text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"alternarActivo(" + drseldatos["idTema"].ToString() + ");\"></button>");
                        }
                        else
                        {
                            sb.Append("<td data-order=\"0\" align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-secondary fa fa-ban text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"alternarActivo(" + drseldatos["idTema"].ToString() + ");\"></button>");
                        }

                        sb.Append("<td align=\"center\"><button type=\"button\" class=\"btn btn-icon btn-info fa fa-pencil text-white\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ModalEditar(" + drseldatos["idTema"].ToString() + ",'" + drseldatos["tema"].ToString()+ "');\"></button>");
                        sb.Append("<button type=\"button\" class=\"btn btn-icon btn-danger fa fa-trash text-white m-1\" style=\"width: 1.2em; height: 1.5em;\" onclick=\"ConfirmarEliminar(" + drseldatos["idTema"].ToString() + ");\"></button></td></tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<td colspan=\"3\" style=\"text-align: center;\">No hay ediciones disponibles.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }
    [WebMethod]
    public static string alternarActivo(int id)
    {
        int Exitoso = 1;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("activarTema", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.AddWithValue("@idTema", id);
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
    public static string editarTema(int id){
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("editarTema", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idTema", SqlDbType.Int).Value = id;

                SqlParameter pedicion = comand.Parameters.Add("@tema", SqlDbType.NVarChar, 50);
                pedicion.Direction = ParameterDirection.Output;

                Conn.Open();
                comand.ExecuteNonQuery();

                HttpContext.Current.Session["idTema"] = id;
                HttpContext.Current.Session["tema"] = pedicion.Value.ToString();
            }
            Conn.Close();
            return "";
        }
    }
    [WebMethod]
    public static string ModificarTema(int id, string newTema){
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand command = new SqlCommand("updateTema", Conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("@idTema", SqlDbType.Int).Value = id;
                command.Parameters.Add("@tema", SqlDbType.NVarChar, 50).Value = newTema;

                Conn.Open();
                command.ExecuteNonQuery();
            }
            Conn.Close();
            return "";
        }
    }    
    [WebMethod]
    public static string borrarTema(int id){      
        int Eliminado = 0;
        using (SqlConnection Conn = conn.conecta())
        {
            using (SqlCommand comand = new SqlCommand("eliminarTema", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idTema", SqlDbType.Int).Value = id;

                SqlParameter peliminado = comand.Parameters.Add("@Eliminado", SqlDbType.Int);
                peliminado.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Eliminado = int.Parse(peliminado.Value.ToString());
            }
            Conn.Close();
            return "{\"success\": \"" + Eliminado + "\"}";
        }
    }
}