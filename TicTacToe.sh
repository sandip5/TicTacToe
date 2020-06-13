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
	echo "################################################"
   	echo "#############<---TIC TAC TOE--->################"
	echo "################################################"
	echo "               ||               ||              "
	echo "     ${position[1]}          ||      ${position[2]}         ||     ${position[3]}         "
   	echo "               ||               ||              "
	echo "================================================"
   	echo "               ||               ||              "
   	echo "     ${position[4]}          ||      ${position[5]}         ||     ${position[6]}         "
   	echo "               ||               ||              "
   	echo "================================================"
   	echo "               ||               ||              "
   	echo "     ${position[7]}          ||      ${position[8]}         ||     ${position[9]}         "
   	echo "               ||               ||              "
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
			echo "User Selected Randamoly"
			playUser
	     		generateBoard
		elif(( $choose == 0 ))
		then
			echo "Computer Selected Randamoly"
			playComputer
			generateBoard
		fi
		toss=1;
	fi
}
#PlayUser Function Which Will Give Turn To User
playUser()
{
echo "Play User"
track=2
checkRoundUser
read -p "Enter Position, In Which Cell Do you want to move " userPosition
if [ -z "${position[$userPosition]}" ]
then
        echo "empty check valid move"
        position[userPosition]="$setValueUser"
else
	echo "Invalid Input."
	playUser
fi
}
#CheckRoundsUser Function To Check It Is First Round If First Then User Can Assign any X and O
checkRoundUser()
{
if(( $checkRounds == 0 ))
then
	read -p "Assign value From X and O For User" setValueUser
	if [ "$setValueUser" == "x" ]
	then
		echo "checkrounduser setvaluecomputer o and setValueUser x"
		setValueComputer="o";
		checkRounds=1;
	elif [ "$setValueUser" == "o" ]
	then
		echo "checkrounduser setvaluecomputer x and setvalueuser o"
		setValueComputer="x";
		checkRounds=1;
	else
		echo "Invalid Options Select Again"
		checkRoundUser
	fi
fi
}
#PlayComputer Function Which Will Give Turn To Computer
playComputer()
{
echo "Play Computer"
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
	echo "Check Round"
        select_X_O
        checkRounds=1;
fi
}
#Select_X_O Function For Randamoly Generating In Between X And O
select_X_O()
{
echo "select_X_O"
track=1;
selectXAndO=$(( RANDOM%2 ))
if(( $selectXAndO == 0 ))
then
	echo "Assign X for Computer and Assign User O "
	setValueComputer=x;
	setValueUser=o;
else
	echo "Assign X for User And O for Computer"
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
      echo "loop "$position[${i}]
      if [ -z "${position[$i]}" ]
      then
      		echo "empty"
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
                echo "$cellCounter Cells Empty if move in this cell then win or not"
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
echo "Block Opponent"
flag=1
for(( blockCounter=1;blockCounter<10;blockCounter++ ))
do
      if [ -z "${position[$blockCounter]}" ]
      then
      		position[$blockCounter]="$setValueUser"
            	echo "$blockCounter Cells Empty if move in this cell then win or not"
            	virtualPlayerName="User"
		actualPlayerName="Computer"
            	checkOpponentWin $setValueUser $virtualPlayerName $actualPlayerName
            	position[$blockCounter]=""
      fi
done
if [ $flag -eq 1 ]
then
      moveCorner
fi
}
#Function to Block Opponent Winning Position
checkOpponentWin()
{
value=$1
checkNextwinnerName=$2
blockWinnerName=$3
if [[ ${position[1]} == $value && ${position[2]} == $value &&  ${position[3]} == $value ]]
then
      echo "$If $checkWinnerName Match Win in next move then $blockWinnerName block that position so user can not move there"
      position[$blockCounter]="$setValueComputer"
      flag=2
      blockCounter=10
elif [[ ${position[4]} == $value && ${position[5]} == $value &&  ${position[6]} == $value ]]
then
      echo "$If $checkWinnerName Match Win in next move then $blockWinnerName block that position so user can not move there"
      position[$blockCounter]="$setValueComputer"
      flag=2
      blockCounter=10
 elif [[ ${position[7]} == $value && ${position[8]} == $value &&  ${position[9]} == $value ]]
 then
       echo "$If $checkWinnerName Match Win in next move then $blockWinnerName block that position so user can not move there"
       position[$blockCounter]="$setValueComputer"
       flag=2
       blockCounter=10
 elif [[ ${position[1]} == $value && ${position[4]} == $value &&  ${position[7]} == $value ]]
 then
       echo "$If $checkWinnerName Match Win in next move then $blockWinnerName block that position so user can not move there"
       position[$blockCounter]="$setValueComputer"
       flag=2
       blockCounter=10
 elif [[ ${position[2]} == $value && ${position[5]} == $value &&  ${position[8]} == $value ]]
 then
        echo "$If $checkWinnerName Match Win in next move then $blockWinnerName block that position so user can not move there"
        position[$blockCounter]="$setValueComputer"
        flag=2
	blockCounter=10
 elif [[ ${position[3]} == $value && ${position[6]} == $value &&  ${position[9]} == $value ]]
 then
         echo "$If $checkWinnerName Match Win in next move then $blockWinnerName block that position so user can not move there"
         position[$blockCounter]="$setValueComputer"
         flag=2
         blockCounter=10
 elif [[ ${position[1]} == $value && ${position[5]} == $value &&  ${position[9]} == $value ]]
 then
         echo "$If $checkWinnerName Match Win in next move then $blockWinnerName block that position so user can not move there"
         position[$blockCounter]="$setValueComputer"
         flag=2
         blockCounter=10
 elif [[ ${position[3]} == $value && ${position[5]} == $value &&  ${position[7]} == $value ]]
 then
         echo "$If $checkWinnerName Match Win in next move then $blockWinnerName block that position so user can not move there"
         position[$blockCounter]="$setValueComputer"
         flag=2
         blockCounter=10
fi
}
#MoveCorner Function For selection only Corners
moveCorner()
{
echo "Check Corner if empty then fill in any corner randamoly"
if  [ -z "${position[1]}" ]
then
        echo "corner 1 ${position[1]}"
        position[1]="$setValueComputer"
elif [ -z "${position[3]}" ]
then
        echo "corner 3 ${position[3]}"
        position[3]="$setValueComputer"
elif [ -z "${position[7]}" ]
then
        echo "corner 7 ${position[7]}"
        position[7]="$setValueComputer"
elif [ -z "${position[9]}" ]
then
        echo "corner 9 ${position[9]}"
        position[9]="$setValueComputer"
else
        moveCenter
	fi
}
#MoveCentere Function To Check Centere Position Empty If Empty Then Computer Move In Centere
moveCenter()
{
echo "Move Center"
if [ -z "${position[5]}" ]
then
	echo "Center is empty"
	position[5]="$setValueComputer"
else
	moveFirstEmptyCell
fi
}
#Function for checking win
checkWin()
{
value=$1
winnerName=$2
if [[ ${position[1]} == $value && ${position[2]} == $value &&  ${position[3]} == $value ]]
then
	echo "$winnerName Match Win"
	exit
elif [[ ${position[4]} == $value && ${position[5]} == $value &&  ${position[6]} == $value ]]
then
        echo "$winnerName Match Win"
        exit
elif [[ ${position[7]} == $value && ${position[8]} == $value &&  ${position[9]} == $value ]]
then
        echo "$winnerName Match Win"
        exit
elif [[ ${position[1]} == $value && ${position[4]} == $value &&  ${position[7]} == $value ]]
then
        echo "$winnerName Match Win"
        exit
elif [[ ${position[2]} == $value && ${position[5]} == $value &&  ${position[8]} == $value ]]
then
        echo "$winnerName Match Win"
        exit
elif [[ ${position[3]} == $value && ${position[6]} == $value &&  ${position[9]} == $value ]]
then
        echo "$winnerName Match Win"
        exit
elif [[ ${position[1]} == $value && ${position[5]} == $value &&  ${position[9]} == $value ]]
then
        echo "$winnerName Match Win"
        exit
elif [[ ${position[3]} == $value && ${position[5]} == $value &&  ${position[7]} == $value ]]
then
        echo "$winnerName Match Win"
        exit
fi
}
#CheckTie Function checking every time match tie or not
checkTie()
{
for(( tieCounter=1;tieCounter<10;tieCounter++ ))
do
	if [ -z "${position[$tieCounter]}" ]
	then
		echo "$tieCounter Cells Empty Match Not Tie. Play Again"
		break
	else
		if(( $tieCounter == 9 ))
		then
			echo "Match Tie"
			START=$END
		fi
	fi
done
}
while [[ $START == 0 ]]
do
	doToss
	if(( $choose == 1 ))
	then
		shiftToOther=1
		playComputer
		generateBoard
		choose=2;
	elif(( $choose == 0 ))
	then
		shiftToOther=2
		playUser
		generateBoard
		choose=2;
	fi
	if(( $shiftToOther == 1 ))
	then
		playUser
		generateBoard
		playerName="User"
		checkWin $setValueUser $playerName
		checkTie
		shiftToOther=2
	elif(( $shiftToOther == 2 ))
	then
		playComputer
		generateBoard
         	playerName="Computer"
         	checkWin $setValueComputer $playerName
		checkTie
		shiftToOther=1
	fi
done
