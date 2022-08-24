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

funcion() {
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep fun
	select 'fun'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='FUNCTION';
EOF
}

procedimiento() {
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep proc
	select 'proc'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='PROCEDURE';
EOF
}

vista() {
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep vis
	select 'vis'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='VIEW';
EOF
}

trigger() {
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep tri
	select 'tri'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='TRIGGER';
EOF
}

tabla() {
	ORACLE_SID=ASIR sqlplus carla/carla <<EOF | grep tab
	select 'tab'
	from dba_objects
	where owner=upper('$1') and object_name=upper('$2') and object_type='TABLE';
EOF
}


if funcion $1 $2
	then 
	    echo El objeto $1.$2 existe y es una funcion

elif procedimiento $1 $2
	then
	    echo El objeto $1.$2 existe y es un procedimiento 

elif vista $1 $2
	then
 	    echo El objeto $1.$2 existe y es una vista

elif trigger $1 $2
	then
	    echo El objeto $1.$2 existe y es un trigger

elif tabla $1 $2
	then
	    echo El objeto $1.$2 existe y es una tabla

else
	    echo El objeto $1.$2 no existe
fi



export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export PATH=$ORACLE_HOME/bin:$PATH

