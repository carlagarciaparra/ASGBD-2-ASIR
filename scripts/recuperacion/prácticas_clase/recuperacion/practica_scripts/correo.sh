#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/hom$ORACLE_SID=asir
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

ORACLE_SID=asir sqlplus -S / as sysdba <<HEREDOC
set colsep ','    
set pagesize 0    
set trimspool on  
set headsep off   
set linesize 1000 
#set feedback off

spool csv.csv

select
 	sistema, tamano, usado, montado
from
	 DF

spool off
HEREDOC
echo enviando correo
echo RepasoBases | mail -s "Yo" -a csv.csv  ignacioservert3@gmail.com
echo correo enviado
