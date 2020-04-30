#!/bin/bash
clear

bash ./locate_cursor.sh 1 1 
bash ./color_output.sh "+" green
for((k = 2; k <= $(($2*2)); k++))
do
  bash ./color_output.sh "—" green
done
bash ./color_output.sh "+" green


for((i = 2; i <= `expr $1 + 1`; i++))
do
  bash ./locate_cursor.sh  $i 1
  for((j = 2; j <= $(($2+1)); j++))
  do
    bash ./color_output.sh "|" green
    bash ./color_output.sh "X" sblue
  done
  bash ./color_output.sh "|" green
done


bash ./locate_cursor.sh $i 1 
bash ./color_output.sh "+" green
for((k = 2; k <= $(($2*2)); k++))
do
  bash ./color_output.sh "—" green
done
bash ./color_output.sh "+" green


bash ./locate_cursor.sh `expr $i + 2` 1
bash ./color_output.sh "Minenanzahl: $3 " purple
bash ./locate_cursor.sh `expr $i + 5` 1
bash ./color_output.sh "Tastenbelegung ->  Bewegen: w s a d  Markieren: j Neues Spiel: n Beenden: x" grey blue
 
