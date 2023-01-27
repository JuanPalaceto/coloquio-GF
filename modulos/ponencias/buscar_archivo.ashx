<%@ WebHandler Language="C#" Class="buscar_archivo" %>

using System;
using System.Web;
using System.Text;
using System.IO;
using System.Net;
using System.Web.SessionState;

public class buscar_archivo : IHttpHandler, IReadOnlySessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/html";

        StringBuilder sbArchivos = new StringBuilder();
        string idponencia = Convert.ToString(HttpContext.Current.Session["idponencia"]);
        string idusuario = Convert.ToString(HttpContext.Current.Session["idusuario"]);

        // Comprobar si existe la carpeta
        if (Directory.Exists(HttpContext.Current.Server.MapPath("~/ponencias/"+idusuario+"/"+idponencia+"/")) && idponencia != "0")
        {
            // Si existen documentos
            DirectoryInfo dir = new DirectoryInfo(HttpContext.Current.Server.MapPath("~/ponencias/"+idusuario+"/"+idponencia+"/"));

            FileInfo[] files = dir.GetFiles();

            if (files.Length > 0)
            {
                sbArchivos.Append("<script>$('#file-input').fileinput('destroy'); $('#file-input').fileinput({ theme: 'fa5', language: 'es', uploadUrl: 'subir_archivo.ashx', maxFileSize: 8192, maxFileCount: 1, overwriteInitial: false, initialPreviewAsData: true, browseOnZoneClick: true, validateInitialCount: true, initialPreview: [");
                foreach (FileInfo item in files)
                {
                    string rutaCompleta = item.FullName;
                    //Cuidado con esta ruta
                    rutaCompleta = rutaCompleta.Replace(@"C:\inetpub\wwwroot\Coloquio\", "");
                    rutaCompleta = rutaCompleta.Replace(@"\", "/");
                    // Los puntitos son para retroceder carpetas ya que ponencias_registrar está 2 carpetas arriba de la carpeta donde se guardan las ponencias
                    // Tengo que retroceder en las opciones del plugin o estas carpetas se sumaran a la ruta final(?)
                    sbArchivos.Append("\"../../"+rutaCompleta+"\", ");
                }
                sbArchivos.Append("], initialPreviewConfig: [");
                foreach (FileInfo item in files)
                {
                    string nombreArchivo = item.Name;
                    string extension = Path.GetExtension(nombreArchivo);
                    string tamano = (item.Length).ToString();
                    extension = extension.Replace(".", "");
                    if (extension == "pdf"){
                        sbArchivos.Append("{ type: \""+extension+"\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"eliminar_archivo.ashx\", key: \""+nombreArchivo+"\" }, ");
                    } else if (extension == "jpg" || extension == "png" || extension == "jfif" || extension == "jpeg"){
                        sbArchivos.Append("{ type: \"image\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"eliminar_archivo.ashx\", key: \""+nombreArchivo+"\" }, ");
                    } else if (extension == "doc" || extension == "docx" || extension == "ppt" || extension == "pptx" || extension == "xls" || extension == "xlsx"){
                        sbArchivos.Append("{ type: \"office\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"eliminar_archivo.ashx\", key: \""+nombreArchivo+"\" }, ");
                    } else if (extension == "mp4"){
                        sbArchivos.Append("{ type: \"video\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"eliminar_archivo.ashx\", key: \""+nombreArchivo+"\" }, ");
                    } else {
                        sbArchivos.Append("{ size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"eliminar_archivo.ashx\", key: \""+nombreArchivo+"\" }, ");
                    }
                }
                // lo mismo que rutaCompleta arriba, para descargar archivos
                sbArchivos.Append("], initialPreviewDownloadUrl: \"../../ponencias/"+idusuario+"/"+idponencia+"/{filename}\" }); $('#btnGuardar').removeClass('btn-secondary');$('#btnGuardar').addClass('btn-primary');</script>");
            }
            else
            {
                sbArchivos.Append("");
            }
        }
        else
        {
            sbArchivos.Append("");
        }

        context.Response.Write(sbArchivos.ToString());
        context.Response.End();
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}