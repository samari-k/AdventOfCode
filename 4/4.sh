#! /bin/bash
pairs=0
overlaps=0
while read line; do
    read -r l1 l2 r1 r2 <<< $(echo $line | tr ",-" " " )
    if [ $l1 -ge $r1 ] && [ $l1 -le $r2 ]; then
        overlaps=$(($overlaps+1))
        if [ $l2 -le $r2 ]; then
            pairs=$(($pairs+1))
        fi
    elif  [ $r1 -ge $l1 ] && [ $r1 -le $l2 ]; then
        overlaps=$(($overlaps+1))
        if  [ $r2 -le $l2 ]; then
            pairs=$(($pairs+1))
        fi
    fi
done < $1
echo Part One: $pairs
echo Part Two: $overlaps
