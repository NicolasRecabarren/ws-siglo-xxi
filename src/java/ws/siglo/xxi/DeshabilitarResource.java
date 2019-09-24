/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ws.siglo.xxi;

import Model.OracleConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * REST Web Service
 *
 * @author recab
 */
@Path("deshabilitar")
public class DeshabilitarResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of GenericResource
     */
    public DeshabilitarResource() {
    }

    /**
     * Retrieves representation of an instance of ws.siglo.xxi.ListarResource
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getJson(@QueryParam("entity") String entity, @QueryParam("id") int id) {
        Connection oConn = new OracleConnection().getConexion();
        entity = entity.toUpperCase();
        
        String statement = "PKG_MANTENEDORES.DESHABILITAR_"+entity+"(?,?)";
        String msj  = "";
        
        CallableStatement cStmt;
        try {
            //cStmt = oConn.prepareCall("{call PKG_MANTENEDORES.DESHABILITAR_CATEGORIA_PLATO(?, ?)}");
            cStmt = oConn.prepareCall("{call "+statement+"}");
            cStmt.registerOutParameter(2, Types.NVARCHAR);
            
            cStmt.setInt(1, id);
            cStmt.setString(2, msj);
            
            cStmt.execute();
            msj = cStmt.getString(2);
            oConn.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(DeshabilitarResource.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        JsonObjectBuilder jsonObjBuilder = Json.createObjectBuilder();
        jsonObjBuilder.add("resultado", "Procedimiento ejecutado correctamente.");
        jsonObjBuilder.add("mensaje", msj);
        JsonObject oJson = jsonObjBuilder.build();
        
        return Response.ok(oJson.toString())
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
}
