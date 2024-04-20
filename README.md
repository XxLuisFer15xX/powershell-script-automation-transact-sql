# Base de Datos DJOET

## Estructura de archivos

1. **scripts**
    - **always_encrypted:** Scripts para gestionar las llaves de Always Encrypted.
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
5. **.env:** Archivo que contiene las variables de entorno del proyecto.
6. **.env.example:** Archivo que contiene un ejemplo de las variables de entorno del proyecto.
7. **.gitignore:** Archivo donde se describen los archivos que serán ignorados por git.
8. **master_script.ps1:** Escript maestro que gestiona la ejecución de scripts SQL.
9. **README.md:** Archivo que contiene la información general del proyecto.

## Consideraciones

1. Al momento de conectarse se debe de activar Always Encription.
2. En parámetros adicionales colocar: `Column Encryption Setting = Enabled`

## Run The Master Script

1. Abrir la Power Shell de Windows en la raíz del proyecto.
2. Ejecutar el siguiente comando `Set-ExecutionPolicy Unrestricted` solo UNA VEZ, para autorizar la ejecución de scripts de Power Shell.
3. Ejecutar el siguiente comando `Install-Module -Name SqlServer -AllowClobber` solo UNA VEZ y presione la tecla A para aceptar todo. Este comando descargará e instalará los módulos de SqlServer.
4. Ejecutar el siguiente comando `Install-Module -Name Az -AllowClobber` solo UNA VEZ y presione la tecla A para aceptar todo. Este comando descargará e instalará los módulos de Azure.
5. Ejecutar el siguiente comando `.\master_script.ps1` para correr el script maestro que ejecuta todos los scripts SQL.
