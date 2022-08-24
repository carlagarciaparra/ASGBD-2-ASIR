#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

existe_tabla() {
ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep tabla
	connect junio/alumno;
	select 'tabla'
	from all_tables
	where table_name=upper('meter_datos');
EOF
}

crear_tabla(){
ORACLE_SID=asir sqlplus / as sysdba <<EOF
	connect junio/alumno;
	create table meter_datos (datos varchar (1024));
	commit;
EOF
}

introducir_datos() {
     ORACLE_SID=asir sqlplus / as sysdba <<EOF
     connect junio/alumno;
     insert into meter_datos values ($linea);
EOF
}

nombre_tablas() {
     ORACLE_SID=asir sqlplus / as sysdba <<EOF
     select table_name
     from all_tables;
EOF
while IFS= read -r linea  
	do	
	   echo $linea
	done < /home/alumno/Desktop/recuperacion/tablas.txt  
}

nombre_tablas

if existe_tabla
	then
     	     while IFS= read -r linea  
  		do	
			introducir_datos
  		done < tablas.txt  
	else
	     crear_tabla
     	     while IFS= read -r linea  
  		do	
			introducir_datos
  		done < tablas.txt
fi

