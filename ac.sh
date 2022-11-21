#!/bin/sh


# for i in {1..10}; do
#     echo "$i"
# done

# cd "Labs/Lab1"

# if [ -d "63011210" ]; then
#     echo "Existed"
#     cd "63011210"
#     gcc -o answer "Lab11.c"
#     MY_ANS="$(./answer)" # put the o/p into var
#     echo "My answer is $MY_ANS"

# else
#     echo "Not existed"
# fi

# a=6
# b=7

# if (($a < $b)); then
#     echo "less than"
# else
#     echo "greater than"
# fi

# a=10
# b=20

# # if(($a >= 10 && $b == 22 ))
# # then
# #     echo Yes
# # else
# #     echo No
# # fi

# if [ $a -ge 10 -a $b -eq 20 ] # this is real shell script
# then
#     echo Yes
# else
#     echo No
# fi

# ******* $() cmd substitution, $(()) arithmetic
number=5
# square_root=$(echo "scale=6; sqrt($number)" | bc)
# echo "Square Root of $number is $square_root"

square_root=$(echo "scale=2; $number + (2^3)" | bc)
echo "Square Root of $number is $square_root"

