#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

funcion() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep fun
	select 'fun'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='FUNCTION';
EOF
}

procedimiento() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep proc
	select 'proc'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='PROCEDURE';
EOF
}

vista() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep vis
	select 'vis'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='VIEW';
EOF
}

trigger() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep tri
	select 'tri'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='TRIGGER';
EOF
}

tabla() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep tab
	select 'tab'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='TABLE';
EOF
}


if funcion $1 $2
	then 
	    echo El objeto $1.$2 existe y es una funcion

elif procedimiento $1 $2
	then
	    echo El objeto $1.$2 existe y es un procedimiento 

elif vista $1 $2
	then
 	    echo El objeto $1.$2 existe y es una vista

elif trigger $1 $2
	then
	    echo El objeto $1.$2 existe y es un trigger

elif tabla $1 $2
	then
	    echo El objeto $1.$2 existe y es una tabla

else
	    echo El objeto $1.$2 no existe
fi
