#!/bin/bash
#	Crear un script que intente adiviar un numro que tenemos en mente. El programa debera ir
#preguntando al usuario si el numero mostrado es mayor o menor.
 
#!/bin/bash
 
fin=31
inicio=1
intento=$(($RANDOM%fin+inicio))
echo PIENSA UN NUMERO ENTRE 1 Y 31
echo 
echo 'El numero es: '$intento ' s/n?: '
read dato
 
while [ $dato == 'n' ] && [ $inicio -lt $fin ]
do
	echo 'inicio: '$inicio
	echo 'fin: '$fin
	echo 'el numero es mayor o menor?'
	read dato2
  echo
	if [ $dato2 = 'mayor' ]
	then
		inicio=$(expr $intento \+ 1)
		intento=$(($RANDOM%fin+inicio))
    echo 
		echo 'intento2: '$intento
    echo 
	  else
		if [ $dato2 = 'menor' ]
		then
			#inicio=$inicio
			fin=$(expr $intento \- 1)
			intento=$(($RANDOM%fin+inicio))
    echo
			echo 'intento3: '$intento
    echo
		fi
	fi
	echo 'El numero es: '$intento ' s/n?: '
	read dato
done
echo 'Numero encontrado: '$intento

