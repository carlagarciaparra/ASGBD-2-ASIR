#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
ORACLE_SID=asir
PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_HOME
export PATH
export ORACLE_SID

ORACLE_SID=asir sqlplus -S copia_25_05/alumno <<HEREDOC
set colsep ','    -- separate columns with a comma
set pagesize 0    -- No header rows
set trimspool on  -- remove trailing blanks
set headsep off   -- this may or may not be useful...depends on your headings.
set linesize 1000 -- X should be the sum of the column widths


spool archivo_mandar_correo.csv

select * 
  from detalles;

spool off
HEREDOC

echo "Esto es un correo con copia de datos"| mail -a archivo_mandar_correo.csv -a /home/alumno/Desktop/recuperacion/carpeta_exp_imp/* ignacioservert3@gmail.com 
