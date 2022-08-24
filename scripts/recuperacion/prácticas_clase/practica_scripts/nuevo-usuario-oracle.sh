#!/bin/bash
variables(){
  ORACLE_SID=ASIR
  PATH=$PATH:$ORACLE_HOME/bin
  export PATH
  export ORACLE_HOME
  export ORACLE_SID
}

#LLAMAMOS A LA FUNCIÓN DE LAS VARIABLES
variables

comprobar_usuario(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF |grep existeusuario
  select 'existeusuario' from all_users where username=upper('$1');
EOF
}

crear_usuario(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF
  create user $1 identified by $2;
  grant connect, resource to $1;
EOF
}

cambio_contra(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF
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
  cambio_contra "$1" "$2"
  echo "La contraseña se ha cambiado"
else
  crear_usuario "$1" "$2"
  echo "El usuario se ha creado"
fi