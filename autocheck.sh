#!/bin/sh

LABXY=$1
LAB_X=${LABXY:0:4}
QUESTOIN_Y=${LABXY:4:1}
RESULT=$2

TARGET_DIR="/Users/nat/VS code Proj/OS_project/Labs/$LAB_X"

cd $TARGET_DIR
echo "All files in the directory $TARGET_DIR"
ls
echo

for d in */; do
    echo
    ID=${d:0:8}
    cd "$TARGET_DIR/$d"
    echo "now in directory of id $ID"
    # echo "$1.c"
    FILE="$1.c"
    gcc -o answer "$1.c" 2>/dev/null
    if test -f "$FILE" && [ $? -eq 0 ]; then # ***for check file exit in that folder
        echo "$FILE exists."
        ANS="$(./answer)"
        echo "answer = $ANS"
        echo "result = $RESULT"
        if [ $ANS -eq $RESULT ]; then
            SCORE="$ID;3"
        else
            SCORE="$ID;2"
        fi
        #move to the Lab directory to write resultLabXY.txt
        cd "$TARGET_DIR"
        RESULTFILE="result$LAB_X$QUESTOIN_Y"
        #TODO detect existing score
        if test -f "$RESULTFILE"; then
            echo "$RESULTFILE exists."
            echo $SCORE >> $RESULTFILE
        else
            echo $SCORE > $RESULTFILE
            echo "created maybe"
        fi
    else
        echo "$FILE does not exist."
        cd "$TARGET_DIR"
        SCORE="$ID;1"
        if test -f "$RESULTFILE"; then
            echo "$RESULTFILE exists."
            echo $SCORE >> $RESULTFILE
        else
            echo $SCORE > $RESULTFILE
            echo "created maybe"
        fi
    fi
    #used to fill the score format
done

# echo "$LAB_X Q.$QUESTOIN_Y"
# echo "Result = $RESULT"