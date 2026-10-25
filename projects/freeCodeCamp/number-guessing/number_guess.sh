#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"

read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")

if [[ -z $USER_ID ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(name) VALUES ('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")
else
  USER_DATA=$($PSQL "SELECT COUNT(*) OVER(PARTITION BY user_id), MIN(guesses) OVER(PARTITION BY user_id) FROM games WHERE user_id = $USER_ID")
  IFS="|" read -r NGAMES BEST <<< "$USER_DATA"

  echo "Welcome back, $USERNAME! You have played $NGAMES games, and your best game took $BEST guesses."
fi

NUMBER=$(( RANDOM % 1000 + 1 ))

COUNT=0;
GUESS=0;

echo "Guess the secret number between 1 and 1000:"

until [[ $GUESS == $NUMBER ]]
do
  read GUESS
  while [[ ! $GUESS =~ ^[0-9]+$ ]]
  do
    echo "That is not an integer, guess again:"
    read GUESS
  done
  COUNT=$(( COUNT + 1))

  if (( NUMBER > GUESS ))
  then
    echo "It's higher than that, guess again:"
  elif (( NUMBER < GUESS ))
  then
    echo "It's lower than that, guess again:"
  fi
done

echo "You guessed it in $COUNT tries. The secret number was $NUMBER. Nice job!"
INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(user_id, guesses) VALUES ($USER_ID, $COUNT)")


