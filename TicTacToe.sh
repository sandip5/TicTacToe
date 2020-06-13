#!/bin/bash -x
echo "Welcome to TicTacToe Game"
#Array
declare -a position
#Constant
START=0;
#Variables
checkRounds=0;
toss=0;
#Game Board Function For Showing Game Board
generateBoard()
{
	printf "\n\n\t\t\t${position[1]}\t|\t${position[2]}\t|\t${position[3]}\n\n\t\t  <------------------------------------------>\n\n\t\t\t${position[4]}\t|\t${position[5]}\t|\t${position[6]}\n\n\t\t  <------------------------------------------->\n\n\t\t\t${position[7]}\t|\t${position[8]}\t|\t${position[9]}\n\n"
}
#Toss Function Which Will Decide Who Play First
doToss()
{
if(( $toss == 0 ))
then
	generateBoard
	choose=$(( RANDOM%2 ))
	if(( $choose == 1 ))
	then
		printf "User Win Toss"
		playUser
		board
	elif(( $choose == 0 ))
	then
		printf "Computer Win Toss"
		playComputer
		board
	fi
	toss=1;
fi
}
#PlayUser Function Which Will Give Turn To User
playUser()
{
track=2
checkRoundUser
read -p "Enter Position : " userPosition
if [ -z "${position[$userPosition]}" ]
then
	position[userPosition]="$setValueUser"
else
	printf "Invalid Input."
	playUser
fi
}
#CheckRoundsUser Function To Check It Is First Round If First Then User Can Assign any X and O
checkRoundUser()
{
if(( $checkRounds == 0 ))
then
	read -p "Choose Value In Between X And O :" setValueUser
	if [ "$setValueUser" == "x" ]
	then
		setValueComputer="o";
		checkRounds=1;
	elif [ "$setValueUser" == "o" ]
	then
		setValueComputer="x";
		checkRounds=1;
	else
		Printf "Select Only In Between X And O In Lower Case"
		checkRoundUser
	fi
fi
}
#PlayComputer Function Which Will Give Turn To Computer
playComputer()
{
if(( $checkRounds == 0 ))
then
	checkRoundComputer
else
	moveComputer
fi
}
#CheckRoundComputer Function For Checking Rounds
checkRoundComputer()
{
if(( $checkRounds == 0 ))
then
	select_X_O
	checkRounds=1;
fi
}
#Select_X_O Function For Randamoly Generating In Between X And O
select_X_O()
{
track=1;
selectXAndO=$(( RANDOM%2 ))
if(( $selectXAndO == 0 ))
then
	setValueComputer=x;
	setValueUser=o;
else
	setValueComputer=o;
	setValueUser=x;
fi
	moveFirstEmptyCell
}
#Function For Move Computer First Empty Cell
moveFirstEmptyCell()
{
for(( i=1;i<10;i++ ))
do
	if [ -z "${position[$i]}" ]
	then
		position[$i]="$setValueComputer";
		i=10;
	fi
done
}
#Function for movement of computer at its term
moveComputer()
{
for(( cellCounter=1;cellCounter<10;cellCounter++ ))
do
	if [ -z "${position[$cellCounter]}" ]
	then
		position[$cellCounter]="$setValueComputer"
         	playerName="Computer"
         	checkWin $setValueComputer $playerName
		position[$cellCounter]=""
	fi
done
blockOpponent
}
#Function from which computer check in next round user going to win or not if win then block it
blockOpponent()
{
flag=1
for(( blockCounter=1;blockCounter<10;blockCounter++ ))
do
	if [ -z "${position[$blockCounter]}" ]
	then
      		position[$blockCounter]="$setValueUser"
 		checkOpponentWin $setValueUser
 		position[$blockCounter]=""
 	fi
done
if [ $flag -eq 1 ]
then
      moveCorner
fi
}
#Function For Refactoring Code
block()
{
position[$blockCounter]="$setValueComputer"
flag=2
blockCounter=10
}
#Function to Block Opponent Winning Position
checkOpponentWin()
{
value=$1
if [[ ${position[1]} == $value && ${position[2]} == $value &&  ${position[3]} == $value ]]
then
      block
elif [[ ${position[4]} == $value && ${position[5]} == $value &&  ${position[6]} == $value ]]
then
      block
elif [[ ${position[7]} == $value && ${position[8]} == $value &&  ${position[9]} == $value ]]
then
      block
elif [[ ${position[1]} == $value && ${position[4]} == $value &&  ${position[7]} == $value ]]
then
      block
elif [[ ${position[2]} == $value && ${position[5]} == $value &&  ${position[8]} == $value ]]
then
      block
elif [[ ${position[3]} == $value && ${position[6]} == $value &&  ${position[9]} == $value ]]
then
      block
elif [[ ${position[1]} == $value && ${position[5]} == $value &&  ${position[9]} == $value ]]
then
      block
elif [[ ${position[3]} == $value && ${position[5]} == $value &&  ${position[7]} == $value ]]
then
      block
fi
}
#MoveCorner Function For selection only Corners
moveCorner()
{
if  [ -z "${position[1]}" ]
then
	position[1]="$setValueComputer"
elif [ -z "${position[3]}" ]
then
	position[3]="$setValueComputer"
elif [ -z "${position[7]}" ]
then
	position[7]="$setValueComputer"
elif [ -z "${position[9]}" ]
then
	position[9]="$setValueComputer"
else
	moveCenter
fi
}
#MoveCentere Function To Check Centere Position Empty If Empty Then Computer Move In Centere
moveCenter()
{
if [ -z "${position[5]}" ]
then
	position[5]="$setValueComputer"
else
	moveFirstEmptyCell
fi
}
#Function For Refactoring Code
insideWin()
{
	board
	printf "$winnerName Match Win"
	exit
}
#Function for checking win
checkWin()
{
value=$1
winnerName=$2
if [[ ${position[1]} == $value && ${position[2]} == $value &&  ${position[3]} == $value ]]
then
	insideWin
elif [[ ${position[4]} == $value && ${position[5]} == $value &&  ${position[6]} == $value ]]
then
 	insideWin
elif [[ ${position[7]} == $value && ${position[8]} == $value &&  ${position[9]} == $value ]]
then
	insideWin
elif [[ ${position[1]} == $value && ${position[4]} == $value &&  ${position[7]} == $value ]]
then
	insideWin
elif [[ ${position[2]} == $value && ${position[5]} == $value &&  ${position[8]} == $value ]]
then
	insideWin
elif [[ ${position[3]} == $value && ${position[6]} == $value &&  ${position[9]} == $value ]]
then
	insideWin
elif [[ ${position[1]} == $value && ${position[5]} == $value &&  ${position[9]} == $value ]]
then
	insideWin
elif [[ ${position[3]} == $value && ${position[5]} == $value &&  ${position[7]} == $value ]]
then
	insideWin
fi
}
#CheckTie Function checking every time match tie or not
checkTie()
{
for(( tieCounter=1;tieCounter<10;tieCounter++ ))
do
	if [ -z "${position[$tieCounter]}" ]
	then
		break
	else
		if(( $tieCounter == 9 ))
		then
			echo "Match Tie"
			exit
		fi
	fi
done
}
#Function For Refactorizing Generate Board
board()
{
	generateBoard
	printf "\n\n============================================================================================================\n\n"
}
while [[ $START == 0 ]]
do
	doToss
	if(( $choose == 1 ))
	then
		shiftToOther=1
		playComputer
		board
		choose=2;
	elif(( $choose == 0 ))
	then
		shiftToOther=2
		playUser
		board
		choose=2;
	fi
	if(( $shiftToOther == 1 ))
	then
		playUser
		board
		playerName="User"
		checkWin $setValueUser $playerName
		checkTie
		shiftToOther=2
	elif(( $shiftToOther == 2 ))
	then
		playComputer
		board
         	playerName="Computer"
         	checkWin $setValueComputer $playerName
		checkTie
		shiftToOther=1
	fi
done
