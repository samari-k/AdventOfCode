#! /bin/bash

# need to pass "1" as attribute to calculate the first part of the puzzle

# hardcoded input, just because

declare -a stacks


# small test-input
#stacks[1]="ZN"
#stacks[2]="MCD"
#stacks[3]="P"

# long real input
stacks[1]="RSLFQ"
stacks[2]="NZQGPT"
stacks[3]="SMQB"
stacks[4]="TGZJHCBQ"
stacks[5]="PHMBNFS"
stacks[6]="PCQNSLVG"
stacks[7]="WCF"
stacks[8]="QHGZWVPM"
stacks[9]="GZDLCNR"

while read line; do
    if [[ ${line:0:1} != "m" ]]; then
        continue
    fi
    
    read -r count from to <<< $(echo $line | cut -d " " -f 2,4,6)
    
    fromstack=${stacks[$from]}
    tostack=${stacks[$to]}
    
    slice=$((${#fromstack}-$count))
    move=${fromstack:$slice}
    
    if [[ $2 == "1" ]]; then
        move=$(rev <<< $move)
    fi

    tostack+=$move
    fromstack=${fromstack:0:$slice}
    
    stacks[$from]=$fromstack
    stacks[$to]=$tostack
done < $1

if [[ $2 == "1" ]]; then
    echo -n "Part One: "
else
    echo -n "Part Two: "
fi
for stack in ${stacks[@]};do
    echo -n ${stack:$((${#stack}-1))}
done
echo ""

