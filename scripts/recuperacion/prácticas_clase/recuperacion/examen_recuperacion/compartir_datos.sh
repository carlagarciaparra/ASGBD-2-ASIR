#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID


if [ "$#" != "1" ]
	then
		echo se necesita unicamente un parámetro
	        exit 2
fi

read -sp "introduzca una contraseña:" contrasena
 

crear_usuario(){
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create user ignacio_$1 identified by $contrasena;
EOF
}

existe_usuario() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep existeusuario
	select 'existeusuario'
	from all_users
	where username=upper('ignacio_$1');
EOF
}

rol() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create role privilegios;
	grant connect to privilegios;
	grant resource to privilegios;
	grant select on copia_25_05.detalles to privilegios;
	grant update(datos) on copia_25_05.detalles to privilegios;
EOF
}

dar_rol() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
	grant privilegios to ignacio_$1;
EOF
}

existe_rol() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep existerol
	select 'existerol'
	from dba_roles
	where role=upper('privilegios');
EOF
}

if existe_rol
	then 
	    echo el rol ya existe
else
	rol
fi


if existe_usuario $1
	then
	     echo El usuario que intenta crear ya existe
	     exit 1
else
	crear_usuario $1
	dar_rol $1
fi

