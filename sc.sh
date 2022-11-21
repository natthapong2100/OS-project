#!/bin/sh

n=0 # line numbers
MAX=0
MIN=3

AVERAGE=0 # = Mean
SD=0
SUM_POINTS=0 # accumulate sum

LAB_NAME=$1 # Lab1

cd "Labs/$LAB_NAME"
# filename="resultLab11.txt" # this line for stat for each lab question

for id in {0..999}; do

    # set Full ID
    if (( $id < 10 )); then
        FULL_ID="6301100$id"
    elif (($id >= 10 && $id < 100)); then
        FULL_ID="630110$id"

    elif (( $id >= 100 )); then
        FULL_ID="63011$id"
    fi

    # delete file if ID with lab name file already exists
    if [ -f "$LAB_NAME-$FULL_ID.txt" ]; then
        rm "$LAB_NAME-$FULL_ID.txt"
    fi
done

# delete file if totalscore file already exists
if [ -f "$LAB_NAME-totalscore.txt" ]; then
    rm "$LAB_NAME-totalscore.txt"
fi

for num in {1..9}; do
    filename="result$LAB_NAME$num.txt"
    
    if [ -f "$filename" ]; then
        while read line; do
            ID=${line:0:8}
            SCORE=${line:9}
            echo "$SCORE" >> "$LAB_NAME-$ID.txt"
        done < $filename

    fi

done


for id in {0..999}; do

    # set Full ID
    if (( $id < 10 )); then
        FULL_ID="6301100$id"
    elif (($id >= 10 && $id < 100)); then
        FULL_ID="630110$id"

    elif (( $id >= 100 )); then
        FULL_ID="63011$id"
    fi

    filename="$LAB_NAME-$FULL_ID.txt"
    SCORE=0
    if [ -f "$filename" ]; then
        while read line; do
            SCORE=$((SCORE+line))
        done < $filename

        echo "$FULL_ID;$SCORE" >> "$LAB_NAME-totalscore.txt"
    fi


done

filename="$LAB_NAME-totalscore.txt"

# ******* calculate entire of this for ALL result (Lab1), so file name = 1 file recently
# calculate MIN, MAX, accumulate sum
while read line; do # reading line by line
    n=$((n+1))
    POINTS=${line:9} # the point is in index 9th

    if (( $POINTS > $MAX )); then
        MAX=$POINTS
    fi

    if (( $POINTS < $MIN )); then
        MIN=$POINTS
    fi

    SUM_POINTS=$((SUM_POINTS + POINTS))

done < $filename


echo "MAX: $MAX, MIN: $MIN"

AVERAGE=$(echo "$SUM_POINTS / $n" | bc) # x bar
echo "Average: $AVERAGE" 

# calculate S.D.
while read line; do
    POINTS=${line:9} # the point is in index 9th
    # TEMP=$(( TEMP + ((POINTS - AVERAGE)**2) ))
    echo "Point: $POINTS"

    # A=$(echo "$POINTS + $AVERAGE" | bc)
    TEMP=$(( TEMP + ($POINTS - $AVERAGE)**2 ))  # work! 
    
    # A=$(( ($POINTS - ($SUM_POINTS / $n) )**2 ))
    # TEMP=$((TEMP + A))

    # TEMP=$(echo "scale=3; $TEMP + $A" | bc)
    # AVERAGE=1

    # TEMP=$(echo "$TEMP + (($POINTS - $AVERAGE)^2)" | bc)
    # TEMP=$(echo "scale=6; $POINTS + 1000 )" | bc)

    # TEMP=$( echo "TEMP + 500.33333333" | bc)

done < $filename

TEMP=$(echo "scale=3; $TEMP / $n" | bc)
SD=$(echo "scale=3; sqrt($TEMP)" | bc)

echo "SD: $SD"


