-- Generado por Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   en:        2019-09-07 21:05:24 CLT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE tb_categoria_plato (
    id_categoria_plato   NUMBER NOT NULL,
    descripcion          VARCHAR2(255),
    habilitado           NUMBER
);

ALTER TABLE tb_categoria_plato ADD CONSTRAINT tb_categoria_plato_pk PRIMARY KEY ( id_categoria_plato );

CREATE TABLE tb_categoria_producto (
    id_categoria_producto   NUMBER NOT NULL,
    descripcion             VARCHAR2(255),
    es_vendible             NUMBER,
    habilitado              NUMBER
);

ALTER TABLE tb_categoria_producto ADD CONSTRAINT tb_categoria_producto_pk PRIMARY KEY ( id_categoria_producto );

CREATE TABLE tb_cliente (
    id_cliente   NUMBER NOT NULL,
    rut          NUMBER,
    nombre       VARCHAR2(255)
);

ALTER TABLE tb_cliente ADD CONSTRAINT tb_cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE tb_detalle_menu (
    id_detalle    NUMBER NOT NULL,
    tipo_menu     VARCHAR2(255),
    id_menu       NUMBER NOT NULL,
    id_producto   NUMBER,
    id_plato      NUMBER
);

ALTER TABLE tb_detalle_menu ADD CONSTRAINT tb_detalle_menu_pk PRIMARY KEY ( id_detalle );

CREATE TABLE tb_detalle_pedido (
    id_detalle_pedido   NUMBER NOT NULL,
    tipo_pedido         VARCHAR2(100),
    precio              NUMBER,
    cantidad            NUMBER,
    total               NUMBER,
    notas               VARCHAR2(500),
    id_producto         NUMBER,
    id_menu             NUMBER,
    id_plato            NUMBER,
    id_pedido           NUMBER NOT NULL
);

ALTER TABLE tb_detalle_pedido ADD CONSTRAINT detalle_pedido_pk PRIMARY KEY ( id_detalle_pedido );

CREATE TABLE tb_detalle_solicitud (
    id_detalle     NUMBER NOT NULL,
    cantidad       NUMBER,
    precio         NUMBER,
    total          NUMBER,
    id_solicitud   NUMBER NOT NULL,
    id_producto    NUMBER NOT NULL
);

ALTER TABLE tb_detalle_solicitud ADD CONSTRAINT detalle_solicitud_pk PRIMARY KEY ( id_detalle );

CREATE TABLE tb_estado_pedido (
    id_estado     NUMBER NOT NULL,
    descripcion   VARCHAR2(255)
);

ALTER TABLE tb_estado_pedido ADD CONSTRAINT tb_estado_pedido_pk PRIMARY KEY ( id_estado );

CREATE TABLE tb_estado_solicitud (
    id_estado    NUMBER NOT NULL,
    descrpcion   VARCHAR2(255)
);

ALTER TABLE tb_estado_solicitud ADD CONSTRAINT estado_solicitud_pk PRIMARY KEY ( id_estado );

CREATE TABLE tb_ingrediente_no_deseado (
    id_detalle_pedido   NUMBER NOT NULL,
    id_ingrediente      NUMBER NOT NULL
);

CREATE TABLE tb_ingrediente_plato (
    id_ingrediente_plato   NUMBER NOT NULL,
    descuento_stock        NUMBER,
    id_plato               NUMBER NOT NULL,
    id_producto            NUMBER NOT NULL
);

ALTER TABLE tb_ingrediente_plato ADD CONSTRAINT tb_ingrediente_plato_pk PRIMARY KEY ( id_ingrediente_plato );

CREATE TABLE tb_mapa_acceso (
    id_modulo     NUMBER NOT NULL,
    descripcion   VARCHAR2(255),
    url           VARCHAR2(255),
    id_perfil     NUMBER NOT NULL
);

CREATE TABLE tb_menu (
    id_menu       NUMBER NOT NULL,
    descripcion   VARCHAR2(255),
    imagen        BLOB,
    precio        NUMBER,
    habilitado    NUMBER
);

