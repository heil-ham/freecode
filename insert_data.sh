#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
TRUNCATE=$($PSQL "TRUNCATE TABLE games, teams;")
cat games.csv | while IFS="," read YEAR ROUND WIN OPP WINGOALS OPPGOALS
do
if [[ $WIN != "winner" && $OPP != "opponent" ]]
then
  GET_WINNER=$($PSQL "SELECT name FROM teams WHERE name='$WIN'")
  if [[ -z $GET_WINNER ]]
  then
  INSERT_WINNER=$($PSQL "INSERT INTO teams(name) values('$WIN')")
  fi
  GET_WINNER=$($PSQL "SELECT name FROM teams WHERE name='$WIN'")

  GET_OPPONENT=$($PSQL "SELECT name FROM teams WHERE name='$OPP'")
  if [[ -z $GET_OPPONENT ]]
  then
  INSERT_OPPONENT=$($PSQL "INSERT INTO teams(name) values('$OPP')")
  fi
  GET_OPP=$($PSQL "SELECT name FROM teams WHERE name='$OPP'")

GET_WIN_ID=$($PSQL "SELECT team_id FROM teams where name='$WIN'")
GET_OPP_ID=$($PSQL "SELECT team_id FROM teams where name='$OPP'")

GET_WINNER_ID=$($PSQL "SELECT winner_id FROM games where winner_id='$GET_WIN_ID'")
GET_OPPONENT_ID=$($PSQL "SELECT opponent_id FROM games where opponent_id='$GET_OPP_ID'")
GET_WIN_GL=$($PSQL "SELECT winner_goals FROM games where winner_goals='$WINGOALS'")
GET_OPP_GL=$($PSQL "SELECT opponent_goals FROM games where opponent_goals='$OPPGOALS'")

if [[ -z $GET_WINNER_ID || -z $GET_OPPONENT_ID || !(( -z $GET_WIN_GL && -z $GET_OPP_GL )) ]]
then
INSERT_GAMES=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES('$YEAR','$ROUND','$GET_WIN_ID','$GET_OPP_ID','$WINGOALS','$OPPGOALS')")
fi
fi
done
