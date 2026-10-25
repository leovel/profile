#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ $1 ]]
then
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e LEFT JOIN properties p ON e.atomic_number = p.atomic_number LEFT JOIN types t on p.type_id = t.type_id WHERE e.atomic_number = $1")
  else
    ELEMENT=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e LEFT JOIN properties p ON e.atomic_number = p.atomic_number LEFT JOIN types t on p.type_id = t.type_id WHERE e.symbol = '$1' OR e.name = '$1'")
  fi

  if [[ -z $ELEMENT ]]
  then
   echo "I could not find that element in the database."
  else
    echo $ELEMENT | while IFS="|" read NUMBER SYMBOL NAME MASS MELTING BOILING TYPE
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi

else
  echo "Please provide an element as an argument."
fi
