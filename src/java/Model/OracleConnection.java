/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.*;
public class OracleConnection {
    
    public String driver, url, ip, bd, usr, pass;
    public Connection conexion;
    
    public OracleConnection() {
        this.driver = "oracle.jdbc.driver.OracleDriver";
        this.bd = "oracle";
        this.ip = "localhost";
        this.usr = "RESTAURANTE";
        this.pass = "RESTAURANTE";
        this.url = new String("jdbc:oracle:thin:@" + ip + ":1521:" + bd);
        
        try {
            Class.forName(driver).newInstance();
            conexion = DriverManager.getConnection(url, usr, pass);
            System.out.println("Conexión a oracle establecida correctamente.");
            
        } catch (Exception exc) {
            System.out.println("Error al tratar de abrir la base de datos" + bd + " : " + exc);
        }
    }
    
    public OracleConnection(String ip, String bd, String usr, String pass) {
        driver = "oracle.jdbc.driver.OracleDriver";
        this.bd = bd;
        this.usr = usr;
        this.pass = pass;
        url = new String("jdbc:oracle:thin:@" + ip + ":1521:" + bd);
        try {
            Class.forName(driver).newInstance();
            conexion = DriverManager.getConnection(url, usr, pass);
            System.out.println("Conexión a oracle establecida correctamente.");
            
        } catch (Exception exc) {
            System.out.println("Error al tratar de abrir la base de datos" + bd + " : " + exc);
        }
    }
    
    public Connection getConexion() {
        return conexion;
    }
    
    public Connection CerrarConexion() throws SQLException {
        conexion.close();
        conexion = null;
        return conexion;
    }
} //fin de la clase