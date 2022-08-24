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


sesion_bloqueada(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF
 select s.sid as SIDBLOQUEADO, s.blocking_session as SIDBLOQUEANTE, q.sql_text as SENTENCIASSQLBLOQUEADAS from v_$sqltext q , v_$session s
where q.address = s.sql_address
and s.sid in (
  select s2.sid
  from v_$lock l1, v_$session s1, v_$lock l2, v_$session s2
  where s1.sid=l1.sid and s2.sid=l2.sid
  and l1.BLOCK=1 and l2.request > 0
  and l1.id1 = l2.id1
  and l2.id2 = l2.id2 
);
EOF
}

ver_sesiones(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF
  select * from v_$session;
EOF
}

if [ "$1" = 'kill' ]
  then
    sesion_bloqueada
    ver_sesiones
    echo Hay que lanzar los siguientes comandos para desbloquear tu usuario:
	     echo sudo kill -9 132414
	     echo sudo kill -9 432652
else
  echo "Este parámetro no se corresponde"
fi