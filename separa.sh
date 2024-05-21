#!/bin/bash
# Programa realitzat per Christina Kaur Krishan 

#comprovar paràmetres:
if [ $1 != s ] && [ $1 != a ] #comprovar primer paràmetre
	then 
		echo "EL PRIMER PARÀMETRE HA DE SER 'a' O 's'" 
		exit 1
elif [ ! -f "$2" ] #comprovar segon paràmetre
	then 
		echo "EL SEGON PARÀMETRE HA DE SER UN FITXER EXISTENT AL DIRECTORI ACTUAL"
		exit 1
elif [ ! -z "$3" ] #comprovar si s'ha entrat un tercer paràmetre o no
	then if [[ "$3" =~ [A-Za-z] ]] || [ "$3" -le 0 ] #comprovar tercer paràmetre
		then 
			echo "EL TERCER PARÀMETRE HA DE SER UN ENTER SUPERIOR A ZERO"
			exit 1
	fi
fi

#llegir fitxer $2 i crear els fitxers corresponents als paràmetres entrats
n_parag=0
n_fitxer=0

if [ $1 = s ] #crear fitxers amb titols repetits ex: "HOLA", "HOLA1", "HOLA2", ...
	then if [ -z "$3" ] #llegeix tot el fitxer 
		then
			while read nom 
			do
				read parag 
				read null
				
				#crear nom del fitxer a crear 
				titol="$nom.txt"
				compt=0
				while [ -f "$titol" ] 
				do 
					compt=$((compt+1))
					titol="$nom$compt.txt"
				done
				
				echo "$parag" >> $titol #escriu $parag dins del fitxer $titol
				echo "$null" >> $titol
				n_parag=$((n_parag+1));
			done<$2
	else #llegeix fitxer fins que s'hagin creat $3 fitxers 
		while [ $n_parag -lt $3 ] && read nom 
		do
			read parag 
			read null
			
			#crear nom del fitxer a crear 
			titol="$nom.txt"
			compt=0
			while [ -f "$titol" ]
			do 
				compt=$((compt+1))
				titol="$nom$compt.txt"
			done
			
			echo "$parag" >> $titol #escriu $parag dins del fitxer $titol
			echo "$null" >> $titol
			n_parag=$((n_parag+1));
		done<$2
	fi
elif [ $1 = a ] #crear fitxers sense titols repetits 
	then if [ -z "$3" ] #llegeix tot el fitxer 
		then 
			while read nom 
			do
				read parag
				read null
				
				#crear nom del fitxer a crear 
				titol="$nom.txt"
				
				echo "$parag" >> $titol #escriu $parag dins del fitxer $titol
				echo "$null" >> $titol
				n_parag=$((n_parag+1));
			done<$2
    else #llegeix fitxer fins que s'hagin creat $3 fitxers 
		while [ $n_parag -lt $3 ] && read nom 
		do
			read parag 
			read null
			
			#crear nom del fitxer a crear 
			titol="$nom.txt"
			
			echo "$parag" >> $titol #escriu $parag dins del fitxer $titol
			echo "$null" >> $titol
			n_parag=$((n_parag+1));
		done<$2
    fi
fi

echo "S'han processat $n_parag paràgrafs."
