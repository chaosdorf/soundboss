#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
DIR=$1
rm files.txt
for FILE in $(ls -1 $DIR);
do
	filename=$(basename "$FILE")
	filename="${filename%.*}"
	name=$(echo $filename | tr ' ' '_'| tr -d '[{}(),\!]' | tr -d "\'" | tr '[A-Z]' '[a-z]' | sed 's/_-_/_/g')
	echo "<li data-file=$name>$filename</li>" >>files.txt
done

cd $DIR
for FILE in $(ls -1);
do
	mv -v "$FILE" `echo $FILE | tr ' ' '_' | tr -d '[{}(),\!]' | tr -d "\'" | tr '[A-Z]' '[a-z]' | sed 's/_-_/_/g'`
	
done
for FILE in $(ls -1);
do
	
	/home/bediko/soundboss/script/convert $FILE
done
IFS=$SAVEIFS
