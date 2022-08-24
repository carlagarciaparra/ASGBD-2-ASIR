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

#la supervariable $# explica el numero de argumentos que se pasan al script
if [ "$#" != "1" ]
	then
	echo Se necesita solamente un parámetro
	exit 2
fi

read -sp "Introduce una contraseña" contra

crear_usuario(){
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF
	create user carla_$1 identified by $contra;
  grant rolexamen to carla_$1;
EOF
  echo usuario creado con rol
}

comprobar_usuario(){
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep existeusuario
	select 'existeusuario'
	from all_users
	where username=upper('carla_$1');
EOF
}

crear_role(){
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF
	create role rolexamen;
	grant connect to rolexamen;
	grant select on carla.multas to rolexamen;
	grant update(importe) on carla.multas to rolexamen;
EOF	
}

comprobar_rol() {
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep existerol
	select 'existerol'
	from dba_roles
	where role=upper('rolexamen');
EOF
}

if comprobar_rol
  then
    echo El rol ya existe
else
  echo el rol no existe, se creara
  crear_role
fi


if comprobar_usuario $1
	then
	el usuario que intenta crear ya existe
	exit 1
else
	crear_usuario $1
fi

