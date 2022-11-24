#!/bin/sh

n=0 # line numbers
MAX=0
MIN=3

AVERAGE=0 # = Mean
SD=0
SUM_POINTS=0 # accumulate sum

LAB_NAME=$1 # Lab1

cd "Labs/$LAB_NAME"

# delete file if $LAB_NAME-$FULL_ID.txt already exists
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

# delete file if mathstat file already exists
if [ -f "$LAB_NAME-mathstat.txt" ]; then
    rm "$LAB_NAME-mathstat.txt"
fi

# categorize the file by in one file have every lab question score
for num in {1..9}; do
    filename="result$LAB_NAME$num.txt"
    
    if [ -f "$filename" ]; then
        while read line; do
            ID=${line:0:8}
            SCORE=${line:9}
            echo "$SCORE" >> "$LAB_NAME-$ID.txt" # Lab1-63011208.txt
        done < $filename

    fi

done

# sum into total score and write to a file
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

        echo "$FULL_ID;$SCORE" >> "$LAB_NAME-totalscore.txt" # total score
    fi
done

filename="$LAB_NAME-totalscore.txt" # change filename

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
echo "MAX: $MAX, MIN: $MIN" >> "$LAB_NAME-mathstat.txt"

AVERAGE=$(echo "scale=6; $SUM_POINTS / $n" | bc) # x bar
echo "Average: $AVERAGE"
echo "Average: $AVERAGE" >> "$LAB_NAME-mathstat.txt"


# calculate S.D.
TEMP=0
while read line; do
    POINTS=${line:9} # the point is in index 9th
    TEMP_POWER=$(echo "scale=6; (($POINTS - $AVERAGE)^2)" | bc)
    TEMP=$(echo "scale=6; $TEMP + $TEMP_POWER" | bc)

done < $filename

TEMP=$(echo "scale=6; $TEMP / $n" | bc)
SD=$(echo "scale=6; sqrt($TEMP)" | bc)

echo "SD: $SD"
echo "SD: $SD" >> "$LAB_NAME-mathstat.txt"


