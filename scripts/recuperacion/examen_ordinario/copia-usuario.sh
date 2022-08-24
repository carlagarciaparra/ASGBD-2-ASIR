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

dar_permisos(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF 1>/dev/null 2>/dev/null
  grant connect, resource to carla_prueba2;
  alter user carla_prueba2 quota unlimited on USERS;
  grant imp_full_database to carla_prueba2;
EOF
}
crear_directorio(){ 
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF 1>/dev/null 2>/dev/null
  create directory backups_CARLA as '/home/alumno/scripts/recuperacion/examen_ordinario/backupsExtra';
EOF
}

existe_directorio(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep existedirectorio 1>/dev/null 2>/dev/null
  select 'existedirectorio'
  from all_directories
  where directory_name=('backups_CARLA');
EOF
}



exportacion(){
  hora=$(date '+%H%M')
  ORACLE_SID=ASIR expdp carla_prueba2/prueba directory=backupsExtra dumpfile=backup_$hora.dmp logfile=backup_$hora.log schemas=carla_prueba2
}


if test -d /home/alumno/scripts/recuperacion/examen_ordinario/backupsExtra
  then
    echo Ya existe el directorio
else
  mkdir /home/alumno/scripts/recuperacion/examen_ordinario/backups_CARLA
  chmod 777 /home/alumno/scripts/recuperacion/examen_ordinario/backups_CARLA
fi


dar_permisos

if (existe_directorio)
  then
  echo El directorio ya existe
  errorlevel=0
else
  crear_directorio
  errorlevel=1
fi

if test -f /home/alumno/scripts/recuperacion/examen_ordinario/backupsExtra/backup_$hora.dmp
then
  echo El fichero ya existe
  exit 1
else
  exportacion
fi


fichero=/home/alumno/scripts/recuperacion/examen_ordinario/backupsExtra/backup_$hora.dmp
asunto="Fichero realizado de backup"

if [ "$#" -eq 1 ]
then
  echo "se hará la copia"
  echo "Enviando correo"
  mail -a $fichero -s $asunto $1 </dev/null
  
elif [ "$#" -gt 1 ]
then
  echo "Se han recibido más parámetros de los que se esperaba"
  errorlevel=2
fi

