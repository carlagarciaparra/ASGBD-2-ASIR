#!/bin/bash
#!/bin/bash
variables(){
  ORACLE_SID=ASIR
  PATH=$PATH:$ORACLE_HOME/bin
  export PATH
  export ORACLE_HOME
  export ORACLE_SID
}

#LLAMAMOS A LA FUNCIÓN DE LAS VARIABLES
variables

comando_df(){
  df -k | tail -n +2 > comando_df.txt
}

hora=$(date | awk {'print $4'})
comando_df


existetabla() {
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep tabla
	select 'tabla'
	from all_tables
	where table_name=upper('DF');
EOF
}


crear_tabla(){
  ORACLE_SID=ASIR sqlplus carla/carla <<EOF
  create table DF (hora varchar(255), sistema varchar(255), tamano varchar(255), usado varchar(255), montado varchar(255));
EOF
  echo La tabla se ha creado
}


insertar(){
	   while IFS= read -r line
do
	sistema=$(echo "$line" | awk {'print $1'})	
	tamano=$(echo "$line" | awk {'print $2'})	
	usado=$(echo "$line" | awk {'print $3'})	
	montado=$(echo "$line" | awk {'print $6'})
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF >/dev/null	
	insert into DF values ('$hora','$sistema','$tamano','$usado','$montado');
	commit;
EOF
done < "comando_df.txt"
}



if ( existetabla )
	then 
  insertar
else
  crear_tabla
  insertar
fi

