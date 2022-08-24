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

existe_directorio(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep existedirectorio 
  select 'existedirectorio' from all_directories where DIRECTORY_NAME=upper('backupcarla');
EOF
}

creo_directorio(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF
  create directory backupcarla as '/home/alumno/examen/backups';
EOF
}

hora=$(date '+%H%M')
usuario=carla_$hora

crea_usuario(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF
  create user $usuario identified by password;
  grant connect, resource to $usuario;
EOF
}

exportar(){
  ORACLE_SID=ASIR expdp carla/carla directory=backupcarla dumpfile=backup$hora.dmp schemas=carla
}

importar(){
  ORACLE_SID=ASIR impdp carla/carla directory=backupcarla dumpfile=backup$hora.dmp schemas=carla remap_schema=examen:$usuario table_exists_action=replace
}

if (existe_directorio)
then
  error_level=0
else
  creo_directorio
  error_level=1
fi

crea_usuario
exportar
importar


