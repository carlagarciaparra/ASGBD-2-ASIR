#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID


ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create or replace view TABLAS_DE_USUARIOS(tabla,usuario,tablespace) as (
		select table_name,owner,tablespace_name 
        	from all_tables
	);
EOF