ALTER TABLE tb_menu ADD CONSTRAINT tb_menu_pk PRIMARY KEY ( id_menu );

CREATE TABLE tb_mesa (
    id_mesa        NUMBER NOT NULL,
    descripcion    VARCHAR2(255),
    posicion_al    NUMBER,
    posicion_an    NUMBER,
    max_personas   NUMBER,
    estado         NUMBER,
    habilitado     NUMBER
);

ALTER TABLE tb_mesa ADD CONSTRAINT tb_mesa_pk PRIMARY KEY ( id_mesa );

CREATE TABLE tb_pedido (
    id_pedido          NUMBER NOT NULL,
    comensales         NUMBER,
    fecha_pedido       DATE,
    total              NUMBER,
    metodo_pago        VARCHAR2(100),
    id_estado_pedido   NUMBER NOT NULL,
    id_cliente         NUMBER NOT NULL,
    id_mesa            NUMBER NOT NULL
);

ALTER TABLE tb_pedido ADD CONSTRAINT tb_pedido_pk PRIMARY KEY ( id_pedido );

CREATE TABLE tb_perfil (
    id_perfil     NUMBER NOT NULL,
    descripcion   VARCHAR2(255)
);

ALTER TABLE tb_perfil ADD CONSTRAINT tb_perfil_pk PRIMARY KEY ( id_perfil );

CREATE TABLE tb_plato (
    id_plato             NUMBER NOT NULL,
    descripcion          VARCHAR2(255),
    receta               CLOB,
    imagen               BLOB,
    precio               NUMBER,
    habilitado           NUMBER,
    id_categoria_plato   NUMBER NOT NULL
);

ALTER TABLE tb_plato ADD CONSTRAINT tb_plato_pk PRIMARY KEY ( id_plato );

CREATE TABLE tb_producto (
    id_producto       NUMBER NOT NULL,
    descripcion       VARCHAR2(255),
    precio_unitario   NUMBER,
    stock             NUMBER,
    habilitado        NUMBER,
    id_categoria      NUMBER NOT NULL
);

ALTER TABLE tb_producto ADD CONSTRAINT tb_producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE tb_proveedor (
    id_proveedor        NUMBER NOT NULL,
    descripcion         VARCHAR2(255),
    correo              VARCHAR2(500),
    telefono_contacto   NUMBER,
    habilitado          NUMBER
);

ALTER TABLE tb_proveedor ADD CONSTRAINT tb_proveedores_pk PRIMARY KEY ( id_proveedor );

CREATE TABLE tb_solicitud_proveedor (
    id_solicitud      NUMBER NOT NULL,
    fecha_solicitud   DATE,
    total             NUMBER,
    id_proveedor      NUMBER NOT NULL,
    id_estado         NUMBER NOT NULL
);

ALTER TABLE tb_solicitud_proveedor ADD CONSTRAINT tb_solicitud_proveedor_pk PRIMARY KEY ( id_solicitud );

CREATE TABLE tb_usuario (
    id_usuario   NUMBER NOT NULL,
    usuario      VARCHAR2(255) NOT NULL,
    contrasena   VARCHAR2(255) NOT NULL,
    nombre       VARCHAR2(255) NOT NULL,
    apellido     VARCHAR2(255) NOT NULL,
    habilitado   NUMBER,
    id_perfil    NUMBER NOT NULL
);

ALTER TABLE tb_usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE tb_detalle_pedido
    ADD CONSTRAINT detalle_pedido_menu_fk FOREIGN KEY ( id_menu )
        REFERENCES tb_menu ( id_menu );

ALTER TABLE tb_detalle_pedido
    ADD CONSTRAINT detalle_pedido_pedido_fk FOREIGN KEY ( id_pedido )
        REFERENCES tb_pedido ( id_pedido );

ALTER TABLE tb_detalle_pedido
    ADD CONSTRAINT detalle_pedido_plato_fk FOREIGN KEY ( id_plato )
        REFERENCES tb_plato ( id_plato );

