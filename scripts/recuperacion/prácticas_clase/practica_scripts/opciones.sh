#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/alumno/.local/bin:/home/alumno/bin
ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID

#Se necesita pasar un parametro, sino informa de ello / (test -z) significa longitud de la cadena = 0
if test -z $1
	then 
	     echo se necesita pasar un parámetro
             exit
fi

#si el parametro es un fichero, se obtiene su tamaño en bytes
if test -f $1
	then
	     #wc -c $1
	     stat --format="%s" $1
fi

#si el parametro es un directorio, se indica cuantos directorios/ficheros tiene
if test -d $1
	then 
	     ls $1 | wc -l
fi

#si no es ni un fichero ni un directorio se informara de ello

if [ ! -d $1 ] && [ ! -f $1 ]
	then
	    echo El parametro tiene que ser un fichero o un directorio
fi
