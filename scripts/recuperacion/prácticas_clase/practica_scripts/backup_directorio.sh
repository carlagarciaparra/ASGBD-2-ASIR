#!/bin/bash


ruta="/home/alumno/Desktop/recuperacion"
#hora=$(date '+%H%M')
fecha_hora=$(date '+%d-%m_%H:%M')

if test -d /home/alumno/backups
	then	
	     for archivos in $(ls $ruta)
		do 
		   zip /home/alumno/backups/backup_$fecha_hora $ruta/*
		done	
else 
	mkdir /home/alumno/backups
	echo Se ha creado el directorio /home/alumno/backups
fi
