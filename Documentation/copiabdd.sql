CREATE TABLE IF NOT EXISTS usuario_normal(
    idusuario SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    contrasena TEXT NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    fecha_registro DATE NOT NULL,
    telefono TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS usuario_docente(
    idusuariodocente SERIAL PRIMARY KEY,
    nombre_d TEXT NOT NULL,
    apellido_d TEXT NOT NULL,
    correo_d TEXT NOT NULL UNIQUE,
    contrasena_d TEXT NOT NULL, 
    documento_d INT NOT NULL UNIQUE,
    fecha_nacimiento_d DATE NOT NULL,
    fecha_registro_d DATE NOT NULL,
    telefono_d TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS instituciones(
    idinstitucion SERIAL PRIMARY KEY, 
    nombre_institucion TEXT NOT NULL, 
    localidad TEXT NOT NULL,
    provincia TEXT NOT NULL,
    pais TEXT NOT NULL,
    correo_institucion TEXT NOT NULL UNIQUE, 
    telefono_institucion TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS intereses(
    idintereses SERIAL PRIMARY KEY,
    nombre_interes TEXT
);

CREATE TABLE IF NOT EXISTS intereses_usuario(
    usuario_id INT REFERENCES usuario_normal(idusuario) ON DELETE CASCADE,
    interes_id INT REFERENCES intereses(idintereses) ON DELETE CASCADE,
    
    PRIMARY KEY (usuario_id, interes_id)
);

CREATE TABLE IF NOT EXISTS ubicaciones(
    idubicacion SERIAL PRIMARY KEY,
    alias TEXT NOT NULL,
    direccion TEXT NOT NULL,
    latitud DECIMAL(10, 8) NOT NULL,
    longitud DECIMAL(11, 8) NOT NULL    
);

CREATE TABLE IF NOT EXISTS eventos(
    idevento SERIAL PRIMARY KEY,
    institucion_id INT NOT NULL REFERENCES instituciones(idinstitucion) ON DELETE CASCADE,
    ubicacion_id INT NOT NULL REFERENCES ubicaciones(idubicacion) ON DELETE CASCADE,
    titulo TEXT NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL,
    categoria INT REFERENCES intereses(idintereses) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS archivos_eventos(
    idarchivo SERIAL PRIMARY KEY,
    evento_id INT NOT NULL REFERENCES eventos(idevento) ON DELETE CASCADE,
    alias_archivo TEXT NOT NULL,
    ruta_url TEXT NOT NULL,
    tipo_archivo TEXT,
    fecha_subida TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS notas_evento(
    idnota SERIAL PRIMARY KEY,
    evento_n_id INT REFERENCES eventos(idevento) ON DELETE CASCADE,
    contenido_nota TEXT NOT NULL,
    fecha_creacion TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS tareas_eventos(
    idtarea SERIAL PRIMARY KEY,
    usuario_t_id INT REFERENCES usuario_normal(idusuario) ON DELETE SET NULL,
    usuariod_t_id INT REFERENCES usuario_docente(idusuariodocente) ON DELETE SET NULL,
    evento_t_id INT NOT NULL REFERENCES eventos(idevento) ON DELETE CASCADE,
    titulo_tarea TEXT NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_limite DATE
);