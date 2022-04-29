#!/bin/bash

#If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, it should output The element with atomic number 1 is Hydrogen (H). 
#It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ $1 ]]
then
GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
GET_NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")
GET_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")

  if [[ ! (( -z $GET_SYMBOL )) || ! (( -z $GET_NAME )) || ! (( -z $GET_NUM )) ]]
  then

    if [[ ! $1 =~ ^[0-9]+$ ]]
    then
  
      if [[ ! (( -z $GET_SYMBOL )) ]]
      then
      SYM_NUM=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'") | sed -r 's/^ *| *$//g')
      SYM_NAME=$(echo $($PSQL "SELECT name FROM elements WHERE symbol='$1'") | sed -r 's/^ *| *$//g')
      SYM_TYPE=$(echo $($PSQL "SELECT typo FROM properties WHERE atomic_number=$SYM_NUM") | sed -r 's/^ *| *$//g')
      SYM_ATOM_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$SYM_NUM") | sed -r 's/^ *| *$//g')
      SYM_MELT_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$SYM_NUM") | sed -r 's/^ *| *$//g')
      SYM_BOIL_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$SYM_NUM") | sed -r 's/^ *| *$//g')
      echo "The element with atomic number $SYM_NUM is $SYM_NAME ($1). It's a $SYM_TYPE, with a mass of $SYM_ATOM_MASS amu. $SYM_NAME has a melting point of $SYM_MELT_POINT celsius and a boiling point of $SYM_BOIL_POINT celsius."
  
      else
      NM_NUMBER=$(echo $($PSQL "SELECT atomic_number FROM elements WHERE name='$1'") | sed -r 's/^ *| *$//g')
      NM_SYM=$(echo $($PSQL "SELECT symbol FROM elements WHERE name='$1'") | sed -r 's/^ *| *$//g')
      NM_TYPE=$(echo $($PSQL "SELECT typo FROM properties WHERE atomic_number=$NM_NUMBER") | sed -r 's/^ *| *$//g')
      NM_ATOM_MASS=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$NM_NUMBER") | sed -r 's/^ *| *$//g')
      NM_MELT_POINT=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$NM_NUMBER") | sed -r 's/^ *| *$//g')
      NM_BOIL_POINT=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$NM_NUMBER") | sed -r 's/^ *| *$//g')
      echo "The element with atomic number $NM_NUMBER is $1 ($NM_SYM). It's a $NM_TYPE, with a mass of $NM_ATOM_MASS amu. $1 has a melting point of $NM_MELT_POINT celsius and a boiling point of $NM_BOIL_POINT celsius."
      fi
  
    else

      if [[ ! (( -z $GET_NUM )) ]]
      then
      GET_SYMBOL2=$(echo $($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1") | sed -r 's/^ *| *$//g')
      GET_NAME2=$(echo $($PSQL "SELECT name FROM elements WHERE atomic_number=$1") | sed -r 's/^ *| *$//g')
      GET_TYPE2=$(echo $($PSQL "SELECT typo FROM properties WHERE atomic_number=$1") | sed -r 's/^ *| *$//g')
      GET_ATOM_MASS2=$(echo $($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1") | sed -r 's/^ *| *$//g')
      GET_MELT_POINT2=$(echo $($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1") | sed -r 's/^ *| *$//g')
      GET_BOIL_POINT2=$(echo $($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1") | sed -r 's/^ *| *$//g')
      echo "The element with atomic number $1 is $GET_NAME2 ($GET_SYMBOL2). It's a $GET_TYPE2, with a mass of $GET_ATOM_MASS2 amu. $GET_NAME2 has a melting point of $GET_MELT_POINT2 celsius and a boiling point of $GET_BOIL_POINT2 celsius."
      fi
      
    fi
  
  else
  echo I could not find that element in the database.
  fi

else
echo Please provide an element as an argument.
fi