#!/bin/bash -x
echo "Welcome to TicTacToe Game"
#Constant
START=0;
END=1;

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
	echo ${position[1]}
	checkRoundComputer
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
}
#Function for checking win
checkWin()
{
	value=$1
   winnerName=$2
	if [[ ${position[1]} == $value && ${position[2]} == $value &&  ${position[3]} == $value ]]
	then
			echo "$winnerName Match Win"
			START=$END
	elif [[ ${position[4]} == $value && ${position[5]} == $value &&  ${position[6]} == $value ]]
	then
         echo "$winnerName Match Win"
         START=$END
   elif [[ ${position[7]} == $value && ${position[8]} == $value &&  ${position[9]} == $value ]]
	then
         echo "$winnerName Match Win"
         START=$END
   elif [[ ${position[1]} == $value && ${position[4]} == $value &&  ${position[7]} == $value ]]
	then
         echo "$winnerName Match Win"
         START=$END
   elif [[ ${position[2]} == $value && ${position[5]} == $value &&  ${position[8]} == $value ]]
	then
         echo "$winnerName Match Win"
         START=$END
   elif [[ ${position[3]} == $value && ${position[6]} == $value &&  ${position[9]} == $value ]]
	then
         echo "$winnerName Match Win"
         START=$END
   elif [[ ${position[1]} == $value && ${position[5]} == $value &&  ${position[9]} == $value ]]
	then
         echo "$winnerName Match Win"
         START=$END
   elif [[ ${position[3]} == $value && ${position[5]} == $value &&  ${position[7]} == $value ]]
	then
         echo "$winnerName Match Win"
         START=$END
	fi
}
#CheckTie Function checking every time match tie or not
checkTie()
{
	for(( tieCounter=0;tieCounter<10;tieCounter++ ))
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


