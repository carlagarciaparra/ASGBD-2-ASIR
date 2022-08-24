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

hora=$(date '+%H%M')

#nos conectamos con un usuario de la base de datos
crea_directorio(){
  sqlplus -S CARLA/carla <<EOF
  create directory backup3 as '/home/alumno/backups';
EOF
}

#comprobamos que el directorio existe
comprobar_directorio(){
  sqlplus -S carla/carla <<EOF | grep DirectorioExiste
  select 'DirectorioExiste' from all_directories where directory_name=upper('backup3');
EOF
}

hacer_backup(){
  ORACLE_SID=ASIR expdp CARLA/carla directory=backups dumpfile=backup_$hora.dmp logfile=backup_$hora.log schemas=CARLA 
}


comprimir(){
  cd /home/alumno
  zip backup-$hora.zip backups
  ls /home/alumno
}

#condiciones

if (comprobar_directorio)
then
  errorlevel=0
else
  crea_directorio
  errorlevel=1
fi

hacer_backup
comprimir



if [ $errorlevel -eq 1 ]
then
  exit 1;
fi
