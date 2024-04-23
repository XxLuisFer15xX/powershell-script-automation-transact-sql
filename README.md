# Automatización de Scripts SQL SERVER

## Descripción del Proyecto

El proyecto tiene como finalidad proporcionar un ejemplo básico para la ejecución scripts de SQL SERVER de forma automática y seguro. SQL SERVER ya proporciona una forma de ejecutar otros archivos ".sql" a través de un solo script con solo habilitar la opción "SQLCMD Mode" que se encuentra en la pestaña "Query" de la herramienta "SQL Server Management Studio". Pero esta opción tiene un problema principal y es que, no reconoce la ruta de donde fue ejecutado el script, de modo que hay que especificar la ruta absoluta en cada uno de los archivos .sql que se quieran ejecutar.

Para ello, existe una alternativa mucho más robusta para poder ejecutar archivos SQL y es con la combinación de un script en SQLCMD Mode y un script de Power Shell. Desde el script de Power Shell si se puede conocer la ruta en la cuál fue ejecutado dicho archivo. Por lo que el proceso de ejecutar múltiples archivos .sql se vuelve automático. El comando utilizado para la ejecución de estos scripts es:

```
sqlcmd -S $DJOET_DB_SERVER_NAME -U $DJOET_DB_USERNAME -P $DJOET_DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DJOET_DB_DATABASE_NAME -i $PATH_CREATE_DDL -b -f 65001
```

Sin duda alguna, este método ahorra bastante tiempo en la ejecución de arhcivos ".sql" de forma automática, más si existen muchas tablas, registros, funciones o procedimientos almacenados. Pero, no es el único beneficio, también con la ejecución automática de scripts, se pueden definir variables de entorno para que los scripts apunten a diferentes ambientes de desarrollo, se pueden agregar tantos como sean necesarios.

Otra ventaja es que ahora se puede simular un versionamiento de los scripts, con el control de versiones de GIT. La efectividad de este versionamiento no siempre será efectivo, ya que al crear, eliminar o modificar estructuras específicas de la base de datos, no se hará la ejecución o reversión 100% satisfactoria. Siempre se necesitará de elaborar unos scripts especiales para actualizar los objetos de base de datos.

## Creación de Base de Datos y Usuario

### Creación de la base de datos

1. Abrir el programa SQL Server Management Studio.
2. Clic derecho en la carpeta Database y en la opción "Nueva base de datos".
3. Especificar un nombre para la base de datos por ejemplo "EXAMPLE".
4. Clic en Ok.

### Creación del usuario de base de datos

1. Ir a la carpeta Security > Logins.
2. Clic derecho en la opción "Nuevo Login".
3. En la página "General", definir el nombre del usuario.
4. Escoger la opción SQL Server authentication e ingresar una contraseña.
5. Habilitar solamente la opción "Enforce password policy".
6. Seleccionar una base de datos por defecto, en este caso sería la base de datos recientemente creada.
7. Definir un idioma de base de datos, de preferencia inglés.
8. Ir a la página "Server Roles".
9. Marcar los roles: "public" y "securityadmin".
10. Ir a la página "User Mapping".
11. Marcar la base de datos recientemente creada.
12. Marcar los roles: "db_datareader", "db_datawriter", "db_ddladmin", "db_owner" y "public".
13. Ir a la página "Status".
14. Marcar la opción "Grant" para permisos.
15. Marcar la opción "Enabled" para Login.

## Código Fuente

### Estructura de archivos

1. **scripts**
    - **ddl:** Scripts para gestionar los DDLs.
    - **dml:** Scripts para gestionar los DMLs.
    - **functions:** Scripts para gestionar las funciones.
    - **sp:** Scripts para gestionar las procedimientos almacenados.
2. **src**
    - **DDLs:** Scripts para create, alter y drop tables.
    - **DMLs:** Scripts para insert y delete tables.
    - **functions:** Scripts para funciones.
    - **model:** Modelo relacional de la base de datos
    - **sp:** Scripts para procedimientos almacenados.
    - **triggers:** Scripts para triggers.
    - **views:** Scripts para vistas.
3. **tests**
    - **functions:** Scripts para probar funciones.
    - **sp:** Scripts para probar procedimientos almacenados.
4. **.editorconfig:** Archivo para la configuración de indentación de los archivos.
5. **.env:** Archivo que contiene las variables de entorno LOCAL del proyecto.
6. **.env.dev:** Archivo que contiene las variables de entorno de DESARROLLO del proyecto.
7. **.env.example:** Archivo que contiene un ejemplo de las variables de entorno del proyecto.
8. **.env.prod:** Archivo que contiene las variables de entorno de PROD del proyecto.
9. **.env.qa:** Archivo que contiene las variables de entorno de QA del proyecto.
10. **.gitignore:** Archivo donde se describen los archivos que serán ignorados por git.
11. **master_script.ps1:** Escript maestro que gestiona la ejecución de scripts SQL.
12. **README.md:** Archivo que contiene la información general del proyecto.

### Ejecutar el Script Maestro

1. Abrir la Power Shell de Windows en la raíz del proyecto.
2. Ejecutar el siguiente comando `Set-ExecutionPolicy Unrestricted` solo UNA VEZ, para autorizar la ejecución de scripts de Power Shell.
3. Ejecutar el siguiente comando `Install-Module -Name SqlServer -AllowClobber` solo UNA VEZ y presione la tecla A para aceptar todo. Este comando descargará e instalará los módulos de SqlServer.
4. Ejecutar el siguiente comando `.\master_script.ps1` para correr el script maestro que ejecuta todos los scripts SQL.
