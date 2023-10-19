#!/bin/bash

clear 
result=""
raw=""
url="https://mcdonalds.com.pk/full-menu/"

process_raw_input(){
echo " the 1 is $1 and 2 is $raw"
result=$(echo "$raw" | sed "s/$1\">//g")
result=$(echo "$result" | sed "s/<\/span>//g")
result=$(echo "$result" | sed "s/amp;//g")
}

curl_url(){
echo " the 1 is $1 and 2 is $2"
raw=`curl -s $url$1 | grep -Po "$2.*?</span>"`
echo $raw
}

rm -rf menu
echo "scraping the Mcdonals site ..."
curl_url " " "category-title"



echo "processing the raw input ..."
#removing useless values in result

process_raw_input "category-title" $raw
echo $result


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
curl_url "$file/" "categories-item-name"
#echo $raw

echo "processing the raw input ..."
#removing useless values in result
process_raw_input "categories-item-name" $raw


#adding line numbers manually 
result=$(echo "$result"| awk '{printf "%d) %s\n", NR, $0}')

echo "writing to file ..."
echo -e "$result"
echo -e "$result" > $file
echo -e "\n\n"

done
