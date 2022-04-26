#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~"
echo -e "\nWelcome to My Salon, how can I help you?\n"

SERVICE_MENU() {
  if [[ $1 ]]
  then
  echo -e "\n$1"
  fi

  SERVICES_MENU=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  echo "$SERVICES_MENU" | while read ID BAR NAME
  do
  echo "$ID) $NAME"
  done
  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then
    SERVICE_MENU "I could not find that service. What would you like today?"
  fi
}

MAIN_MENU() {
  SERVICE_MENU
  
    
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    GET_CUSTOMER_PHONE=$($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'")
  
      if [[ -z $GET_CUSTOMER_PHONE ]]
      then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      INSERT_INTO_CUS=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      fi

      GET_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

      echo -e "\nWhat time would you like your cut, $GET_NAME?"
      read SERVICE_TIME


  
      GET_CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

      INSERT_TO_APP=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($GET_CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")

      GET_SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
      echo -e "\nI have put you down for a $GET_SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
    
  
  
}

MAIN_MENU