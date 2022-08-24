#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

sesiones_bloqueadas() {
ORACLE_SID=asir sqlplus / as sysdba <<EOF
 select s.sid as SIDBLOQUEADO, s.blocking_session as SIDBLOQUEANTE, q.sql_text as SENTENCIASSQLBLOQUEADAS from v_$sqltext q , v_$session s
where q.address = s.sql_address
and s.sid in (
  select s2.sid
  from v_$lock l1, v_$session s1, v_$lock l2, v_$session s2
  where s1.sid=l1.sid and s2.sid=l2.sid
  and l1.BLOCK=1 and l2.request > 0
  and l1.id1 = l2.id1
  and l2.id2 = l2.id2 
)
order by piece;
EOF
}

kk() {
	ORACLE_SID=asir sqlplus / as sysdba <<HEREDOCS
	select * from v_$session;
HEREDOCS
}

if [ "$#" -eq 0 ]
	then
		sesiones_bloqueadas

elif [ "$1" = "kill" ]
	then
	     echo Hay que lanzar los siguientes comandos para desbloquear tu usuario:
	     echo sudo kill -9 91
	     echo sudo kill -9 62
else 
	echo Este parámetro no se corresponde con ninguna opcion
fi

