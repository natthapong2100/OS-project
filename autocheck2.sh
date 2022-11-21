#!/bin/sh

LABXY=$1
LAB_X=${LABXY:0:4}
QUESTOIN_Y=${LABXY: -1:1}
RESULT=$2
TARGET_DIR="/Users/ntr_bank/Labs/$LAB_X"
cd $TARGET_DIR
RESULTFILE="result$LAB_X$QUESTOIN_Y"

if [[ ! -f $RESULTFILE ]];then
> $RESULTFILE
fi

for d in */; do
    # Check if the id is already in the RESULTFILE
    cd $TARGET_DIR
    ID=${d:0:8}
    if  CHECKED=$(grep $RESULTFILE -e $ID); then 
        continue
    fi

    # The id is not exist try to compile the program
    cd "$TARGET_DIR/$d"
    FILE="$1.c"
    gcc -o answer "$1.c" 2>/dev/null
    # Check if the program is compilable and exist
    if [ $? -eq 0 ] && [ -f $FILE ]; then
        ANS="$(./answer)"
        if [ $ANS -eq $RESULT ]; then
            SCORE=3
        else
            SCORE=2
        fi
        # Move to the Lab directory to write the score in RESULTFILE
        cd "$TARGET_DIR"
        echo "$ID;$SCORE" >> $RESULTFILE
    else
        cd "$TARGET_DIR"
        SCORE=1
        echo "$ID;$SCORE" >> $RESULTFILE
    fi
    # Sort RESULTFILE in order of the id
    sort -o $RESULTFILE $RESULTFILE
    
    # Adding score to total score in TOTALFILE locate in /Home/Labs
    cd "/Users/ntr_bank/Labs"
    TOTALFILE="totalScore"
    
    # Check if the total score file is absence -> y: create TOTALFILE
    if [[ ! -f $TOTALFILE ]]; then
        > $TOTALFILE
    fi

    # Try to get line of the id in TOTALFILE 
    if TOTALSCORE=$(grep -n $TOTALFILE -e $ID); then
        grep -v $ID $TOTALFILE > tmpfile && mv tmpfile $TOTALFILE
        TOTALSCORE=${TOTALSCORE: -1:1}
        NEWSCORE=$((TOTALSCORE + SCORE))
        echo "$ID;$NEWSCORE" >> $TOTALFILE 
    else
        echo "$ID;$SCORE" >> $TOTALFILE
    fi
    # Sort TOTALFILE in order of the id
    sort -o $TOTALFILE $TOTALFILE
done