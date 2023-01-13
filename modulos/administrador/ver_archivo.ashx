<%@ WebHandler Language="C#" Class="ver_archivo" %>

using System;
using System.Web;
using System.Text;
using System.IO;
using System.Net;

public class ver_archivo : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/html";
        string idPonencia = context.Request.Params["idPon"];

        if (idPonencia.Equals("")){
            context.Response.Write("<script>alert('Ocurrió un error. Favor de volver a intentarlo');</script>");
            return;
        }

        StringBuilder sbArchivos = new StringBuilder();

        // Comprobar si existe la carpeta
        if (Directory.Exists(HttpContext.Current.Server.MapPath("~/ponencias/"+idPonencia+"/")))
        {
            // Si existen documentos
            DirectoryInfo dir = new DirectoryInfo(HttpContext.Current.Server.MapPath("~/ponencias/"+idPonencia+"/"));

            FileInfo[] files = dir.GetFiles();

            if (files.Length > 0)
            {
                sbArchivos.Append("<script>$('#file-input').fileinput('destroy'); $('#file-input').fileinput({ theme: 'fa5', language: 'es',  showClose: false, showBrowse:false, showCaption: false, dropZoneTitle: false, showUpload: false, showRemove: false, initialPreviewShowDelete: false, maxFileSize: 8192, maxFileCount: 1, overwriteInitial: false, initialPreviewAsData: true, browseOnZoneClick: false, validateInitialCount: true, initialPreview: [");
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
                        sbArchivos.Append("{ type: \""+extension+"\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", key: \""+nombreArchivo+"\" }, ");
                    } else if (extension == "jpg" || extension == "png" || extension == "jfif" || extension == "jpeg"){
                        sbArchivos.Append("{ type: \"image\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", key: \""+nombreArchivo+"\" }, ");
                    } else if (extension == "doc" || extension == "docx" || extension == "ppt" || extension == "pptx" || extension == "xls" || extension == "xlsx"){
                        sbArchivos.Append("{ type: \"office\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", key: \""+nombreArchivo+"\" }, ");
                    } else if (extension == "mp4"){
                        sbArchivos.Append("{ type: \"video\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", key: \""+nombreArchivo+"\" }, ");
                    } else {
                        sbArchivos.Append("{ size: \""+tamano+"\", caption: \""+nombreArchivo+"\", key: \""+nombreArchivo+"\" }, ");
                    }
                }
                // lo mismo que rutaCompleta arriba, para descargar archivos
                sbArchivos.Append("], initialPreviewDownloadUrl: \"../../ponencias/"+idPonencia+"/{filename}\" });</script>");
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