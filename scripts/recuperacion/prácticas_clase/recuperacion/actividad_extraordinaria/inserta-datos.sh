#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

existetabla() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF | grep tabla
	select 'tabla'
	from all_tables
	where table_name=upper('tabla');
EOF
}

creartabla() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
	create table TABLA (dato varchar (255));
EOF
	echo La tabla se ha creado correctamente
}

insertadatos() {
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
	insert into TABLA values ('$linea');
	commit;
EOF
}

datos_en_fichero(){
	while IFS= read -r linea
	do
	  echo $linea
 	done > datos.txt
}

datos_en_fichero

if existetabla
	then 
	   	while IFS= read -r linea
		 do 
		   insertadatos
		 done < datos.txt
else
	creartabla
	while IFS= read -r linea
	 do 
	   insertadatos
	 done < datos.txt

fi

#borrar fichero creado anteriormente para introducir los datos en las tablas

rm datos.txt
