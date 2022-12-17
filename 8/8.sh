#! /bin/bash

# make grid with same dimensions
read -r height width <<< $( cat $1 | wc -lL )
trees=( $( cat $1 | tr "\n" " " ) )

grid=( )
dots=""
for i in $(seq 1 $width); do
    dots+="."
done

for i in  $( seq 1 $height ); do
  grid=( ${grid[@]} $dots )
done


# from left and right: mark every tree that's bigger than the ones before
for i in  $( seq 0 $(($height-1)) ); do
    row=${trees[$i]}
    gridrow=${grid[$i]}
    
    # from left
    biggest=${row:0:1}
    gridrow="X"${gridrow:1}
    for j in $(seq 0 $(($width-1))); do
        if [[ ${row:$j:1} -gt $biggest ]]; then
            gridrow=${gridrow:0:$j}"X"${gridrow:$(($j+1))}
            biggest=${row:$j:1}
        fi
        if [[ $biggest -eq 9 ]]; then
                break
        fi
    done
    
    
    # from right
    biggest=${row:$(($width-1)):1}
    gridrow=${gridrow:0:$(($width-1))}"X"
    for j in $(seq 0 $(($width-1)) | tac); do
        if [[ ${row:$j:1} -gt $biggest ]]; then
            gridrow=${gridrow:0:$j}"X"${gridrow:$(($j+1))}
            biggest=${row:$j:1}
        fi
        if [[ $biggest -eq 9 ]]; then
                break
        fi
    done
    
    grid[$i]=$gridrow
done


# same from above and below
# transpose grids
grid=( $(echo ${grid[@]} | tr " " "\n" | sed 's/./& /g' | datamash transpose -t " " | sed 's/ //g' | tr "\n" " " ) )
trees=( $(echo ${trees[@]} | tr " " "\n" | sed 's/./& /g' | datamash transpose -t " " | sed 's/ //g' | tr "\n" " ") )
for i in  $( seq 0 $(($width-1)) ); do
    
    row=${trees[$i]}
    gridrow=${grid[$i]}
    
    # from above
    biggest=${row:0:1}
    gridrow="X"${gridrow:1}
    for j in $(seq 0 $(($height-1))); do
        if [[ ${row:$j:1} -gt $biggest ]]; then
            gridrow=${gridrow:0:$j}"X"${gridrow:$(($j+1))}
            biggest=${row:$j:1}
        fi
        if [[ $biggest -eq 9 ]]; then
                break
        fi
    done
    
    
    # from below
    biggest=${row:$(($height-1)):1}
    gridrow=${gridrow:0:$(($height-1))}"X"
    for j in $(seq 0 $(($height-1)) | tac); do
        if [[ ${row:$j:1} -gt $biggest ]]; then
            gridrow=${gridrow:0:$j}"X"${gridrow:$(($j+1))}
            biggest=${row:$j:1}
        fi
        if [[ $biggest -eq 9 ]]; then
                break
        fi
    done
    
    grid[$i]=$gridrow
done
 # re-transpose grids
grid=( $(echo ${grid[@]} | tr " " "\n" | sed 's/./& /g' | datamash transpose -t " " | sed 's/ //g' | tr "\n" " " ) )
trees=( $(echo ${trees[@]} | tr " " "\n" | sed 's/./& /g' | datamash transpose -t " " | sed 's/ //g' | tr "\n" " ") )

# count marks in new grid
echo Part One: $(echo "${grid[@]//[^X]}" | tr -d " " | wc -L)
