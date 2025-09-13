#!/usr/bin/env bash
SUM=0
LINE=0
for i in $(ls | grep "yml") 
do
	LINE=$(cat $i | wc -l)
	echo $i: $LINE
	SUM=$SUM+$LINE
done

echo TOTAL: $((SUM))
