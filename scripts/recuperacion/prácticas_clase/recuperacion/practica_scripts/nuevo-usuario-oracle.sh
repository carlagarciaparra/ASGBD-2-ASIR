#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/hom$ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID


comprobar_usuario(){
	ORACLE_SID=asir sqlplus / as sysdba << EOF | grep usuario
	select 'usuario' 
	from all_users
	where username=upper('$1');
EOF
}

crear_usuario(){
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create user $1 identified by $2;
	grant connect, resource to $1;
EOF
}

cambiar_contrasena(){
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
	alter user $1 account unlock;
	alter user $1 identified by $2;
EOF
}


if [ -z "$1" ] || [ -z "$2" ]
then
	echo
	echo "Crea un usuario nuevo de oracle, con permisos connect y resource."
        echo "Si el usuario ya existe, lo desbloquea y le cambia la contraseña."
	echo "Uso: nuevo-usuario-oracle.sh <usuario> <contraseña>"
	echo

elif ( comprobar_usuario $1 )
then 
	cambiar_contrasena "$1" "$2"
	echo "La contraseña se ha cambiado correctamente"
else
	crear_usuario "$1" "$2"
	echo "El usuario se ha creado correctamente"
fi

