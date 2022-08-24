#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
ORACLE_SID=asir
PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_HOME
export PATH
export ORACLE_SID

comprobar_tabla() {
		ORACLE_SID=asir sqlplus KK/KK <<EOF | grep existetabla 1>/dev/null 2>/dev/null			
		select 'existetabla' from all_tables where owner=upper('KK') and TABLE_NAME=upper('DATOS');
EOF
	        }

crear_tabla(){
	ORACLE_SID=asir sqlplus KK/KK <<EOF 1>/dev/null 2>/dev/null
	create table DATOS (datos varchar (255));
	commit;
EOF
             }

meter_dato() {
	ORACLE_SID=asir sqlplus KK/KK <<EOF 1>/dev/null 2>/dev/null
	insert into DATOS values ('$linea');
	commit;
EOF
           }

if (comprobar_tabla)
then 
	error_level=0
else 
	crear_tabla
	error_level=1
fi

while IFS= read -r linea
do 
	meter_dato
done < inserta-datos.sh

if [ $error_level -eq 1 ] 
then 	
	exit 1;
fi

