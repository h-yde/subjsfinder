#!/bin/bash
file_lines=$(cat $1)
echo "Running LinkFinder over these urls..."

for line in $file_lines
do
if [[ "$line" == "http"* ]]
 then
  if [[ $(wget $line -O-) ]] 2>/dev/null
   then
        linkfinder -i `echo $line` -o $(echo `pwd`)"/"$(echo `echo "$line"` | md5sum | sed -e 's/^\(.\{32\}\).*/\1/')".html" &>/dev/null
        echo $line
  fi
else
        if [[ $(wget http://$line -O-) ]] 2>/dev/null
         then
                linkfinder -i `echo http://$line` -o $(echo `pwd`)"/"$(echo `echo "$line"` | md5sum | sed -e 's/^\(.\{32\}\).*/\1/')".html" &>/dev/null
                echo "http://$line"
        fi
        if [[ $(wget https://$line -O-) ]] 2>/dev/null
         then
                linkfinder -i `echo https://$line` -o $(echo `pwd`)"/"$(echo `echo "$line"` | md5sum | sed -e 's/^\(.\{32\}\).*/\1/')".html" &>/dev/null
                echo "https://$line"
        fi
fi
done
echo "Done!"
