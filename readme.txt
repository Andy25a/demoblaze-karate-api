EJERCICIO 2 - PRUEBAS API SIGNUP/LOGIN EN DEMOBLAZE (KARATE)
=============================================================

1. Descripción general
----------------------
Este proyecto implementa pruebas automatizadas de servicios REST sobre Demoblaze:
- Signup: https://api.demoblaze.com/signup
- Login:  https://api.demoblaze.com/login

La solución se desarrolló con Karate y JUnit 5, cubriendo los casos solicitados en la consigna y generando evidencia reproducible
mediante reportes HTML/JSON y logs de ejecución.

2. Objetivo y alcance funcional automatizado
--------------------------------------------
Verificar de forma automatizada que los servicios de signup y login de Demoblaze funcionen correctamente y dejar evidencia
reproducible de la ejecución para revisión técnica.

El feature automatizado cubre los casos obligatorios de la consigna:
1) Creación de usuario nuevo en /signup y validación de respuesta exitosa.
2) Reintento de creación del mismo usuario y validación de mensaje de duplicado.
3) Registro de usuario para login válido y validación de token en /login.
4) Registro de usuario para login inválido y validación de mensaje de error en /login.

3. Stack tecnológico
--------------------
- Java 11
- Maven (con Maven Wrapper incluido)
- Karate
- JUnit Platform (JUnit 5)

4. Estructura del proyecto
--------------------------
Ruta base: Carpeta raíz del proyecto (donde están pom.xml y mvnw.cmd).
Ejemplo en Windows: C:\Users\andii\demoblaze-karate-api

Estructura principal:
- pom.xml: dependencias y configuración de build.
- src/test/resources/karate/demoblaze_auth.feature: escenarios de prueba API.
- src/test/java/com/andii/demoblaze/api/DemoblazeApiKarateSuite.java: runner principal.
- run.ps1 / run.cmd: flujo de ejecución recomendado (pruebas + copia de reportes + log).
- readme.txt: instrucciones del ejercicio.
- conclusiones.txt: hallazgos y conclusiones.
- reports/karate: reportes de ejecución para revisión.
- reports/execution-logs: logs de corrida.

5. Datos de prueba utilizados
-----------------------------
Variables usadas en ejecución:
- username: generado dinámicamente con UUID en cada escenario.
- validPassword: DemoPwd#2026
- invalidPassword: WrongPwd#2026

Nota:
El uso de username dinámico evita colisiones por persistencia de usuarios en la API y permite reproducibilidad entre ejecuciones.

6. Pre-requisitos
-----------------
- Sistema operativo Windows con PowerShell (para run.ps1 / run.cmd).
- Java JDK 11 o superior instalado y disponible en PATH.
- Conexión a internet.

Importante:
No es obligatorio tener Maven instalado globalmente, porque el proyecto incluye Maven Wrapper (mvnw.cmd).
Karate se resuelve automáticamente como dependencia de Maven durante la ejecución.

7. Cómo ejecutar el proyecto
----------------------------
Tenemos dos opciones para ejecutar la misma automatización. Use solo una.

--- Opción 1: usar run.cmd

Pasos si quiere usar doble clic:
Paso 1: Abra el Explorador de archivos de Windows.
Paso 2: Entre en la carpeta del proyecto (donde están pom.xml y run.cmd).
Paso 3: Haga doble clic en run.cmd.
Paso 4: Espere a que termine la ejecución.

Pasos si prefiere terminal (CMD o PowerShell):
Paso 1: Abra CMD o PowerShell.
Paso 2: Vaya a la carpeta del proyecto.
Paso 3: Ejecute: run.cmd
Paso 4: Espere a que termine el proceso.

--- Opción 2: comando directo de PowerShell

Paso 1: Abra PowerShell.
Paso 2: Vaya a la carpeta del proyecto.
Paso 3: Ejecute:
powershell -ExecutionPolicy Bypass -File .\run.ps1
Paso 4: Espere a que termine la ejecución.

Parámetro opcional:
- -SkipOpenReport (no abre el reporte HTML al terminar).

Ejemplo:
- powershell -ExecutionPolicy Bypass -File .\run.ps1 -SkipOpenReport

8. Ejecución alternativa (solo Maven)
-------------------------------------
Esta opción ejecuta la suite directamente, sin usar run.ps1/run.cmd.

Comando:
.\mvnw.cmd clean test -Dtest=DemoblazeApiKarateSuite

Resultado:
- Ejecuta 4 escenarios del feature.
- Genera reportes en target\karate-reports.
- No copia reportes a reports\karate (esa copia la realiza run.ps1).

9. Entregables del repositorio
-------------------------------
Esta sección enumera lo que se entrega junto con el proyecto:
- Código fuente de automatización API.
- Scripts de ejecución.
- Reportes de resultados.
- Instrucciones de ejecución (readme.txt).
- Hallazgos y conclusiones (conclusiones.txt).

10. Verificación posterior a la ejecución
-----------------------------------------
Al finalizar la ejecución, validar lo siguiente:
1) La ejecución termina sin errores (BUILD SUCCESS y 0 errores en pruebas).
2) Existe el reporte HTML en reports\karate\karate-summary.html.
3) Existe el detalle por feature en reports\karate\karate.demoblaze_auth.html.
4) Se genera un log en reports\execution-logs\run-YYYYMMDD-HHMMSS.log.

11. Consideraciones técnicas
----------------------------
- La API de Demoblaze devuelve errores funcionales en el body, incluso con estado HTTP 200.
- Por ello se valida tanto status como estructura/contenido de respuesta.
- Los escenarios son independientes y autocontenidos para evitar dependencia entre casos.

12. Resultado esperado
----------------------
La ejecución final debe completar satisfactoriamente:
- 4 pruebas ejecutadas.
- 0 fallos.
- 0 errores.
- Reportes Karate disponibles para revisión técnica y evidencia de entrega.

