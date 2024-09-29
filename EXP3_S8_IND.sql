
CREATE TABLE ciudad (
    cod_ciudad NUMERIC(5) GENERATED ALWAYS AS IDENTITY,
    nombre     VARCHAR2(35 BYTE) NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( cod_ciudad );

CREATE TABLE comuna (
    cod_comuna        NUMERIC(5) GENERATED ALWAYS AS IDENTITY,
    nombre            VARCHAR2(35 BYTE) NOT NULL,
    ciudad_cod_ciudad NUMERIC(5) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( cod_comuna );

CREATE TABLE direccion (
    cod_direccion       CHAR(5 BYTE) NOT NULL,
    calle               CHAR(60 BYTE) NOT NULL,
    numero              NUMBER(5) NOT NULL,
    detalle             CHAR(25 BYTE),
    comuna_cod_comuna   NUMERIC(5) NOT NULL,
    escuela_cod_escuela CHAR(5 BYTE) NOT NULL
);

CREATE UNIQUE INDEX direccion__idx ON
    direccion (
        escuela_cod_escuela
    ASC );

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( cod_direccion );

CREATE TABLE empleado (
    cod_empleado        CHAR(5 BYTE) NOT NULL,
    rut                 CHAR(10 BYTE) NOT NULL,
    nombre              VARCHAR2(25 BYTE) NOT NULL,
    segundo_nombre      VARCHAR2(25 BYTE),
    apellido            VARCHAR2(25 BYTE) NOT NULL,
    segundo_apellido    VARCHAR2(25 BYTE),
    telefono            NUMBER(9) NOT NULL,
    nacionalidad        VARCHAR2(15) NOT NULL,
    escuela_cod_escuela CHAR(5 BYTE) NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( cod_empleado );

CREATE TABLE equipamiento (
    cod_equip                   CHAR(5 BYTE) NOT NULL,
    nombre                      VARCHAR2(25 BYTE) NOT NULL,
    tipo                        VARCHAR2(25 BYTE) NOT NULL,
    marca                       VARCHAR2(25 BYTE) NOT NULL,
    modelo                      VARCHAR2(25 BYTE) NOT NULL,
    instalacion_cod_instalacion CHAR(5 BYTE) NOT NULL
);

ALTER TABLE equipamiento ADD CONSTRAINT equipamiento_pk PRIMARY KEY ( cod_equip );

CREATE TABLE escuela (
    cod_escuela             CHAR(5 BYTE) NOT NULL,
    nombre                  VARCHAR2(40 BYTE) NOT NULL,
    tipo                    VARCHAR2(25 BYTE) NOT NULL,
    telefono                NUMBER(9) NOT NULL,
    correo                  VARCHAR2(40 BYTE) NOT NULL,
    direccion_cod_direccion CHAR(5 BYTE) NOT NULL
);

CREATE UNIQUE INDEX escuela__idx ON
    escuela (
        direccion_cod_direccion
    ASC );

ALTER TABLE escuela ADD CONSTRAINT escuela_pk PRIMARY KEY ( cod_escuela );

CREATE TABLE gasto (
    cod_gasto           CHAR(5 BYTE) NOT NULL,
    tipo                VARCHAR2(25 BYTE) NOT NULL,
    monto               NUMBER(8) NOT NULL,
    fecha               DATE NOT NULL,
    detalle             VARCHAR2(150 BYTE) NOT NULL,
    escuela_cod_escuela CHAR(5 BYTE) NOT NULL
);

ALTER TABLE gasto ADD CONSTRAINT gasto_pk PRIMARY KEY ( cod_gasto );

CREATE TABLE instalacion (
    cod_instalacion     CHAR(5 BYTE) NOT NULL,
    nombre              VARCHAR2(25 BYTE) NOT NULL,
    tipo                VARCHAR2(25 BYTE) NOT NULL,
    capacidad           NUMBER(4) NOT NULL,
    estado              VARCHAR2(25) NOT NULL,
    escuela_cod_escuela CHAR(5 BYTE) NOT NULL
);

ALTER TABLE instalacion ADD CONSTRAINT instalacion_pk PRIMARY KEY ( cod_instalacion );

CREATE TABLE solicitud (
    cod_solicitud       CHAR(5 BYTE) NOT NULL,
    fecha               DATE NOT NULL,
    monto               NUMBER(9) NOT NULL,
    estado              VARCHAR2(25 BYTE) NOT NULL,
    escuela_cod_escuela CHAR(5 BYTE)
);

ALTER TABLE solicitud ADD CONSTRAINT solicitud_pk PRIMARY KEY ( cod_solicitud );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_ciudad_fk FOREIGN KEY ( ciudad_cod_ciudad )
        REFERENCES ciudad ( cod_ciudad );

ALTER TABLE direccion
    ADD CONSTRAINT direccion_comuna_fk FOREIGN KEY ( comuna_cod_comuna )
        REFERENCES comuna ( cod_comuna );

ALTER TABLE direccion
    ADD CONSTRAINT direccion_escuela_fk FOREIGN KEY ( escuela_cod_escuela )
        REFERENCES escuela ( cod_escuela );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_escuela_fk FOREIGN KEY ( escuela_cod_escuela )
        REFERENCES escuela ( cod_escuela );

ALTER TABLE equipamiento
    ADD CONSTRAINT equipamiento_instalacion_fk FOREIGN KEY ( instalacion_cod_instalacion )
        REFERENCES instalacion ( cod_instalacion );

ALTER TABLE escuela
    ADD CONSTRAINT escuela_direccion_fk FOREIGN KEY ( direccion_cod_direccion )
        REFERENCES direccion ( cod_direccion );

ALTER TABLE gasto
    ADD CONSTRAINT gasto_escuela_fk FOREIGN KEY ( escuela_cod_escuela )
        REFERENCES escuela ( cod_escuela );

ALTER TABLE instalacion
    ADD CONSTRAINT instalacion_escuela_fk FOREIGN KEY ( escuela_cod_escuela )
        REFERENCES escuela ( cod_escuela );

ALTER TABLE solicitud
    ADD CONSTRAINT solicitud_escuela_fk FOREIGN KEY ( escuela_cod_escuela )
        REFERENCES escuela ( cod_escuela );
        
INSERT INTO ciudad (nombre) VALUES
('Santiago');
INSERT INTO ciudad (nombre) VALUES
('Valparaíso');
INSERT INTO ciudad (nombre) VALUES
('Concepción');
INSERT INTO ciudad (nombre) VALUES
('La Serena');
INSERT INTO ciudad (nombre) VALUES
('Antofagasta');
INSERT INTO ciudad (nombre) VALUES
('Puerto Montt');

INSERT INTO comuna (nombre, ciudad_cod_ciudad) VALUES
('Providencia', 1);
INSERT INTO comuna (nombre, ciudad_cod_ciudad) VALUES
('Viña del Mar', 2);
INSERT INTO comuna (nombre, ciudad_cod_ciudad) VALUES
('Talcahuano', 3);
INSERT INTO comuna (nombre, ciudad_cod_ciudad) VALUES
('Coquimbo', 4);
INSERT INTO comuna (nombre, ciudad_cod_ciudad) VALUES
('Mejillones', 5);
INSERT INTO comuna (nombre, ciudad_cod_ciudad) VALUES
('Puerto Varas', 6);


ALTER TABLE escuela MODIFY direccion_cod_direccion CHAR(5 BYTE) NULL;

-- AGREGAR REGISTROS A LA TABLA ESCUELA (sin referencia a direccion)
INSERT INTO escuela (cod_escuela, nombre, tipo, telefono, correo) VALUES
('ESC01', 'Escuela Básica Los Robles', 'Pública', 912345678, 'losrobles@edu.cl');
INSERT INTO escuela (cod_escuela, nombre, tipo, telefono, correo) VALUES
('ESC02', 'Liceo Técnico del Mar', 'Técnica', 923456789, 'liceomar@edu.cl');
INSERT INTO escuela (cod_escuela, nombre, tipo, telefono, correo) VALUES
('ESC03', 'Colegio San José', 'Privada', 934567890, 'sanjose@edu.cl');
INSERT INTO escuela (cod_escuela, nombre, tipo, telefono, correo) VALUES
('ESC04', 'Escuela Artística El Faro', 'Artística', 945678901, 'elfaro@edu.cl');
INSERT INTO escuela (cod_escuela, nombre, tipo, telefono, correo) VALUES
('ESC05', 'Instituto Bilingüe Futuro', 'Bilingüe', 956789012, 'futuro@edu.cl');
INSERT INTO escuela (cod_escuela, nombre, tipo, telefono, correo) VALUES
('ESC06', 'Escuela Rural Nuevo Amanecer', 'Rural', 967890123, 'nuevoamanecer@edu.cl');

-- AGREGAR REGISTROS A LA TABLA DIRECCION
INSERT INTO direccion (cod_direccion, calle, numero, detalle, comuna_cod_comuna, escuela_cod_escuela) VALUES
('DIR01', 'Av. Providencia', 1234, 'Esquina Los Leones', 1, 'ESC01');
INSERT INTO direccion (cod_direccion, calle, numero, detalle, comuna_cod_comuna, escuela_cod_escuela) VALUES
('DIR02', 'Calle Valparaíso', 567, 'Frente al mar', 2, 'ESC02');
INSERT INTO direccion (cod_direccion, calle, numero, detalle, comuna_cod_comuna, escuela_cod_escuela) VALUES
('DIR03', 'Av. Paicaví', 890, NULL, 3, 'ESC03');
INSERT INTO direccion (cod_direccion, calle, numero, detalle, comuna_cod_comuna, escuela_cod_escuela) VALUES
('DIR04', 'Calle Arturo Prat', 1122, 'Sector centro', 4, 'ESC04');
INSERT INTO direccion (cod_direccion, calle, numero, detalle, comuna_cod_comuna, escuela_cod_escuela) VALUES
('DIR05', 'Av. Angamos', 3344, 'Paradero 5', 5, 'ESC05');
INSERT INTO direccion (cod_direccion, calle, numero, detalle, comuna_cod_comuna, escuela_cod_escuela) VALUES
('DIR06', 'Camino Rural', 10, 'Km 5', 6, 'ESC06');

-- Actualizar escuela con las referencias a direccion
UPDATE escuela SET direccion_cod_direccion = 'DIR01' WHERE cod_escuela = 'ESC01';
UPDATE escuela SET direccion_cod_direccion = 'DIR02' WHERE cod_escuela = 'ESC02';
UPDATE escuela SET direccion_cod_direccion = 'DIR03' WHERE cod_escuela = 'ESC03';
UPDATE escuela SET direccion_cod_direccion = 'DIR04' WHERE cod_escuela = 'ESC04';
UPDATE escuela SET direccion_cod_direccion = 'DIR05' WHERE cod_escuela = 'ESC05';
UPDATE escuela SET direccion_cod_direccion = 'DIR06' WHERE cod_escuela = 'ESC06';

-- AGREGAR REGISTROS A LA TABLA EMPLEADO
INSERT INTO empleado (cod_empleado, rut, nombre, segundo_nombre, apellido, segundo_apellido, telefono, nacionalidad, escuela_cod_escuela) VALUES
('EMP01', '12345678-9', 'Juan', 'Pablo', 'González', 'Soto', 987654321, 'Chilena', 'ESC01');
INSERT INTO empleado (cod_empleado, rut, nombre, segundo_nombre, apellido, segundo_apellido, telefono, nacionalidad, escuela_cod_escuela) VALUES
('EMP02', '23456789-0', 'María', 'José', 'López', 'Pérez', 976543210, 'Chilena', 'ESC02');
INSERT INTO empleado (cod_empleado, rut, nombre, segundo_nombre, apellido, segundo_apellido, telefono, nacionalidad, escuela_cod_escuela) VALUES
('EMP03', '34567890-1', 'Pedro', NULL, 'Martínez', 'Rojas', 965432109, 'Chilena', 'ESC03');
INSERT INTO empleado (cod_empleado, rut, nombre, segundo_nombre, apellido, segundo_apellido, telefono, nacionalidad, escuela_cod_escuela) VALUES
('EMP04', '45678901-2', 'Ana', 'Luisa', 'Fernández', NULL, 954321098, 'Argentina', 'ESC04');
INSERT INTO empleado (cod_empleado, rut, nombre, segundo_nombre, apellido, segundo_apellido, telefono, nacionalidad, escuela_cod_escuela) VALUES
('EMP05', '56789012-3', 'Carlos', 'Andrés', 'Muñoz', 'Vargas', 943210987, 'Chilena', 'ESC05');
INSERT INTO empleado (cod_empleado, rut, nombre, segundo_nombre, apellido, segundo_apellido, telefono, nacionalidad, escuela_cod_escuela) VALUES
('EMP06', '67890123-4', 'Laura', 'Isabel', 'Castro', 'Pinto', 932109876, 'Peruana', 'ESC06');

-- AGREGAR REGISTROS A LA TABLA INSTALACION
INSERT INTO instalacion (cod_instalacion, nombre, tipo, capacidad, estado, escuela_cod_escuela) VALUES
('INS01', 'Gimnasio Principal', 'Gimnacio', 200, 'Bueno', 'ESC01');
INSERT INTO instalacion (cod_instalacion, nombre, tipo, capacidad, estado, escuela_cod_escuela) VALUES
('INS02', 'Nicolás Massu', 'Cancha de Tenis', 300, 'Excelente', 'ESC02');
INSERT INTO instalacion (cod_instalacion, nombre, tipo, capacidad, estado, escuela_cod_escuela) VALUES
('INS03', 'Pega Martín Pega', 'Ring de Boxeo', 300, 'Regular', 'ESC03');
INSERT INTO instalacion (cod_instalacion, nombre, tipo, capacidad, estado, escuela_cod_escuela) VALUES
('INS04', 'Pista de Atletismo', 'Pista', 1200, 'Bueno', 'ESC04');
INSERT INTO instalacion (cod_instalacion, nombre, tipo, capacidad, estado, escuela_cod_escuela) VALUES
('INS05', 'Piscina Olímpica', 'Piscina', 600, 'Bueno', 'ESC05');
INSERT INTO instalacion (cod_instalacion, nombre, tipo, capacidad, estado, escuela_cod_escuela) VALUES
('INS06', 'Sa-Za', 'Cancha de Fútbol',460, 'Regular', 'ESC06');

-- -- AGREGAR REGISTROS A LA TABLA EQUIPAMIENTO
INSERT INTO equipamiento (cod_equip, nombre, tipo, marca, modelo, instalacion_cod_instalacion) VALUES
('EQP01', 'Caballete Piruetas', 'Caballete', 'Nike', 'Pro', 'INS01');
INSERT INTO equipamiento (cod_equip, nombre, tipo, marca, modelo, instalacion_cod_instalacion) VALUES
('EQP02', 'Raqueta de Tenis', 'Raqueta', 'Wilson', 'Blade', 'INS02');
INSERT INTO equipamiento (cod_equip, nombre, tipo, marca, modelo, instalacion_cod_instalacion) VALUES
('EQP03', 'Guantes de Box', 'Guantes', 'Everlast', 'GMRT-12', 'INS03');
INSERT INTO equipamiento (cod_equip, nombre, tipo, marca, modelo, instalacion_cod_instalacion) VALUES
('EQP04', 'Vallas de Atletismo', 'Valla', 'Nordic', 'Pro Hard', 'INS04');
INSERT INTO equipamiento (cod_equip, nombre, tipo, marca, modelo, instalacion_cod_instalacion) VALUES
('EQP05', 'Tabla Nada Principante', 'Tabla', 'Speedo', 'Kickboard', 'INS05');
INSERT INTO equipamiento (cod_equip, nombre, tipo, marca, modelo, instalacion_cod_instalacion) VALUES
('EQP06', 'Malla de Arco', 'Malla', 'Umbro', 'MCX', 'INS06');


-- Volver a establecer la restricción NOT NULL en direccion_cod_direccion si es necesario
ALTER TABLE escuela MODIFY direccion_cod_direccion CHAR(5 BYTE) NOT NULL;






