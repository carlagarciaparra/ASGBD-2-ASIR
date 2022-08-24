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

email(){
	echo Buenos dias,
	echo En este momento existen los siguientes usuarios en la base de datos:
	echo
	usuarios
	echo Un saludo
	echo Carla García
	
}


usuarios(){
ORACLE_SID=ASIR sqlplus -S carla/carla <<EOF 
set colsep ',' 
set pagesize 0 
set trimspool on 
set headsep off 
set linesize 1000
set feedback off

select 
	username 
from 
	dba_users;

spool off
EOF
}



email
#email | mail -s "Carla Garcia" alejandroalonsoplaza@gmail.com
