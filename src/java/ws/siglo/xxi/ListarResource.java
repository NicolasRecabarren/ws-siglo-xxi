/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ws.siglo.xxi;

import Model.OracleConnection;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.google.gson.JsonObject;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
//import javax.json.Json;
//import javax.json.JsonObject;
//import javax.json.JsonObjectBuilder;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import oracle.jdbc.OracleTypes;

import org.apache.xml.security.utils.Base64;
import oracle.sql.CLOB;
import oracle.sql.BLOB;
import sun.misc.BASE64Encoder;
/**
 * REST Web Service
 *
 * @author recab
 */
@Path("listar")
public class ListarResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of GenericResource
     */
    public ListarResource() {
    }

    /**
     * Retrieves representation of an instance of ws.siglo.xxi.ListarResource
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getJson(@QueryParam("param1") String p1) {
        /*JsonObjectBuilder jsonObjBuilder = Json.createObjectBuilder();
        jsonObjBuilder.add("resultado", "parametro recibido: "+p1);
        JsonObject oJson = jsonObjBuilder.build();*/
        
        //return Response.ok(oJson.toString())
        return Response.ok("")
                .header("Access-Control-Allow-Origin", "*")
                .header("Access-Control-Allow-Methods", "POST, GET, PUT, UPDATE, OPTIONS")
                .header("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With")
                .build();
        //TODO return proper representation object
        //throw new UnsupportedOperationException();
    }

    /**
     * PUT method for updating or creating an instance of ListarResource
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void putJson(String content) {
    }
    
    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Response postJson(@FormParam("package") String packageName, @FormParam("procedure") String procedureName,@FormParam("data") String jsonStringData) throws IOException {
        
        // Generamos la instancia de la conexión a la base de datos.
        Connection oConn = new OracleConnection().getConexion();
        
        String statement = packageName.toUpperCase()+"."+procedureName.toUpperCase()+"(";
        
        // Parseamos el JSON y obtenemos sus datos para generar los parámetros de la llamada del procedimiento.
        JsonParser parser = new JsonParser();
        JsonArray jsonArrayData = parser.parse(jsonStringData).getAsJsonArray();
        
        // Agregamos el parámetro de tipo out para guardar el mensaje que nos devuelva la base de datos.
        JsonObject msjErrorParam = new JsonObject();
        msjErrorParam.addProperty("param", "PERROR");
        msjErrorParam.addProperty("tipo_dato", "varchar2");
        msjErrorParam.addProperty("tipo_param", "OUT");
        msjErrorParam.addProperty("value", "");
        jsonArrayData.add(msjErrorParam);
        
        // Preparamos el call del procedimiento y la cantidad de parametros que le setearemos.
        for( int i = 0; i < jsonArrayData.size(); i++){
            statement = statement+"?,";
        }
        statement = statement.substring(0, statement.length()-1)+")";
        
        String msj  = "";
        CallableStatement cStmt;
        JsonArray values = new JsonArray();
        
        JsonArray jsonRS = new JsonArray();
        
        ArrayList cursores = new ArrayList();
        
        try {
            cStmt = oConn.prepareCall("{call "+statement+"}");
            
            for( int i = 0; i < jsonArrayData.size(); i++){
                com.google.gson.JsonObject jsonParam = jsonArrayData.get(i).getAsJsonObject();

                String paramName = jsonParam.get("param").getAsString().toUpperCase();
                String tipoDato  = jsonParam.get("tipo_dato").getAsString().toUpperCase();
                String tipoParam = jsonParam.get("tipo_param").getAsString();
                String value     = jsonParam.get("value").getAsString();
                
                // Si hay parametros OUT primero se deben registrar.
                if(tipoParam.equalsIgnoreCase("out")){
                    switch(tipoDato){
                        case "VARCHAR2":
                            cStmt.registerOutParameter(paramName, Types.NVARCHAR);
                            break;
                        case "NUMBER":
                            cStmt.registerOutParameter(paramName, Types.INTEGER);
                            break;
                        case "CURSOR":
                            cStmt.registerOutParameter(paramName, OracleTypes.CURSOR);
                            cursores.add(paramName);
                            break;
                        case "CLOB":
                            cStmt.registerOutParameter(paramName, Types.CLOB);
                            break;
                        case "BLOB":
                            cStmt.registerOutParameter(paramName, Types.BLOB);
                            break;
                    }
                }
                
                // Seteamos los parametros a la llamada
                switch(tipoDato){
                    case "VARCHAR2":
                        cStmt.setString(paramName, value);
                        break;
                    case "NUMBER":
                        cStmt.setInt(paramName, Integer.parseInt(value));
                        break;
                    case "CLOB":
                        byte[] binaryData = null;
                        try {
                            binaryData = (value).getBytes(StandardCharsets.UTF_16LE);;
                        }
                        catch (Exception ex) {
                            binaryData = null;
                        } 
                        CLOB clob = createClob(binaryData, oConn);
                        cStmt.setClob(paramName, clob);
                        
                        break;
                    case "BLOB":
                        byte[] binaryDataBLOB = null;
                        
                        try {
                            byte[] tmp = java.util.Base64.getEncoder().encode(value.getBytes());
                            binaryDataBLOB = java.util.Base64.getDecoder().decode(new String(tmp).getBytes("UTF-8"));
                        } catch (UnsupportedEncodingException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                        
                        BLOB blob = createBlob(binaryDataBLOB, oConn);                        
                        cStmt.setBlob(paramName, blob);
                        
                        break;
                }
            }
            
            // Ejecutamos la llamada
            cStmt.execute();
            // Obtenemos el mensaje de la BD.
            msj = cStmt.getString("PERROR");
            
            if("OK".equals(msj)){
            
                for (int i = 0; i < cursores.size(); i++) {
                        
                    System.out.print(cStmt.getObject(cursores.get(i).toString()));
                    ResultSet resultados = (ResultSet)cStmt.getObject(cursores.get(i).toString());
                    jsonRS = new JsonArray(); 
                    
                    while(resultados.next()){

                        // Obtenemos la cantidad de columnas del registro encontrado.
                        ResultSetMetaData rsmd = resultados.getMetaData();
                        int columnsNumber = rsmd.getColumnCount();

                        JsonObject rsJson = new JsonObject();

                        for(int j=1; j <= columnsNumber; j++){
                            switch(rsmd.getColumnTypeName(j)){
                                case "NUMBER":
                                    rsJson.addProperty(rsmd.getColumnName(j), resultados.getInt(j));
                                    break;
                                case "DATE":
                                    rsJson.addProperty(rsmd.getColumnName(j), resultados.getString(j));
                                    break;
                                case "VARCHAR2":
                                    rsJson.addProperty(rsmd.getColumnName(j), resultados.getString(j));
                                    break;
                                case "CLOB":
                                    Clob clob = resultados.getClob(j);
                                    rsJson.addProperty(rsmd.getColumnName(j), clobToString(clob));
                                    break;
                                case "BLOB":
                                    Blob blob = resultados.getBlob(j);
                                    rsJson.addProperty(rsmd.getColumnName(j), blobToString(blob));
                                    break;
                            }
                        }

                        jsonRS.add(rsJson.getAsJsonObject());
                    }  
                    values.add(jsonRS);
                }
            }
                        
            // Cerramos la conexión a la BD.
            oConn.close();
        } catch (SQLException ex) {
            msj = ex.getMessage();
            Logger.getLogger(ManagementResource.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("msj", msj);
        jsonResponse.add("resultados",values);
        
        return Response.ok(jsonResponse.toString())
            .header("Access-Control-Allow-Origin", "*")
            .header("Access-Control-Allow-Methods", "POST, GET, PUT, UPDATE, OPTIONS")
            .header("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With")
            .build();
    }
    
    private CLOB createClob(byte[] data, Connection conn) {
        CLOB clob = null; 

        try { 
            clob = CLOB.createTemporary(conn, false, oracle.sql.CLOB.DURATION_SESSION);

            clob.open(CLOB.MODE_READWRITE);

            OutputStream out = (OutputStream) clob.setAsciiStream(0L);

            out.write(data);
            out.flush();
            out.close();
        }
        catch (Exception e) {
        }
        finally {
            try {
                if (clob != null && clob.isOpen()) clob.close();
            }
            catch (SQLException e) {
            }
        }
        return clob;
    }
    
    private BLOB createBlob(byte[] data, Connection conn) {
        BLOB blob = null; 

        try { 
            blob = BLOB.createTemporary(conn, false, oracle.sql.CLOB.DURATION_SESSION);

            blob.open(BLOB.MODE_READWRITE);

            OutputStream out = (OutputStream) blob.setBinaryStream(0L);

            out.write(data);
            out.flush();
            out.close();
        }
        catch (Exception e) {
        }
        finally {
            try {
                if (blob != null && blob.isOpen()) blob.close();
            }
            catch (SQLException e) {
            }
        }

        return blob;
    }
    
    /*********************************************************************************************
    * From CLOB to String
    * @return string representation of clob
    *********************************************************************************************/
    private String clobToString(java.sql.Clob data) throws IOException
    {
        StringBuffer str = new StringBuffer();
        
        try
        {
            if (data == null)
                    return  "";
              
            String strng;                
      
            BufferedReader bufferRead = new BufferedReader(data.getCharacterStream());
     
            while ((strng=bufferRead .readLine())!=null)
             str.append(strng);
        }
        catch (SQLException e)
        {
             return "";
        }
        catch (IOException e)
        {
             return "";
        }

        return str.toString();
    }
    
     private String blobToString(java.sql.Blob data) throws SQLException
    {
        String s;
        try{            
            byte[] bdata = data.getBytes(1, (int) data.length());
            BASE64Encoder encoder = new BASE64Encoder();
            s = encoder.encode(bdata);
        }
        catch(Exception ex)
        {
            s = "";
        }
        
        return s;
    }
}
