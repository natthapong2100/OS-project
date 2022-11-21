#!/bin/sh

if [ -d "63011208" ]
then
    echo "Existed"
else
    echo "Not existed"
fi


gcc -o answer "$LAB_NAME.c"
MY_ANS="$(./answer)" # put the o/p into var
echo "My answer is $MY_ANS"

# calculate the score
cd ".."
ID="63011208"
if [ $MY_ANS -eq $CORRECT_ANS ]
then
    SCORE="$ID;3"

elif [ $MY_ANS -ne $CORRECT_ANS ]
then
    SCORE="$ID;2"

fi # end of condi section


# touch "result$LAB_NAME.txt" # same file (not have new)
echo $SCORE
echo "$SCORE" >> "result$LAB_NAME.txt"
