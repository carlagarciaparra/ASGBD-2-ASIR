#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

existe_directorio() {
ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep directorio
	select 'directorio'
	from all_directories
	where directory_name=upper('exp_imp');
EOF
}

crear_directorio(){
ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create directory exp_imp as '/home/alumno/Desktop/recuperacion/carpeta_exp_imp';
	commit;
EOF
}

fecha=$(date '+%d_%m')

crear_usuario() {
ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create user copia_$fecha identified by alumno;
	commit;
	grant connect,resource to copia_$fecha
	grant datapump_exp_full_database to copia_$fecha
	grant datapump_imp_full_database to copia_$fecha
EOF
}

exportacion() {
     ORACLE_SID=asir expdp junio/alumno directory=exp_imp dumpfile=exportacion.dmp logfile=exportacion.log tables=meter_datos 
}

importacion() {
     ORACLE_SID=asir impdp junio/alumno directory=exp_imp dumpfile=exportacion.dmp logfile=importacion.log remap_schema=junio:copia_$fecha remap_table=meter_datos:detalles 
}


if existe_directorio
	then
		crear_usuario
		exportacion
		importacion 
	else
  		crear_directorio
		crear_usuario
		exportacion
		importacion 
		 
fi

