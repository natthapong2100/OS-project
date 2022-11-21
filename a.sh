#!/bin/sh

# cd "Labs/Lab1/63011208"

LAB_NAME=$1 # Lab11
CORRECT_ANS=$2 # 20
LAB_X=${LAB_NAME:0:4} # Lab1
QUESTOIN_Y=${LAB_NAME:4} # 1

cd "Labs/$LAB_X"

if [ -f "result$LAB_NAME.txt" ]; then
    # echo "Record file existed"
    rm "result$LAB_NAME.txt" # or delete file
fi

id=0
# while [ $id -le 999 ]; do
for id in {0..999}; do # last 3 digits of ID number

    # set Full ID
    if (( $id < 10 )); then
        FULL_ID="6301100$id"
    elif (($id >= 10 && $id < 100)); then
        FULL_ID="630110$id"

    elif (( $id >= 100 )); then
        FULL_ID="63011$id"
    fi

    if [ -d "$FULL_ID" ]; then # check dir existed
        echo "$FULL_ID Existed"
        cd "$FULL_ID"
        if [ -f "$LAB_NAME.c" ]; then # check file existed
            # check file existed, not needed
            gcc -o answer "$LAB_NAME.c" 2>/dev/null
            if [ "$?" -eq "0" ]; then
                # check answer and calculate the score
                MY_ANS="$(./answer)" # put the o/p into var
                echo "$FULL_ID's answer is $MY_ANS"

                if (($MY_ANS == $CORRECT_ANS)); then
                    SCORE="$FULL_ID;3"
                elif (($MY_ANS != $CORRECT_ANS)); then
                    SCORE="$FULL_ID;2"
                fi

            else
                SCORE="$FULL_ID;1"
                echo "Compilation Error!"
            fi

            cd ".."
            echo $SCORE
            echo "$SCORE" >> "result$LAB_NAME.txt"
        else
            echo "$LAB_NAME of student $FULL_ID NOT existed"
        fi
    

    fi # if we not have that ID in our classroom, so skip!
        
        
done
