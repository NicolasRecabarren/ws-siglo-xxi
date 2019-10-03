/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ws.siglo.xxi;

import java.util.Set;
import javax.ws.rs.core.Application;
/**
 *
 * @author recab
 */
@javax.ws.rs.ApplicationPath("webresources")
public class ApplicationConfig extends Application {
    
    @Override
    public Set<Class<?>> getClasses(){
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }
    
    private void addRestResourceClasses(Set<Class<?>> resources){
        resources.add(ws.siglo.xxi.ListarResource.class);
        resources.add(ws.siglo.xxi.ManagementResource.class);
    }
}
