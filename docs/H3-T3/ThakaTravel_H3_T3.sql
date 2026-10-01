-- ============================================================
-- THAKATRAVEL
-- H3 TAREA 3 - MODELO RELACIONAL Y SENTENCIAS SQL
-- ============================================================

-- ============================================================
-- TABLA: USUARIO
-- ============================================================

CREATE TABLE usuario (
    id_usuario INTEGER PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    preferencias TEXT
);

-- ============================================================
-- TABLA: DESTINO
-- ============================================================

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

-- ============================================================
-- TABLA: PAQUETE
-- ============================================================

CREATE TABLE paquete (
    id_paquete INTEGER PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    duracion_dias INTEGER
);

-- ============================================================
-- TABLA INTERMEDIA: PAQUETE_DESTINO
-- Relación muchos a muchos entre paquete y destino
-- ============================================================

CREATE TABLE paquete_destino (
    id_paquete INTEGER NOT NULL,
    id_destino INTEGER NOT NULL,

    PRIMARY KEY (id_paquete, id_destino),

    FOREIGN KEY (id_paquete)
        REFERENCES paquete(id_paquete),

    FOREIGN KEY (id_destino)
        REFERENCES destino(id_destino)
);

-- ============================================================
-- TABLA: RUTA
-- Una ruta pertenece a un usuario
-- ============================================================

CREATE TABLE ruta (
    id_ruta INTEGER PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha_creacion DATE,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

-- ============================================================
-- TABLA INTERMEDIA: RUTA_DESTINO
-- Relación muchos a muchos entre ruta y destino
-- ============================================================

CREATE TABLE ruta_destino (
    id_ruta INTEGER NOT NULL,
    id_destino INTEGER NOT NULL,
    orden INTEGER NOT NULL,

    PRIMARY KEY (id_ruta, id_destino),

    FOREIGN KEY (id_ruta)
        REFERENCES ruta(id_ruta),

    FOREIGN KEY (id_destino)
        REFERENCES destino(id_destino)
);

-- ============================================================
-- TABLA: RESERVA
-- Relaciona usuarios con paquetes turísticos
-- ============================================================

CREATE TABLE reserva (
    id_reserva INTEGER PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_paquete INTEGER NOT NULL,
    fecha_reserva DATE NOT NULL,
    estado VARCHAR(50) NOT NULL,
    total DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario),

    FOREIGN KEY (id_paquete)
        REFERENCES paquete(id_paquete)
);

-- ============================================================
-- CONSULTA 1
-- ¿Qué destinos de La Paz están registrados?
-- ============================================================

SELECT
    id_destino,
    nombre,
    categoria,
    precio
FROM destino
WHERE ciudad = 'La Paz'
ORDER BY nombre;

-- ============================================================
-- CONSULTA 2
-- ¿Qué reservas tiene cada usuario y qué paquete reservó?
-- ============================================================

SELECT
    u.nombre AS usuario,
    p.nombre AS paquete,
    r.fecha_reserva,
    r.estado,
    r.total
FROM reserva r
INNER JOIN usuario u
    ON r.id_usuario = u.id_usuario
INNER JOIN paquete p
    ON r.id_paquete = p.id_paquete
ORDER BY r.fecha_reserva DESC;
