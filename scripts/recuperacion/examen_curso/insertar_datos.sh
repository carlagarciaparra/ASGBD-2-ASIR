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


existe_tabla() {
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep existetabla 1>/dev/null 2>/dev/null 
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


existe_tabla() {
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep existetabla 1>/dev/null 2>/dev/null
  select 'existetabla' from all_tables where owner=('carla') and TABLE_NAME=upper('DATOS');
EOF
}

creo_tabla(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF 1>/dev/null 2>/dev/null
  create table DATOS (datos varchar (255));
  commit;
EOF
}

insertar_datos() {
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF 1>/dev/null 2>/dev/null
  insert into DATOS values ('$linea');
  commit;
EOF
}

if (existe_tabla)
then
  error_level=0
else
  creo_tabla
  errorlevel=1
fi

while IFS= read -r linea
do
  insertar_datos
done

if [ $errorlevel -eq 1 ]
then
  exit 1;
fi

  select 'existetabla' from all_tables where owner=('carla') and TABLE_NAME=upper('DATOS');
EOF
}

creo_tabla(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF 1>/dev/null 2>/dev/null
  create table DATOS (datos varchar (255));
  commit;
EOF
}

insertar_datos() {
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF 1>/dev/null 2>/dev/null
  insert into DATOS values ('$linea');
  commit;
EOF
}

if (existe_tabla)
then
  error_level=0
else
  creo_tabla
  errorlevel=1
fi

while IFS= read -r linea
do
  insertar_datos
done 

if [ $errorlevel -eq 1 ]
then
  exit 1;
fi
