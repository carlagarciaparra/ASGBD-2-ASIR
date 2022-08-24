#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

existe_usuario() {
ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep usuario
	select 'usuario'
	from all_users
	where username=upper('prueba_vista');
EOF
}

crear_usuario(){
ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create user prueba_vista identified by alumno;
	grant connect,resource to prueba_vista;
	commit;
EOF
}

borrar_usuario() {
     ORACLE_SID=asir sqlplus / as sysdba <<EOF
	drop user prueba_vista;
     commit;
EOF
echo el usuario prueba_vista ha sido borrado
}

crear_vista() {
     ORACLE_SID=asir sqlplus / as sysdba <<EOF
     create view script_vista as (
	select * 
	from all_tables
	where owner=upper('kk')
     );
     commit;
EOF
}


if existe_usuario
	then
	     crear_vista
	else
	     crear_usuario
	     crear_vista
fi

borrar_usuario
