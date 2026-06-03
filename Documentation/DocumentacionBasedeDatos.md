# 📄 Documentación de la Base de Datos

En esta documentación se explica la utilidad de las tablas y campos de la base de datos.

La base de datos en lenguaje SQL (formato PostgreSQL) está presente únicamente para las migraciones procedentes del schema.prisma que es la parte plenamente funcional de la base de dato, está documentación toma de base el lenguaje SQL, sin embargo, al tener ambos archivos los mismos campos, tablas (en Prisma "modelos") y relaciones este documento sirve para ambos archivos por igual.

⚠️ **IMPORTANTE:** Tanto para el archivo .sql como para el esquema de Prisma POR FAVOR no modificar sin avisar ni ser autorizado previamente por los miembros de Infra (Gabi y Lucas), quienes también se encargaran de mergear cualquier modificación a las mismas, o rechazar el merge si es necesario.

---

## 🛠️ Tipos de Datos Utilizados

A continuación se especifican los tipos de datos y propiedades utilizadas para los campos de la base de datos. Recordar que lo especificado en esta sección coincide con ambos archivos (Prisma y SQL):

* **`SERIAL`**: Formato propio de PostgreSQL y necesario en las PK (Primary Key). Se trata de un campo numerico unico (en su tabla), autoincremental (= AUTOINCREMENT) y sin posibilidad de ser nulo (=NOT NULL).
* **`TEXT`**: Una cadena de caracteres sin límite (en la practica).
* **`INT`**: Número entero.
* **`UNIQUE`**: Campo único, el dato en su interior no se puede repetir en la misma tabla.
* **`DATE`**: Fecha escrita en formato YYYY-MM-DD.
* **`REFERENCES`**: Una FK (Foreign Key), que cuenta con dos propiedades usadas en la base de datos:
  * `ON DELETE CASCADE`: De borrarse el campo en el que se origina la FK, se borra también el campo al que esta llega.
  * `ON DELETE SET NULL`: De borrarse el campo del que sale la FK, el campo al que esta llega se setea en NULL.
* **`DECIMAL`**: Número decimal. Los números en paréntesis (p,s) son:
  * `p` (Precisión): Cantidad de dígitos del numero entero.
  * `s` (Escala): Cantidad de dígitos obligatorios para decimales.
* **`TIMESTAMPTZ`**: Fecha escrita en formato YYYY-MM-DD HH:MM:SS, el TZ le añado el huso horario del usuario al que el dato corresponde.

---

## 🗃️ Tablas y Campos

A continuación se especifica la utilidad/fin de cada una de las tablas de la base de datos y sus campos respectivos. Al nombrar un campo o una tabla, se escribirá como se ve en SQL con su equivalente en Prisma entre paréntesis, ej: Tabla "usuario_normal (UsuarioNormal)".

### 1. `usuario_normal (UsuarioNormal)`
Tabla que almacena los datos de los usuarios no institucionales o de alumnos de instituciones, con los siguientes campos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `idusuario` | `idusuario` | PK |
| `nombre` | `nombre` | Nombre de pila del usuario |
| `apellido` | `apellido` | Apellido de pila del usuario |
| `correo` | `correo` | Correo electrónico (único) del usuario |
| `contrasena` | `contrasena` | Contraseña del usuario, idealmente cifrada |
| `fecha_nacimiento` | `fechaNacimiento` | Fecha (en formato DATE) de nacimiento del usuario |
| `fecha_registro` | `fechaRegistro` | Fecha (en formato DATE) en la que el usuario se registró en la aplicación |
| `telefono` | `telefono` | Número de teléfono móvil (único) del usuario |

---

### 2. `usuario_docente (UsuarioDocente)`
Tabla que almacena los datos de los usuarios pertenecientes a docentes de instituciones registradas, con los siguientes campos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `idusuariodocente` | `idusuariodocente` | PK |
| `nombre_d` | `nombreD` | Nombre de pila del docente |
| `apellido_d` | `apellidoD` | Apellido de pila del docente |
| `correo_d` | `correoD` | Correo electrónico (único) del docente |
| `constrasena_d` | `contrasenaD` | Contraseña del docente, idealmente cifrada |
| `documento_d` | `documentoD` | Número correspondiente al Documento Nacional de Identidad (DNI) del docente |
| `fecha_nacimiento_d` | `fechaNacimientoD` | Fecha (en formato DATE) de nacimiento del docente |
| `fecha_registro_d` | `fechaRegistroD` | Fecha (en formato DATE) en la que el docente se registró en la aplicación |
| `telefono_d` | `telefonoD` | Número de teléfono móvil (único) del docente |

---

### 3. `instituciones (Instituciones)`
Tabla que almacena los datos de las instituciones registradas en la aplicación (cabe aclarar que un docente puede enseñar en mas de una institución a la vez (de hecho en Argentina es común), por lo tanto, la pertenencia a una institución no se usará como método de verificación a cuentas docentes), con los siguientes campos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `idinstitucion` | `idinstitucion` | PK |
| `nombre_institucion` | `nombreInstitucion` | Nombre de la institución (Ver formatos abajo) |
| `localidad` | `localidad` | En caso de estar en CABA, comuna (ej: "Comuna 13"), en caso de estar en una provincia, el departamento, partido o municipio donde se encuentra el establecimiento educativo (ej: "Partido de Vicente López", "Departamento Tolhuin") |
| `provincia` | `provincia` | Provincia donde se encuentra el establecimiento educativo (ej: "Provincia de Tierra del Fuego, Antártida e Islas del Atlántico Sur") |
| `correo_institucion` | `correoInstitucion` | Correo institucional único |
| `telefono_institucion` | `telefonoInstitucion` | Número de teléfono fijo o móvil de la institución. No se usará como forma de verificación o comunicación |

