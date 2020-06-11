#!/bin/bash -x
echo "Welcome to TicTacToe Game"
#Constant
GAME_START=0;
CHECK_EMPTY=''

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
					#generateBoard
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
   playerName=User;
	checkRoundUser
	read -p "Enter Position, In Which Cell Do you want to move " userPosition
	position[userPosition]="$setValueUser"
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
   playerName=Computer
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

while [[ $GAME_START == 0 ]]
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
			shiftToOther=2
	elif(( $shiftToOther == 2 ))
	then
			playComputer
			generateBoard
			shiftToOther=1
	fi
	GAME_START=1;
done


