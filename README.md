1. Prerrequisitos:
    - Sistema Operativo Windows 11
    - JDK 17 instalado y JAVA_HOME configurado
    - Apache JMeter 5.6.3 con carpeta bin en PATH

2. Comandos de instalación
    - Instalar Apache JMeter:
        winget install Apache.JMeter

    Alternativa manual:
    - Descargar ZIP binario de JMeter 5.6.x y descomprimir en C:\Tools\jmeter
    - Agregar C:\Tools\jmeter\apache-jmeter-5.6.x\bin al PATH
    - Configurar JAVA_HOME apuntando al JDK (p.ej. C:\Program Files\Eclipse Adoptium\jdk-17)

3. Instrucciones para ejecutar los test

A) Preparación de datos
    - Archivo users.csv con columnas: username,password
    - Ignore first line = True

B) Configuración del Test Plan (JMeter GUI)
    1. Abrir JMeter y cargar login_test.jmx
    2. Thread Group:
        - Number of Threads (users): 20
        - Ramp-Up: 1 s
        - Loop Count: 1000
    3. CSV Data Set Config:
        - Filename: users.csv
        - Variable Names: username,password
        - Delimiter: ,
        - Ignore first line: True
    4. HTTP Request:
        - Protocol: https
        - Server Name: fakestoreapi.com
        - Path: /auth/login
        - Method: POST
        - Body Data:
            {
              "username": "${username}",
              "password": "${password}"
            }
    5. HTTP Header Manager:
        - Content-Type: application/json
    6. Assertions:
        - Response Code: Matches ^(200|201)$ porque la respuesta de la API es 201
        - Duration Assertion: 1500 ms
    7. (Opcional) Constant Throughput Timer: 1200 samples/min
    8. Listeners: Summary Report, Aggregate Report, View Results Tree, Dashboard HTML

C) Ejecución
    - Script run.ps1:
        jmeter -n -t C:\jmeter-loadtest\login_test.jmx -l C:\jmeter-loadtest\results\login_test_summary.jtl -e -o C:\jmeter-loadtest\results


4. Información adicional
    - El endpoint puede devolver 200 o 201 a pesar de que en la documentación indique que solo devuelve 200.
    - Para CSV con cabecera user,passwd usar Ignore first line = True y variables username,password
