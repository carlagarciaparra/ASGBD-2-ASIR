#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

permisos_directory() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
	Grant write,read on backups_junio to junio
EOF
}

crear_directory() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create directory backups_junio as '/home/alumno/Desktop/recuperacion/examen_recuperacion/backups';
EOF
}

existe_directory() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep directory
	select 'directory'
	from all_directories
	where directory_name='backups_junio';
EOF
}

hora=$(date '+%H')

exportacion() {
	ORACLE_SID=asir expdp junio/alumno directory=backups_junio dumpfile=backup_$hora.dmp logfile=backup_tablas.log schemas=junio
}



if test -d /home/alumno/Desktop/recuperacion/examen_recuperacion/backups
	then	
	    echo Ya existe el directorio 'backups'
else
	mkdir /home/alumno/Desktop/recuperacion/examen_recuperacion/backups
fi

if existe_directory
	then
		permisos_directory
else 
	crear_directory
	permisos_directory
fi

if test -f /home/alumno/Desktop/recuperacion/examen_recuperacion/backups/backup_$hora.dmp
	then 
	    echo El fichero ya existe
	    exit 1
else 
	exportacion
fi

if [ "$#" -eq 1 ]
	then 
		echo "Copia de seguridad" | mail -a /home/alumno/Desktop/recuperacion/examen_recuperacion/backups/backup_$hora.dmp $1
elif [ "$#" -gt 1 ]
	then
		echo Se han recibido más parámetros de los que se esperaba
		exit 2
fi