#### 📌 Formato exigido deseable para `nombre_institucion`:
* **En escuelas públicas/estatales:** `"Escuela [especialización, ej: "Técnica, Común"] [Número de colegio, ej "Nª6"] [Distrito escolar, ej "D.E. 10"] [Alias, ej "Otto Krause"]"`
* **En escuelas de gestión privada:** `"Escuela/Colegio [Alias, ej "Ceferino Namuncura"]"`

---

### 4. `intereses (Intereses)`
Al registrarse, se va a pedir al usuario que marque sus áreas de interés para el sistema de recomendación de eventos, esta tabla almacena los intereses que puede elegir el usuario y que pueden ser usados de categorías en eventos, y tiene los siguientes campos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `idintereses` | `idintereses` | PK |
| `nombre_interes` | `nombreInteres` | Nombre/alias del posible área de interés |

---

### 5. `intereses_usuario (InteresesUsuario)`
Tabla que almacena las áreas de interés de cada usuario en especifico, y que cuenta con los siguientes campos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `usuario_id` | `usuarioId` | FK con referencia a usuario_normal(idusuario) |
| `interes_id` | `interesId` | FK con referencia a intereses(idintereses) |

🛑 **OJO:** La PK de esta tabla es compuesta entre los dos campos que la conforman `"PRIMARY KEY()"`, para que de esta forma un usuario pueda tener múltiples intereses.

---

### 6. `ubicaciones (Ubicaciones)`
Tabla que almacena las ubicaciones de los eventos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `idubicacion` | `idubicacion` | PK |
| `alias` | `alias` | Alias o nombre necesario para identificar la ubicación (ej: "Vedia y Tronador, CABA", "Facultad de Ingenieria de la UBA") |
| `direccion` | `direccion` | Dirección de la ubicacion compuesta por calle y número/altura |
| `latitud` | `latitud` | Primera parte de la coordenada de la ubicación, indica que tan al norte o al sur está la ubicación del Ecuador |
| `longitud` | `longitud` | Segunda parte de las coordenadas, indica que tan al oeste o al este está la ubicación del Meridiano de Greenwich |

---

### 7. `eventos (Eventos)`
Tabla que almacena información de los eventos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `idevento` | `idevento` | PK |
| `instiucion_id` | `institucionID` | FK con referencia a instituciones(idinstitucion) |
| `ubicacion_id` | `ubicacionID` | FK con referencia a ubicaciones(idubicacion) |
| `titulo` | `titulo` | Título del evento |
| `descripcion` | `descripcion` | Descripción del evento |
| `fecha_inicio` | `fechaInicio` | Fecha (con formato TIMESTAMPTZ) de comienzo del evento |
| `fecha_final` | `fechaFinal` | Fecha (con formato TIMESTAMPTZ) de finalización del evento |
| `categoria` | `categoriaId` | FK con referencia a intereses(idintereses) |

---

### 8. `archivos_eventos (ArchivosEventos)`
Tabla que almacena datos de los archivos relacionados a eventos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `idarchivo` | `idarchivo` | PK |
| `evento_id` | `eventoId` | FK con referencia a eventos(idevento) |
| `alias_archivo` | `aliasArchivo` | Alías o nombre para reconocer facilmente al archivo |
| `ruta_url` | `rutaUrl` | Enlace a la nube donde está almacenado el archivo |
| `tipo_archivo` | `tipoArchivo` | Tipo de archivo (ej: .rar, .pdf) |
| `fecha_subida` | `fechaSubida` | Fecha (en formato TIMESTAMPTZ) que indica cuando se cargó el archivo |

---

### 9. `notas_evento (NotasEvento)`
Tabla que almacena notas o descripciones relativas a eventos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `idnota` | `idnota` | PK |
| `evento_n_id` | `eventoNId` | FK con referencia a eventos(idevento) |
| `contenido_nota` | `contenidoNota` | Contenido de la nota |
| `fecha_creacion` | `fechaCreacion` | Fecha (con formato TIMESTAMPTZ) que indica cuando se creo la nota |

---

### 10. `tareas_eventos (TareasEventos)`
Tabla que almacena información de las tareas en las que se organizan los eventos:

| Campo SQL | Campo Prisma | Descripción |
| :--- | :--- | :--- |
| `idtarea` | - | PK |
| `usuario_t_id` | `usuarioTId` | FK con referencia a usuario_normal(idusuario). Persona que creó la tarea |
| `usuariod_t_id` | `usuariodTId` | FK con referencia a usuario_docente(idusuariodocente). Docente que creó la tarea |
| `evento_t_id` | `eventoTId` | FK con referencia eventos(idevento) |
| `titulo_tarea` | `tituloTarea` | Título de la tarea |
| `descripcion` | `descripcion` | Descripción de la tarea |
| `fecha_limite` | `fechaLimite` | Fecha (en formato DATE) que indica la fecha límite para realizar la tarea |

---

## 🚀 Cosas a implementar cuando el proyecto avance:

* Uso de formato ENUM para desplegar opciones en menús.
* Adaptación a los requerimientos deseables, que por ahora fueron salteados.