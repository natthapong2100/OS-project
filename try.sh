#!/bin/bash

# LABXY=$1
# LAB_X=${LABXY:0:4}
# QUESTOIN_Y=${LABXY:4}
# RESULT=$2

# echo "This is $LABXY, $LAB_X, $QUESTOIN_Y, $RESULT, $?"

txt="63011208;3"
id=${txt:0:8} 
score=${txt:9}

echo "txt: $txt, ID: $id, SCORE: $score"