ALTER TABLE tb_detalle_pedido
    ADD CONSTRAINT detalle_pedido_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES tb_producto ( id_producto );

ALTER TABLE tb_detalle_solicitud
    ADD CONSTRAINT detalle_solicitud_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES tb_producto ( id_producto );

ALTER TABLE tb_detalle_solicitud
    ADD CONSTRAINT detalle_solicitud_solicitud_fk FOREIGN KEY ( id_solicitud )
        REFERENCES tb_solicitud_proveedor ( id_solicitud );

ALTER TABLE tb_ingrediente_plato
    ADD CONSTRAINT ingrediente_plato_plato_fk FOREIGN KEY ( id_plato )
        REFERENCES tb_plato ( id_plato );

ALTER TABLE tb_ingrediente_plato
    ADD CONSTRAINT ingrediente_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES tb_producto ( id_producto );

ALTER TABLE tb_ingrediente_no_deseado
    ADD CONSTRAINT no_deseado_detalle_pedido_fk FOREIGN KEY ( id_detalle_pedido )
        REFERENCES tb_detalle_pedido ( id_detalle_pedido );

ALTER TABLE tb_ingrediente_no_deseado
    ADD CONSTRAINT no_deseado_ingrediente_fk FOREIGN KEY ( id_ingrediente )
        REFERENCES tb_ingrediente_plato ( id_ingrediente_plato );

ALTER TABLE tb_producto
    ADD CONSTRAINT producto_categoria_fk FOREIGN KEY ( id_categoria )
        REFERENCES tb_categoria_producto ( id_categoria_producto );

ALTER TABLE tb_solicitud_proveedor
    ADD CONSTRAINT solicitud_estado_solicitud_fk FOREIGN KEY ( id_estado )
        REFERENCES tb_estado_solicitud ( id_estado );

ALTER TABLE tb_solicitud_proveedor
    ADD CONSTRAINT solicitud_proveedor_fk FOREIGN KEY ( id_proveedor )
        REFERENCES tb_proveedor ( id_proveedor );

ALTER TABLE tb_detalle_menu
    ADD CONSTRAINT tb_detalle_menu_tb_menu_fk FOREIGN KEY ( id_menu )
        REFERENCES tb_menu ( id_menu );

ALTER TABLE tb_detalle_menu
    ADD CONSTRAINT tb_detalle_menu_tb_plato_fk FOREIGN KEY ( id_plato )
        REFERENCES tb_plato ( id_plato );

ALTER TABLE tb_detalle_menu
    ADD CONSTRAINT tb_detalle_menu_tb_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES tb_producto ( id_producto );

ALTER TABLE tb_mapa_acceso
    ADD CONSTRAINT tb_mapa_acceso_tb_perfil_fk FOREIGN KEY ( id_perfil )
        REFERENCES tb_perfil ( id_perfil );

ALTER TABLE tb_pedido
    ADD CONSTRAINT tb_pedido_tb_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES tb_cliente ( id_cliente );

ALTER TABLE tb_pedido
    ADD CONSTRAINT tb_pedido_tb_estado_pedido_fk FOREIGN KEY ( id_estado_pedido )
        REFERENCES tb_estado_pedido ( id_estado );

ALTER TABLE tb_pedido
    ADD CONSTRAINT tb_pedido_tb_mesa_fk FOREIGN KEY ( id_mesa )
        REFERENCES tb_mesa ( id_mesa );

ALTER TABLE tb_plato
    ADD CONSTRAINT tb_plato_tb_categoria_plato_fk FOREIGN KEY ( id_categoria_plato )
        REFERENCES tb_categoria_plato ( id_categoria_plato );

ALTER TABLE tb_usuario
    ADD CONSTRAINT tb_usuario_tb_perfil_fk FOREIGN KEY ( id_perfil )
        REFERENCES tb_perfil ( id_perfil );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            20
-- CREATE INDEX                             0
-- ALTER TABLE                             40
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
