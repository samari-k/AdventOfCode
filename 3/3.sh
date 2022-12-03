#! /bin/bash

priority_sum=0
group_size=-1
group_priority_sum=0

while read line; do
    
    # split line in half
    first_half=${line:0:${#line}/2}
    second_half=${line:${#line}/2}
    
    # create group of three
    group_size=$(( $(($group_size+1)) % 3 ))
    group[$group_size]=$line
    
    # find common item in one line
    common=$(tr -dc $first_half <<< $second_half)
    common=${common:0:1}

    # add to sum
    priority=$(echo $common | xxd -p)
    priority=$((16#${priority:0:2} ))
    case $common in
        ['a'-'z'])
            priority=$(($priority - 96))
            ;;
        ['A'-'Z'])
            priority=$(($priority - 38))
            ;;
    esac
    priority_sum=$(($priority_sum+$priority))
    
    # find common item in group and add to sum
    if [ $group_size == 2 ];then
        group_common=$(tr -dc ${group[0]} <<< ${group[1]})
        group_common=$(tr -dc $group_common <<< ${group[2]})
        group_common=${group_common:0:1}
        
        group_priority=$(echo $group_common | xxd -p)
        group_priority=$((16#${group_priority:0:2} ))
        case $group_common in
            ['a'-'z'])
                group_priority=$(($group_priority - 96))
                ;;
            ['A'-'Z'])
                group_priority=$(($group_priority - 38))
                ;;
        esac
        group_priority_sum=$(($group_priority_sum+$group_priority))
    fi
    
done < $1

echo Part One: $priority_sum
echo Part Two: $group_priority_sum
