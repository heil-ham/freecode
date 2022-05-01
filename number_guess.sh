#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read NAME

NUMBER=$(( RANDOM % 100 + 1))
USERNAME=$($PSQL "SELECT username FROM data WHERE username='$NAME'")

B_GAME=1

BUKAN_ANGKA() {
  while [[  ! $GUESS =~ ^[0-9]+$ ]]
  do
  echo "That is not an integer, guess again:"
  (( B_GAME++ ))
  read GUESS
  done
}

ANGKA() {
  while [[ (( $GUESS =~ ^[0-9]+$ )) && (( $GUESS != $NUMBER )) ]]
  do
    if [[ $GUESS -lt $NUMBER ]]
    then
    echo "It's higher than that, guess again:"
    (( B_GAME++ ))
    read GUESS
    elif [[ $GUESS -gt $NUMBER ]]
    then
    echo "It's lower than that, guess again:"
    (( B_GAME++ ))
    read GUESS
    else
    BUKAN_ANGKA
    fi
  done
}

if [[ -z $USERNAME ]]
then
  echo "Welcome, $NAME! It looks like this is your first time here."
  echo "Guess the secret number between 1 and 1000:"
  read GUESS
  BUKAN_ANGKA
  ANGKA
  INSERT=$($PSQL "INSERT INTO data(username,best_game,games_played) VALUES('$NAME',$B_GAME,1)")
  if [[ $INSERT == "INSERT 0 1" ]]
  then
  echo "You guessed it in $B_GAME tries. The secret number was $NUMBER. Nice job!"
  fi

else
  BEST_GAME=$($PSQL "SELECT best_game FROM data WHERE username='$NAME'")
  G_PLAYED=$($PSQL "SELECT games_played FROM data WHERE username='$NAME'")
  echo "Welcome back, $(echo $NAME | sed -r 's/^ *| *$//g' )! You have played $(echo $G_PLAYED | sed -r 's/^ *| *$//g') games, and your best game took $(echo $BEST_GAME | sed -r 's/^ *| *$//g') guesses."
  echo "Guess the secret number between 1 and 1000:"
  read GUESS
  BUKAN_ANGKA
  ANGKA
  (( G_PLAYED++ ))
  if [[ $B_GAME -lt $BEST_GAME ]]
  then
  UPDATE_BG=$($PSQL "UPDATE data SET best_game=$B_GAME WHERE username='$NAME'")
  UPDATE_GP=$($PSQL "UPDATE data SET games_played=$G_PLAYED WHERE username='$NAME'")
    if [[ (( $UPDATE_BG == "UPDATE 1" )) && (( $UPDATE_GP == "UPDATE 1" )) ]]
    then
    echo "You guessed it in $B_GAME tries. The secret number was $NUMBER. Nice job!"
    fi
  else
    if [[ $UPDATE_GP == "UPDATE 1" ]]
    then
    echo "You guessed it in $B_GAME tries. The secret number was $NUMBER. Nice job!"
    fi
  fi
fi
