#!/bin/bash -x
echo "Welcome to TicTacToe Game"
#Constant
GAME_START=0;
#Function for assigning value of every cell 1 to 9
assignPosition()
{
for(( i=1;i<10;i++ ))
do
	position[i]=$i;
done
}
#Game Board Function For Showing Game Board
generateBoard()
{
	assignPosition
	echo "################################################"
   echo "#############<---TIC TAC TOE--->################"
	echo "################################################"
	echo "               ||               ||              "
	echo "     ${position[1]}         ||      ${position[2]}        ||     ${position[3]}         "
   echo "               ||               ||              "
	echo "================================================"
   echo "               ||               ||              "
   echo "     ${position[4]}         ||      ${position[5]}        ||     ${position[6]}         "
   echo "               ||               ||              "
   echo "================================================"
   echo "               ||               ||              "
   echo "     ${position[7]}         ||      ${position[8]}        ||     ${position[9]}         "
   echo "               ||               ||              "
}
#Toss Function Which Will Decide Who Play First
doToss()
{
	choose=$(( RANDOM%2 ))
	if(( $choose == 1 ))
	then
			echo "User Selected Randamoly"
			user
	else
			echo "Computer Selected Randamoly"
			computer
	fi
}
while [[ $GAME_START -eq 0 ]]
do
	generateBoard
	doToss
	GAME_START=1;
done
