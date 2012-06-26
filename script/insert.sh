#!/bin/bash 
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
DIR=$1
rm files.txt
for FILE in $DIR/*;
do
	filename=$(basename "$FILE")
	filename="${filename%.*}"
	name=$(echo $filename | tr ' ' '_'| tr -d '[{}(),\!]' | tr -d "\'" | tr '[A-Z]' '[a-z]' | sed 's/_-_/_/g')
	echo "<li data-file=$name>$filename</li>" >>files.txt
done

for FILE in $DIR/*;
do
	filename=$(basename "$FILE")
	
	mv -v "$DIR/$filename" $DIR/`echo "$filename" | tr ' ' '_' | tr -d '[{}(),\!]' | tr -d "\'" | tr '[A-Z]' '[a-z]' | sed 's/_-_/_/g'`
	
done
for FILE in $DIR/*;
do
	
	"$(dirname "$0")"/convert $FILE
done
IFS=$SAVEIFS
