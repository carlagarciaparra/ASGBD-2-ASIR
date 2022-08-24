#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

iniciar_oracle() {
        lsnrctl start
        ORACLE_SID=asir sqlplus / as sysdba <<EOF
        startup open
EOF
}

apagar_oracle() {
        ORACLE_SID=asir sqlplus / as sysdba <<EOF
        shutdown immediate
EOF
}

oracle_apagado() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep instancia
	select 'instancia'
 	from v$instance | grep 'ORA-01034%';
EOF
}

if oracle_apagado
        then
		echo ¿Desea arrancarlo?
                read respuesta
                if [ "$respuesta" = 'si' ]
                   then
                       	iniciar_oracle
			oracle arrancado
                elif [ "$respuesta" = 'no' ]
                   then
                       	echo No se ha arrancado
                exit 0
		fi
else
		echo ¿Desea apagarlo?
                read respuesta
                if [ "$respuesta" = 'si' ]
                   then
                        apagar_oracle
			echo Oracle apagado
		elif [ "$respuesta" = 'no' ]
   		   then             
          		echo Ha decidido no apagarlo
                exit 0
                fi
fi

