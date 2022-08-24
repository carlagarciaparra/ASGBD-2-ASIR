#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID


ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create or replace view FICHEROS_Y_TABLESPACES(fichero,tablespace) as (
		select file_name, tablespace_name
        	from dba_data_files
	);
EOF

#ORACLE_SID=asir sqlplus / as sysdba <<EOF
#	create or replace view FICHEROS_PARA_BACKUP(fichero,tipo) as (
#		select file_name as datos from dba_data_files
#		union
#		select file_name as temporal from dba_temp_files 
#	);
#EOF



