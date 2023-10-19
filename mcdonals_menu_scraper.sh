#!/bin/bash

clear 


rm -rf menu
echo "scraping the Mcdonals site ..."
raw=`curl -s https://mcdonalds.com.pk/full-menu/ | grep -Po "category-title.*?</span>"`
echo $raw


echo "processing the raw input ..."
#removing useless values in result
result=$(echo "$raw" | sed "s/category-title\">//g")
result=$(echo "$result" | sed "s/<\/span>//g")
result=$(echo "$result" | sed "s/amp;//g")


#processing the names 
filenames=$(echo "$result" | tr ' ' '-')
filenames=$(echo "$filenames" | tr '\n' ' ')
filenames="${filenames#* }"
filenames=$(echo "$filenames" | sed "s/&/and/g")




#preparing string for futher scraping

lowercase_string=$(echo "$filenames" | tr '[:upper:]' '[:lower:]')
filenames=$(echo "$lowercase_string" | iconv -f utf-8 -t ascii//TRANSLIT)
echo $lowercase_string

echo "creating files ..."
#creating files in a directory
mkdir menu
cd menu
touch $filenames




echo -e "\nThe Menu Categories are "

for file in $filenames;do

echo -e "$file"

done


#curling each url of the menu
for file in $filenames;do

echo "scraping the $file menu ..."
raw=`curl -s https://mcdonalds.com.pk/full-menu/$file/ | grep -Po "categories-item-name.*?</span>"`
#echo $raw

echo "processing the raw input ..."
#removing useless values in result
result=$(echo "$raw" | sed "s/categories-item-name\">//g")
result=$(echo "$result" | sed "s/<\/span>//g")
result=$(echo "$result" | sed "s/amp;//g")
echo "writing to file ..."
echo -e "$result"
echo -e "$result" > $file
echo -e "\n\n"

done
