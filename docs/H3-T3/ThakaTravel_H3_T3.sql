CREATE TABLE usuario (
    id_usuario INTEGER PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    preferencias TEXT
);

CREATE TABLE destino (
    id_destino INTEGER PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    ciudad VARCHAR(100) NOT NULL,
    categoria VARCHAR(100),
    precio DECIMAL(10,2),
    latitud DECIMAL(10,7),
    longitud DECIMAL(10,7)
);

CREATE TABLE paquete (
    id_paquete INTEGER PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    duracion_dias INTEGER
);
