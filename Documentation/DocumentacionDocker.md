# 🐳 Documentación Docker Compose — Meetia
 
> Esta documentación contiene el protocolo de uso del Docker Compose del proyecto.
> Es **obligatorio** que todos tengan el compose corriendo en sus computadoras.
 
---
 
## ¿Qué es Docker?
 
Docker es una plataforma que permite empaquetar una aplicación con sus dependencias en **contenedores** (containers), los cuales en conjunto conforman un **compose** (Docker Compose).
 
Esto garantiza que todos tengamos exactamente las mismas dependencias y que la aplicación se ejecute de manera uniforme en todas las computadoras — en criollo, para que no pase el _"en mi compu no funciona"_.
 
---
 
## Requisitos previos
 
Antes de comenzar, asegurarse de tener:
 
1. **Docker instalado** según el sistema operativo:
   - **Linux** → instalar Docker
   - **Windows** → instalar Docker Desktop, que automáticamente instala Docker Engine y WSL (Subsistema de Windows para Linux)
2. **Todos los repositorios clonados y actualizados:**
   - `frontend`
   - `backend`
   - `infraestructura`
3. **Al menos 3GB libres en disco** donde se corra el programa. El no tener espacio suficiente causará que no se puedan levantar los contenedores.
---
 
## Protocolo de uso
 
### 1. Verificar archivos actualizados
 
Verificar tener los siguientes archivos actualizados:
- `Dockerfile` del repositorio de backend
- `Dockerfile` del repositorio de frontend
- `docker-compose.yml` del repositorio de infraestructura
> ⚠️ **No modificar bajo ninguna circunstancia ninguno de estos archivos.** En caso de necesitar cambios, notificar a **Lucas**.
 
---
 
### 2. Posicionarse en el repositorio de Infra
 
Abrir en VS Code la carpeta que contenga los 3 repositorios (importante abrirlos en la misma ventana), o abrir la terminal en Docker Desktop y escribir:
 
```bash
cd [ruta repositorio Infra]
```
 
---
 
### 3. Levantar el compose
 
```bash
docker compose up --build
```
 
Esperar a que finalice la construcción — puede tardar algunos minutos. Al terminar, se verá en la terminal que las imágenes y contenedores han sido creados. En Docker Desktop aparecerá con una luz verde si está corriendo correctamente.
 
---
 
### 4. Verificar que los contenedores están funcionando
 
```bash
docker compose ps
```
 
En la columna `STATUS` debería aparecer `Up` junto con el tiempo que lleva corriendo cada contenedor.
 
---
 
### 5. Limpiar caché de build (cuando sea necesario)
 
```bash
docker system prune -a --volumes
```
 
Seleccionar `y` cuando lo solicite.
 
---
 
## Información útil
 
| Detalle | Valor |
|---------|-------|
| Nombre del compose | `meetia` |
| Contenedor frontend | `frontend-1` |
| Contenedor backend | `backend-1` |
 
- Haciendo `Ctrl + Click` en el número de puerto de un contenedor en Docker Desktop, serán redirigidos al servicio correspondiente. En el caso de `frontend-1`, verán la interfaz de la aplicación.
- Por ahora todo funciona de forma **local**. Cuando se use un dominio y se expanda la aplicación, todo esto se modificará y será debidamente notificado.
---
 
> 💬 Cualquier duda consultar a **Lucas**.