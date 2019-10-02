CREATE SEQUENCE  SEC_CATEGORIA_PLATO MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_CATEGORIA_PRODUCTO MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_USUARIO MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_CLIENTE MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_PLATO MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_INGREDIENTE_PLATO MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_MENU MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_DETALLE_MENU MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_PEDIDO MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_SOLICITUD_PROVEEDOR MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_DETALLE_PEDIDO MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_DETALLE_SOLICITUD MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_MESA MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_PRODUCTO MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE  SEC_PROVEEDOR MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1;

CREATE OR REPLACE PACKAGE BODY PKG_MANTENEDORES AS

    --CATEGORIA_PLATO
    PROCEDURE LISTAR_CATEGORIA_PLATO (IO_CURSOR OUT T_CURSOR,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_CATEGORIA_PLATO,
                DESCRIPCION,
                HABILITADO
            FROM
                TB_CATEGORIA_PLATO;    
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                          
    
    PROCEDURE AGREGAR_CATEGORIA_PLATO(PDESCRIPCION IN VARCHAR2,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_CATEGORIA_PLATO (
            ID_CATEGORIA_PLATO,
            DESCRIPCION,
            HABILITADO
        ) VALUES (
            SEC_CATEGORIA_PLATO.NEXTVAL,
            PDESCRIPCION,
            1
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE EDITAR_CATEGORIA_PLATO(PID_CATEGORIA IN NUMBER, PDESCRIPCION IN VARCHAR2,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_CATEGORIA_PLATO
        SET
            DESCRIPCION = PDESCRIPCION
        WHERE
            ID_CATEGORIA_PLATO = PID_CATEGORIA;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                                     

    PROCEDURE DESHABILITAR_CATEGORIA_PLATO(PID_CATEGORIA IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_CATEGORIA_PLATO
        SET
            HABILITADO = 0
        WHERE
            ID_CATEGORIA_PLATO = PID_CATEGORIA;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                                  
                                     
    PROCEDURE HABILITAR_CATEGORIA_PLATO(PID_CATEGORIA IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_CATEGORIA_PLATO
        SET
            HABILITADO = 1
        WHERE
            ID_CATEGORIA_PLATO = PID_CATEGORIA;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                                  
    --END CATEGORIA_PLATO 
    
    --CATEGORIA_PRODUCTO
    PROCEDURE LISTAR_CATEGORIA_PRODUCTO (IO_CURSOR OUT T_CURSOR,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_CATEGORIA_PRODUCTO,
                DESCRIPCION,
                HABILITADO
            FROM
                TB_CATEGORIA_PRODUCTO;    
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                            
    
    PROCEDURE AGREGAR_CATEGORIA_PRODUCTO(PDESCRIPCION IN VARCHAR2,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_CATEGORIA_PRODUCTO (
            ID_CATEGORIA_PRODUCTO,
            DESCRIPCION,
            HABILITADO
        ) VALUES (
            SEC_CATEGORIA_PRODUCTO.NEXTVAL,
            PDESCRIPCION,
            1
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE EDITAR_CATEGORIA_PRODUCTO(PID_CATEGORIA IN NUMBER, PDESCRIPCION IN VARCHAR2,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_CATEGORIA_PRODUCTO
        SET
            DESCRIPCION = PDESCRIPCION
        WHERE
            ID_CATEGORIA_PRODUCTO = PID_CATEGORIA;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                                     

    PROCEDURE DESHABILITAR_CATEGORIA_PRODUCT(PID_CATEGORIA IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_CATEGORIA_PRODUCTO
        SET
            HABILITADO = 0
        WHERE
            ID_CATEGORIA_PRODUCTO = PID_CATEGORIA;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                                  
                                     
    PROCEDURE HABILITAR_CATEGORIA_PRODUCTO(PID_CATEGORIA IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_CATEGORIA_PRODUCTO
        SET
            HABILITADO = 1
        WHERE
            ID_CATEGORIA_PRODUCTO = PID_CATEGORIA;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;          
    -- END CATEGORIA_PRODUCTO
    
    --USUARIO
    PROCEDURE LISTAR_USUARIO (IO_CURSOR OUT T_CURSOR,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_USUARIO,
                USUARIO,
                NOMBRE,
                APELLIDO,
                ID_PERFIL
            FROM
                TB_USUARIO;    
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                             
    
    PROCEDURE AGREGAR_USUARIO(PUSUARIO IN VARCHAR2, PCONTRASENA IN VARCHAR2, PNOMBRE IN VARCHAR2, PAPELLIDO IN VARCHAR2, PID_PERFIL IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_USUARIO (
            ID_USUARIO,
            USUARIO,
            CONTRASENA,
            NOMBRE,
            APELLIDO,
            HABILITADO,
            ID_PERFIL
        ) VALUES (
            SEC_USUARIO.NEXTVAL,
            PUSUARIO,
            PCONTRASENA,
            PNOMBRE,
            PAPELLIDO,
            1,
            PID_PERFIL
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE EDITAR_USUARIO(PID_USUARIO IN VARCHAR2, PUSUARIO IN VARCHAR2, PCONTRASENA IN VARCHAR2, PNOMBRE IN VARCHAR2, PAPELLIDO IN VARCHAR2, PID_PERFIL IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_USUARIO
        SET
            USUARIO = PUSUARIO,
            CONTRASENA = PCONTRASENA,
            NOMBRE = PNOMBRE,
            APELLIDO = PAPELLIDO,
            ID_PERFIL = PID_PERFIL
        WHERE
            ID_USUARIO = PID_USUARIO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                                     

    PROCEDURE DESHABILITAR_USUARIO(PID_USUARIO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_USUARIO
        SET
            HABILITADO = 0
        WHERE
            ID_USUARIO = PID_USUARIO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                                  
                                     
    PROCEDURE HABILITAR_USUARIO(PID_USUARIO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_USUARIO
        SET
            HABILITADO = 1
        WHERE
            ID_USUARIO = PID_USUARIO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    --END USUARIO
    
    --CLIENTE
        PROCEDURE AGREGAR_CLIENTE(PRUT IN VARCHAR2, PNOMBRE IN VARCHAR2, PID_CLIENTE_DEVUELTO OUT NUMBER,
                                     PERROR OUT VARCHAR2)
        IS
        TOTAL NUMBER;
        AUX_ID NUMBER;
        BEGIN
            PERROR := 'OK';
            TOTAL := 0;
            
            SELECT COUNT(*) INTO TOTAL FROM TB_CLIENTE WHERE RUT = PRUT;
            
            IF TOTAL = 0 THEN
                INSERT INTO TB_CLIENTE (
                    ID_CLIENTE,
                    RUT,
                    NOMBRE
                ) VALUES (
                    SEC_CLIENTE.NEXTVAL,
                    PRUT,
                    PNOMBRE
                ); 
                COMMIT;
            ELSE
                SELECT ID_CLIENTE INTO AUX_ID FROM TB_CLIENTE WHERE RUT = RUT;
                PID_CLIENTE_DEVUELTO := AUX_ID;
            END IF;                
        EXCEPTION 
        WHEN OTHERS THEN
            PERROR:= SQLERRM;
        END;
    --END CLIENTE
    
    --INGREDIENTE NO DESEADO
        PROCEDURE AGREGAR_INGREDIENTE_NO_DESEADO(PID_DETALLE_PEDIDO NUMBER, PID_INGREDIENTE NUMBER,
                                     PERROR OUT VARCHAR2)
        IS
        BEGIN
            PERROR := 'OK';
            
            INSERT INTO TB_INGREDIENTE_NO_DESEADO (
                ID_DETALLE_PEDIDO,
                ID_INGREDIENTE
            ) VALUES (
                PID_DETALLE_PEDIDO,
                PID_INGREDIENTE
            ); 
            COMMIT;               
        EXCEPTION 
        WHEN OTHERS THEN
            PERROR:= SQLERRM;
        END;
    --END INGREDIENTE NO DESEADO
    
    --PLATO - INGREDIENTE PLATO
    PROCEDURE LISTAR_PLATO (IO_CURSOR OUT T_CURSOR,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_PLATO,
                DESCRIPCION,
                RECETA,
                IMAGEN,
                PRECIO,
                ID_CATEGORIA_PLATO
            FROM
                TB_PLATO;    
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END; 
    
    PROCEDURE AGREGAR_PLATO(PDESCRIPCION IN VARCHAR2, PRECETA IN CLOB, PIMAGEN IN BLOB, PPRECIO IN NUMBER, PID_CATEGORIA_PLATO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_PLATO (
            ID_PLATO,
            DESCRIPCION,
            RECETA,
            IMAGEN,
            PRECIO,
            HABILITADO,
            ID_CATEGORIA_PLATO
        ) VALUES (
            SEC_PLATO.NEXTVAL,
            PDESCRIPCION,
            PRECETA,
            PIMAGEN,
            PPRECIO,
            1,
            PID_CATEGORIA_PLATO
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE EDITAR_PLATO(PID_PLATO IN NUMBER, PDESCRIPCION IN VARCHAR2, PRECETA IN CLOB, PIMAGEN IN BLOB, PPRECIO IN NUMBER, PID_CATEGORIA_PLATO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PLATO
        SET
            DESCRIPCION = PDESCRIPCION,
            RECETA = PRECETA,
            IMAGEN = PIMAGEN,
            PRECIO = PPRECIO,
            ID_CATEGORIA_PLATO = PID_CATEGORIA_PLATO
        WHERE
            ID_PLATO = PID_PLATO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE HABILITAR_PLATO(PID_PLATO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PLATO
        SET
            HABILITADO = 1
        WHERE
            ID_PLATO = PID_PLATO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE DESHABILITAR_PLATO(PID_PLATO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PLATO
        SET
            HABILITADO = 0
        WHERE
            ID_PLATO = PID_PLATO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE AGREGAR_INGREDIENTE_PLATO(PDESCUENTO_STOCK IN VARCHAR2, PID_PLATO IN NUMBER, PID_PRODUCTO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_INGREDIENTE_PLATO (
            ID_INGREDIENTE_PLATO,
            DESCUENTO_STOCK,
            ID_PLATO,
            ID_PRODUCTO
        ) VALUES (
            SEC_INGREDIENTE_PLATO.NEXTVAL,
            PDESCUENTO_STOCK,
            PID_PLATO,
            PID_PRODUCTO
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE ELIMINAR_INGREDIENTE_PLATO(PID_PLATO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        DELETE FROM TB_INGREDIENTE_PLATO WHERE ID_PLATO = PID_PLATO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE LISTAR_INGREDIENTE_PLATO(IO_CURSOR OUT T_CURSOR, PID_PLATO IN NUMBER,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_INGREDIENTE_PLATO,
                DESCUENTO_STOCK,
                ID_PRODUCTO
            FROM
                TB_INGREDIENTE_PLATO
            WHERE 
                ID_PLATO = PID_PLATO;
                
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                          
    --END PLATO - INGREDIENTE PLATO
    
    --MENÚ - DETALLE MENÚ
    PROCEDURE LISTAR_MENU (IO_CURSOR OUT T_CURSOR,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_MENU,
                DESCRIPCION,
                IMAGEN,
                PRECIO
            FROM
                TB_MENU;    
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END; 
    
    PROCEDURE AGREGAR_MENU(PDESCRIPCION IN VARCHAR2, PIMAGEN IN BLOB, PPRECIO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_MENU (
            ID_MENU,
            DESCRIPCION,
            IMAGEN,
            PRECIO,
            HABILITADO
        ) VALUES (
            SEC_MENU.NEXTVAL,
            PDESCRIPCION,
            PIMAGEN,
            PPRECIO,
            1
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE EDITAR_MENU(PID_MENU IN NUMBER, PDESCRIPCION IN VARCHAR2, PIMAGEN IN BLOB, PPRECIO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_MENU
        SET
            DESCRIPCION = PDESCRIPCION,
            IMAGEN = PIMAGEN,
            PRECIO = PPRECIO
        WHERE
            ID_MENU = PID_MENU;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE HABILITAR_MENU(PID_MENU IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_MENU
        SET
            HABILITADO = 1
        WHERE
            ID_MENU = PID_MENU;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE DESHABILITAR_MENU(PID_MENU IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_MENU
        SET
            HABILITADO = 0
        WHERE
            ID_MENU = PID_MENU;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE AGREGAR_DETALLE_MENU(PTIPO_MENU IN VARCHAR2, PID_MENU IN NUMBER, PID_PRODUCTO IN NUMBER, PID_PLATO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_DETALLE_MENU (
            ID_DETALLE,
            TIPO_MENU,
            ID_MENU,
            ID_PRODUCTO,
            ID_PLATO
        ) VALUES (
            SEC_DETALLE_MENU.NEXTVAL,
            PTIPO_MENU,
            PID_MENU,
            PID_PRODUCTO,
            PID_PLATO
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE ELIMINAR_DETALLE_MENU(PID_MENU IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        DELETE FROM TB_DETALLE_MENU WHERE ID_MENU = PID_MENU;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE LISTAR_DETALLE_MENU(IO_CURSOR OUT T_CURSOR, PID_MENU IN NUMBER,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_DETALLE,
                TIPO_MENU,
                ID_PRODUCTO,
                ID_PLATO
            FROM
                TB_DETALLE_MENU
            WHERE 
                ID_MENU = PID_MENU;
                
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                          
    --END MENÚ - DETALLE MENÚ
    
    --PEDIDO - DETALLE PEDIDO
    PROCEDURE AGREGAR_PEDIDO(PCOMENSALES IN VARCHAR2, PFECHA_PEDIDO IN DATE, PTOTAL IN NUMBER, PMETODO_PAGO IN VARCHAR2, PID_CLIENTE IN NUMBER, PID_MESA IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_PEDIDO (
            ID_PEDIDO,
            COMENSALES,
            FECHA_PEDIDO,
            TOTAL,
            METODO_PAGO,
            ID_ESTADO_PEDIDO,
            ID_CLIENTE,
            ID_MESA
        ) VALUES (
            SEC_PEDIDO.NEXTVAL,
            PCOMENSALES,
            PFECHA_PEDIDO,
            PTOTAL,
            PMETODO_PAGO,
            1,
            PID_CLIENTE,
            PID_MESA
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE ACTUALIZAR_ESTADO_PEDIDO(PID_PEDIDO IN NUMBER, PID_ESTADO_PEDIDO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PEDIDO
        SET
            ID_ESTADO_PEDIDO = PID_ESTADO_PEDIDO
        WHERE
            ID_PEDIDO = PID_PEDIDO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE CANCELAR_PEDIDO(PID_PEDIDO IN NUMBER, PID_ESTADO_PEDIDO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PEDIDO
        SET
            ID_ESTADO_PEDIDO = PID_ESTADO_PEDIDO
        WHERE
            ID_PEDIDO = 5;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;     
    
    PROCEDURE AGREGAR_DETALLE_PEDIDO(PTIPO_PEDIDO IN VARCHAR2, PPRECIO IN NUMBER, PCANTIDAD IN NUMBER, PTOTAL IN NUMBER, PNOTAS IN VARCHAR2, PID_PRODUCTO IN NUMBER, PID_MENU IN NUMBER, PID_PLATO IN NUMBER, PID_PEDIDO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_DETALLE_PEDIDO (
            ID_DETALLE_PEDIDO,
            TIPO_PEDIDO,
            PRECIO,
            CANTIDAD,
            TOTAL,
            NOTAS,
            ID_PRODUCTO,
            ID_MENU,
            ID_PLATO,
            ID_PEDIDO
        ) VALUES (
            SEC_DETALLE_PEDIDO.NEXTVAL,
            PTIPO_PEDIDO,
            PPRECIO,
            PCANTIDAD,
            PTOTAL,
            PNOTAS,
            PID_PRODUCTO,
            PID_MENU,
            PID_PLATO,
            PID_PEDIDO
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE ELIMINAR_DETALLE_PEDIDO(PID_PEDIDO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        DELETE FROM TB_DETALLE_PEDIDO WHERE ID_PEDIDO = PID_PEDIDO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE LISTAR_DETALLE_PEDIDO(IO_CURSOR OUT T_CURSOR, PID_PEDIDO IN NUMBER,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_DETALLE_PEDIDO,
                TIPO_PEDIDO,
                PRECIO,
                CANTIDAD,
                TOTAL,
                NOTAS,
                ID_PRODUCTO,
                ID_MENU,
                ID_PLATO
            FROM
                TB_DETALLE_PEDIDO
            WHERE 
                ID_PEDIDO = PID_PEDIDO;
                
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;                          
    --END PEDIDO - DETALLE PEDIDO
    
    --SOLICITUD PROVEEDOR - DETALLE SOLICITUD
    PROCEDURE LISTAR_SOLICITUD_PROVEEDOR (IO_CURSOR OUT T_CURSOR,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_SOLICITUD,
                FECHA_SOLICITUD,
                TOTAL,
                ID_PROVEEDOR,
                ID_ESTADO
            FROM
                TB_SOLICITUD_PROVEEDOR;    
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE AGREGAR_SOLICITUD_PROVEEDOR(PFECHA_SOLICITUD IN DATE, PTOTAL IN NUMBER, PID_PROVEEDOR IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_SOLICITUD_PROVEEDOR (
            ID_SOLICITUD,
            FECHA_SOLICITUD,
            TOTAL,
            ID_PROVEEDOR,
            ID_ESTADO
        ) VALUES (
            SEC_SOLICITUD_PROVEEDOR.NEXTVAL,
            PFECHA_SOLICITUD,
            PTOTAL,
            PID_PROVEEDOR,
            1
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE EDITAR_SOLICITUD_PROVEEDOR(PID_SOLICITUD IN NUMBER, PFECHA_SOLICITUD IN DATE, PTOTAL IN NUMBER, PID_PROVEEDOR IN NUMBER, PID_ESTADO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_SOLICITUD_PROVEEDOR
        SET
            FECHA_SOLICITUD = PFECHA_SOLICITUD,
            TOTAL = PTOTAL,
            ID_PROVEEDOR = PID_PROVEEDOR,
            ID_ESTADO = PID_ESTADO
        WHERE
            ID_SOLICITUD = PID_SOLICITUD;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE AGREGAR_DETALLE_SOLICITUD(PCANTIDAD IN NUMBER, PPRECIO IN NUMBER, PTOTAL IN NUMBER, PID_SOLICITUD IN NUMBER, PID_PRODUCTO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_DETALLE_SOLICITUD (
            ID_DETALLE,
            CANTIDAD,
            PRECIO,
            TOTAL,
            ID_SOLICITUD,
            ID_PRODUCTO
        ) VALUES (
            SEC_DETALLE_SOLICITUD.NEXTVAL,
            PCANTIDAD,
            PPRECIO,
            PTOTAL,
            PID_SOLICITUD,
            PID_PRODUCTO
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE ELIMINAR_DETALLE_SOLICITUD(PID_SOLICITUD IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        DELETE FROM TB_DETALLE_SOLICITUD WHERE ID_SOLICITUD = PID_SOLICITUD;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE LISTAR_DETALLE_SOLICITUD(IO_CURSOR OUT T_CURSOR, PID_SOLICITUD IN NUMBER,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_DETALLE,
                CANTIDAD,
                PRECIO,
                TOTAL,
                ID_PRODUCTO
            FROM
                TB_DETALLE_SOLICITUD
            WHERE 
                ID_SOLICITUD = PID_SOLICITUD;
                
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    --END --SOLICITUD PROVEEDOR - DETALLE SOLICITUD
    
    --MESA
    PROCEDURE LISTAR_MESA (IO_CURSOR OUT T_CURSOR,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_MESA,
                DESCRIPCION,
                POSICION_AL,
                POSICION_AN,
                MAX_PERSONAS,
                ESTADO
            FROM
                TB_MESA;    
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE AGREGAR_MESA(PDESCRIPCION IN VARCHAR2, PPOSICION_AL IN NUMBER, PPOSICION_AN IN NUMBER, PMAX_PERSONAS IN NUMBER, PESTADO IN VARCHAR2,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_MESA (
            ID_MESA,
            DESCRIPCION,
            POSICION_AL,
            POSICION_AN,
            MAX_PERSONAS,
            ESTADO,
            HABILITADO
        ) VALUES (
            SEC_MESA.NEXTVAL,
            PDESCRIPCION,
            PPOSICION_AL,
            PPOSICION_AN,
            PMAX_PERSONAS,
            PESTADO,
            1
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE EDITAR_MESA(PID_MESA IN NUMBER, PDESCRIPCION IN VARCHAR2, PPOSICION_AL IN NUMBER, PPOSICION_AN IN NUMBER, PMAX_PERSONAS IN NUMBER, PESTADO IN VARCHAR2,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_MESA
        SET
            DESCRIPCION = PDESCRIPCION,
            POSICION_AL = PPOSICION_AL,
            POSICION_AN = PPOSICION_AN,
            MAX_PERSONAS = PMAX_PERSONAS,
            ESTADO = PESTADO
        WHERE
            ID_MESA = PID_MESA;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE HABILITAR_MESA(PID_MESA IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_MESA
        SET
            HABILITADO = 1
        WHERE
            ID_MESA = PID_MESA;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE DESHABILITAR_MESA(PID_MESA IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_MESA
        SET
            HABILITADO = 0
        WHERE
            ID_MESA = PID_MESA;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    --END MESA
    
    --PRODUCTO
    PROCEDURE LISTAR_PRODUCTO (IO_CURSOR OUT T_CURSOR,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_PRODUCTO,
                DESCRIPCION,
                PRECIO_UNITARIO,
                STOCK,
                ID_CATEGORIA
            FROM
                TB_PRODUCTO;    
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE AGREGAR_PRODUCTO(PDESCRIPCION IN VARCHAR2, PPRECIO_UNITARIO IN NUMBER, PSTOCK IN NUMBER, PID_CATEGORIA IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_PRODUCTO (
            ID_PRODUCTO,
            DESCRIPCION,
            PRECIO_UNITARIO,
            STOCK,
            HABILITADO,
            ID_CATEGORIA
        ) VALUES (
            SEC_PRODUCTO.NEXTVAL,
            PDESCRIPCION,
            PPRECIO_UNITARIO,
            PSTOCK,
            1,
            PID_CATEGORIA
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE EDITAR_PRODUCTO(PID_PRODUCTO IN NUMBER, PDESCRIPCION IN VARCHAR2, PPRECIO_UNITARIO IN NUMBER, PSTOCK IN NUMBER, PID_CATEGORIA IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PRODUCTO
        SET
            DESCRIPCION = PDESCRIPCION,
            PRECIO_UNITARIO = PPRECIO_UNITARIO,
            STOCK = PSTOCK,
            ID_CATEGORIA = PID_CATEGORIA
        WHERE
            ID_PRODUCTO = PID_PRODUCTO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE HABILITAR_PRODUCTO(PID_PRODUCTO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PRODUCTO
        SET
            HABILITADO = 1
        WHERE
            ID_PRODUCTO = PID_PRODUCTO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE DESHABILITAR_PRODUCTO(PID_PRODUCTO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PRODUCTO
        SET
            HABILITADO = 0
        WHERE
            ID_PRODUCTO = PID_PRODUCTO;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    --END PRODUCTO
    
    --PROVEEDOR
    PROCEDURE LISTAR_PROVEEDOR (IO_CURSOR OUT T_CURSOR,
                              PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        OPEN IO_CURSOR FOR
           SELECT
                ID_PROVEEDOR,
                DESCRIPCION,
                CORREO,
                TELEFONO_CONTACTO
            FROM
                TB_PROVEEDOR;    
                
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE AGREGAR_PROVEEDOR(PDESCRIPCION IN VARCHAR2, PCORREO IN NUMBER, PTELEFONO_CONTACTO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        INSERT INTO TB_PROVEEDOR (
            ID_PROVEEDOR,
            DESCRIPCION,
            CORREO,
            TELEFONO_CONTACTO,
            HABILITADO
        ) VALUES (
            SEC_PROVEEDOR.NEXTVAL,
            PDESCRIPCION,
            PCORREO,
            PTELEFONO_CONTACTO,
            1
        ); 
        
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE EDITAR_PROVEEDOR(PID_PROVEEDOR IN NUMBER, PDESCRIPCION IN VARCHAR2, PCORREO IN NUMBER, PTELEFONO_CONTACTO IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PROVEEDOR
        SET
            DESCRIPCION = PDESCRIPCION,
            CORREO = PCORREO,
            TELEFONO_CONTACTO = PTELEFONO_CONTACTO
        WHERE
            ID_PROVEEDOR = PID_PROVEEDOR;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE HABILITAR_PROVEEDOR(PID_PROVEEDOR IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PROVEEDOR
        SET
            HABILITADO = 1
        WHERE
            ID_PROVEEDOR = PID_PROVEEDOR;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    
    PROCEDURE DESHABILITAR_PROVEEDOR(PID_PROVEEDOR IN NUMBER,
                                     PERROR OUT VARCHAR2)
    IS
    BEGIN
        PERROR := 'OK';
        
        UPDATE TB_PROVEEDOR
        SET
            HABILITADO = 0
        WHERE
            ID_PROVEEDOR = PID_PROVEEDOR;
            
        COMMIT;
                        
    EXCEPTION 
    WHEN OTHERS THEN
        PERROR:= SQLERRM;
    END;
    --END PROVEEDOR
END PKG_MANTENEDORES;