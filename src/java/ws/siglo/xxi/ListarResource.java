/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ws.siglo.xxi;

import Model.OracleConnection;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.JsonObject;
import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
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
    public Response postJson(@FormParam("procedure") String procedureName,@FormParam("data") String jsonStringData) {
        
        // Generamos la instancia de la conexión a la base de datos.
        Connection oConn = new OracleConnection().getConexion();
        
        String statement = "PKG_MANTENEDORES."+procedureName.toUpperCase()+"(";
        
        // Parseamos el JSON y obtenemos sus datos para generar los parámetros de la llamada del procedimiento.
        JsonParser parser = new JsonParser();
        JsonArray jsonArrayData = parser.parse(jsonStringData).getAsJsonArray();
        
        // Preparamos el call del procedimiento y la cantidad de parametros que le setearemos.
        for( int i = 0; i < jsonArrayData.size(); i++){
            statement = statement+"?,";
        }
        statement = statement.substring(0, statement.length()-1)+")";
        
        String msj  = "";
        CallableStatement cStmt;
        JsonArray jsonRS = new JsonArray();
        
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
                    /*case "CURSOR":
                        cStmt.setCursorName("IO_CURSOR");
                        break;*/
                }
            }
            
            // Ejecutamos la llamada
            cStmt.execute();
            // Obtenemos el mensaje de la BD.
            msj = cStmt.getString("PERROR");
            System.out.print(cStmt.getObject("IO_CURSOR"));
            ResultSet resultados = (ResultSet)cStmt.getObject("IO_CURSOR");
            
            while(resultados.next()){
                
                // Obtenemos la cantidad de columnas del registro encontrado.
                ResultSetMetaData rsmd = resultados.getMetaData();
                int columnsNumber = rsmd.getColumnCount();
                
                JsonObject rsJson = new JsonObject();
                for(int i=1; i <= columnsNumber; i++){
                    switch(rsmd.getColumnTypeName(i)){
                        case "NUMBER":
                            rsJson.addProperty(rsmd.getColumnName(i), resultados.getInt(i));
                            break;
                        case "VARCHAR2":
                            rsJson.addProperty(rsmd.getColumnName(i), resultados.getString(i));
                            break;
                    }
                }
                
                jsonRS.add(rsJson.getAsJsonObject());
            }
            // Cerramos la conexión a la BD.
            oConn.close();
        } catch (SQLException ex) {
            Logger.getLogger(ManagementResource.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return Response.ok(jsonRS.toString())
            .header("Access-Control-Allow-Origin", "*")
            .header("Access-Control-Allow-Methods", "POST, GET, PUT, UPDATE, OPTIONS")
            .header("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With")
            .build();
    }
}
