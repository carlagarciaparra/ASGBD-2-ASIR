#!/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c/
PATH=/home/alumno/oracle-install-18c//bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/hom$ORACLE_SID=asir
export ORACLE_HOME
export PATH
export ORACLE_SID


comando_df(){
	df -k | tail -n +2 > comando_df.txt
}

hora=$(date | awk {'print $4'})

comando_df

while IFS= read -r line
do
	sistema=$(echo "$line" | awk {'print $1'})	
	tamano=$(echo "$line" | awk {'print $2'})	
	usado=$(echo "$line" | awk {'print $3'})	
	montado=$(echo "$line" | awk {'print $6'})
	ORACLE_SID=asir sqlplus / as sysdba <<EOF >/dev/null	
	insert into DF values ('$hora','$sistema','$tamano','$usado','$montado');
	commit;
EOF
done < "comando_df.txt"

