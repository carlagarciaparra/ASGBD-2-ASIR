#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
ORACLE_SID=asir
PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_HOME
export PATH
export ORACLE_SID

comprobar_directorio() {
		ORACLE_SID=asir sqlplus KK/KK <<EOF | grep existedirectorio
		select 'existedirectorio' from all_directories where DIRECTORY_NAME=upper('backupKK');
EOF
		       }
crear_directorio() {
		ORACLE_SID=asir sqlplus KK/KK <<EOF 
		create directory backupKK as '/home/alumno/examen/backups';
EOF
		   }
hora=$(date '+%H%M')
usuario=usuario$hora
crear_usuario() {
		ORACLE_SID=asir sqlplus / as sysdba <<EOF
		create user $usuario identified by $usuario;
		grant connect, resource to $usuario;
EOF
}
exportacion() {
ORACLE_SID=asir expdp KK/KK directory=backupKK dumpfile=backup$hora.dmp schemas=KK
}

importacion() {
ORACLE_SID=asir impdp KK/KK directory=backupKK dumpfile=backup$hora.dmp schemas=KK remap_schema=examen:$usuario table_exists_action=replace
}

if (comprobar_directorio)
then
	error_level=0	
else	
	crear_directorio
	error_level=1
fi

crear_usuario
exportacion
importacion



#if [ $error_level -eq 1 ]
#then
#        exit 1;
#fi 
