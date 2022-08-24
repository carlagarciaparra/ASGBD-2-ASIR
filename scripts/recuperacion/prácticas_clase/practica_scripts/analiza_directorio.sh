#!/bin/bash

echo introduzca un directorio
read ruta


for elemento in $(ls $ruta)
	do 
	numero_ficheros=$(ls $ruta/$elemento | wc -l)
	lineas=$(wc -l $elemento | awk {'print $1'})
	   
	   if test -d $ruta/$elemento
		then 
		     echo El directorio $elemento contiene $numero_ficheros ficheros 

	   elif test -f $ruta/$elemento 
		then
		     echo El fichero $elemento contiene $lineas lineas 
	   fi	
	done

