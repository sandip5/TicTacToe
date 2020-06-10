#!/bin/bash -x
echo "Welcome to TicTacToe Game"
#Constant
GAME_START=0;

#Variables
checkRounds=0;

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
#Function for assigning value of every cell 1 to 9
assignPosition()
{
for(( i=1;i<10;i++ ))
do
   position[i]=$i;
done
}
#Toss Function Which Will Decide Who Play First
doToss()
{
	choose=$(( RANDOM%2 ))
	if(( $choose == 1 ))
	then
			echo "User Selected Randamoly"
			playUser
	else
			echo "Computer Selected Randamoly"
			playComputer
	fi
}
#PlayUser Function Which Will Give Turn To User
playUser()
{
	echo "Play User"
   playerName=User;
	checkRoundUser
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
   playerName=Computer
	checkRoundComputer
	#playUser
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

while [[ $GAME_START -eq 0 ]]
do
   generateBoard
   doToss
   GAME_START=1;
done


