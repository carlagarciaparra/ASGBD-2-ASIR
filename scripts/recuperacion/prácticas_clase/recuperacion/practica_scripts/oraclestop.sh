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

	echo $fechahora - Solicitud de parar Oracle >> /home/alumno/logs/oracle.log

		ORACLE_SID=asir sqlplus / as sysdba <<EOF
		shutdown immediate
EOF

	echo $fechahora - Oracle parado >> /home/alumno/logs/oracle.log
