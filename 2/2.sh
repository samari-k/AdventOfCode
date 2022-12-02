#!/bin/bash

total_one=0
round_one=0
total_two=0
round_two=0

while read line; do
    read -r opponent myself <<< $(echo $line)
    
    case $opponent in
        'A') # Rock
            case $myself in
                'X') # 1. Rock
                    round_one=$((1+3))
                     # 2. lose
                     round_two=$((3+0)) # choose scissors to lose
                    ;;
                'Y') # 1. Paper
                    round_one=$((2+6))
                     # 2. draw
                     round_two=$((1+3)) # choose rock to draw
                    ;;
                'Z') # 1. Scissors
                    round_one=$((3+0))
                     # 2. win
                     round_two=$((2+6)) # choose paper to win
                    ;;
            esac
            ;;
        'B') # Paper
            case $myself in
                'X') # 1. Rock
                    round_one=$((1+0))
                     # 2. lose
                    round_two=$((1+0)) # choose rock to lose
                    ;;
                'Y') # 1. Paper
                    round_one=$((2+3))
                     # 2. draw
                    round_two=$((2+3)) # choose paper to draw
                    ;;
                'Z') # 1. Scissors
                    round_one=$((3+6))
                     # 2. win
                    round_two=$((3+6)) # choose scissors to win
                    ;;
            esac
            ;;
        'C') # Scissors
            case $myself in
                'X') # 1. Rock
                    round_one=$((1+6))
                     # 2. lose
                    round_two=$((2+0)) # choose paper to lose
                    ;;
                'Y') # 1. Paper
                    round_one=$((2+0))
                     # 2. draw
                    round_two=$((3+3)) # choose scissors to draw
                    ;;
                'Z') # 1. Scissors
                    round_one=$((3+3))
                     # 2. win
                    round_two=$((1+6)) # choose rock to win
                    ;;
            esac
            ;;
    esac
    
    total_one=$(($total_one + $round_one))
    total_two=$(($total_two + $round_two))
    round_one=0
    round_two=0
done < $1

echo Part One: $total_one
echo Part Two: $total_two
