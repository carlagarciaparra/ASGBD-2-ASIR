#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

comprobacion_Y() {
	grep ^asir: /etc/oratab | grep Y$	
}

fechahora=$(date '+%Y-%m-%d %H:%M:%S')

if (comprobacion_Y)
  then 
	echo $fechahora - Solicitud de arrancar Oracle >> /home/alumno/logs/oracle.log
	echo $fechahora - Oracle arrancando porque /etc/oratab indica Y >> /home/alumno/logs/oracle.log

		lsnrctl start
		ORACLE_SID=asir sqlplus / as sysdba <<EOF
		startup open
EOF

	echo $fechahora - Oracle arrancado >> /home/alumno/logs/oracle.log
else 
	echo No se puede arrancar porque oratab indica un N >> /home/alumno/logs/oracle.log
fi
