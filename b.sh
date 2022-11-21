#!/bin/sh

gcc -o answer "ans11.c"
ANS="$(./answer)" # put the o/p into var
echo "This is $ANS"

touch result.txt # same file (not have new)
echo "$ANS" >> result.txt