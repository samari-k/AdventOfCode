#! /bin/bash

root=$(pwd)
mkdir puzzle


while read line; do

    if [[ ${line:0:3} == "dir" ]]; then
        mkdir $(echo $line | cut -d " " -f 2)
        
    elif [[ ${line:0:1} = [0-9] ]]; then
        read -r size filename <<< $line
        fallocate -l $size $filename
        
    elif [[ ${line:2:2} == "cd" ]]; then
        dirname=$(echo $line | cut -d " " -f 3)
        if [[ $dirname == "/" ]]; then
            dirname="puzzle"
        fi
        cd $dirname
    fi
    
done < $1

cd $root/puzzle

total1=0
while read line; do
    read -r size path <<< $line
    subdirs=$(ls -R $path | grep ":" | wc -l)
    realsize=$(($size - $subdirs * 4096 ))
    if [[ $realsize -le 100000 ]]; then
        total1=$(( $total1 + $realsize ))
    fi
    if [[ $path == "." ]]; then
        sum=$realsize
    fi
done <<< $(du -b)

echo Part One: $total1

required=$((30000000 - $(( 70000000 - $sum )) ))
deletesize=70000000
while read line; do
    read -r size path <<< $line
    subdirs=$(ls -R $path | grep ":" | wc -l)
    realsize=$(($size - $subdirs * 4096 ))
    if [[ $realsize -ge $required ]]; then
        if [[ $realsize -le $deletesize ]]; then
            deletesize=$realsize
        fi
    fi
done <<< $(du -b)

echo Part Two: $deletesize

cd ..
rm -r puzzle
