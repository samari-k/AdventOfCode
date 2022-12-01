#! /bin/bash

current=0
most=0
second_most=0
third_most=0

echo "" >> $1
while read line; do
    if [[ "$line" = "" ]]; then
        if [[ $current -gt $most ]]; then
            third_most=$second_most
            second_most=$most
            most=$current
        elif [[ $current -gt $second_most ]]; then
            third_most=$second_most
            second_most=$current
        elif [[ $current -gt $third_most ]]; then
            third_most=$current
        fi
        current=0
    else
        current=$(($current+$line))
    fi
done < $1

echo Part One: $most
echo Part Two: $(($most+$second_most+$third_most))
