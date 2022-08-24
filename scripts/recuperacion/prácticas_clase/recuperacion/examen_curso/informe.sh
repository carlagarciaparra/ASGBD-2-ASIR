#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
ORACLE_SID=asir
PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_HOME
export PATH
export ORACLE_SID

mensaje_email(){
	echo Buenos dias,
echo En este momento existen los siguientes usuarios en la base de datos:
	echo
	usuarios_en_base
	echo Un saludo
	echo Ignacio Servert
}

usuarios_en_base() {

ORACLE_SID=asir sqlplus -S / as sysdba <<HEREDOC
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
HEREDOC
}

mensaje_email | mail -s "Ignacio Servert" $1
