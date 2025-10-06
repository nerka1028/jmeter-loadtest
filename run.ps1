# run.ps1 
# Requisitos: 'jmeter' en el PATH y el archivo 'login_test.jmx' en C:\jmeter-loadtest

jmeter -n -t "C:\jmeter-loadtest\login_test.jmx" -l "C:\jmeter-loadtest\results\login_test_summary.jtl" -e -o "C:\jmeter-loadtest\results"
# Nota: si el dashboard falla por carpeta no vacía, use:
# jmeter -n -t "C:\jmeter-loadtest\login_test.jmx" -l "C:\jmeter-loadtest\results\login_test_summary.jtl" -e -o "C:\jmeter-loadtest\report"
