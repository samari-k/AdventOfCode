#! /bin/bash

read line < $1

for i in $( seq 0 $((${#line}-4)) ); do
    substring=${line:$i:4}
    if ! grep -q '\(.\).*\1' <<< $substring; then
        echo Part One: $(($i+4))
        break
    fi
done

for i in $( seq 0 $((${#line}-14)) ); do
    substring=${line:$i:14}
    if ! grep -q '\(.\).*\1' <<< $substring; then
        echo Part Two: $(($i+14))
        break
    fi
done
