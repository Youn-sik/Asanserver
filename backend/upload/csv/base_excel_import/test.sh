#!/bin/bash

##############################
#csv_file="/home/asan/asan/backend/upload/csv/schedule.csv"

#cat "$csv_file" | sed 1,2d | while read line
#do
#	col1=$(echo $line | cut -f 1 -d ',')
#	col2=$(echo $line | cut -f 2 -d ',')
#	col3=$(echo $line | cut -f 3 -d ',')
#	#echo "${col1}/${col2}/${col3}"
#	col4=$(echo $line | cut -f 4 -d ',')
#	col5=$(echo $line | cut -f 5 -d ',')
#	col6=$(echo $line | cut -f 6 -d ',')
#	col7=$(echo $line | cut -f 7 -d ',')
#	#echo "${col4}/${col5}/${col6}/${col7}"
#	
#	if [ -n "$col1" ] && [ -n "$col2" ] && [ -n "$col3" ]; then
#		echo "${col1}/${col2}/${col3}"
#	fi
#
#	if [ -n "$col4" ] && [ -n "$col5" ] && [ -n "$col6" ] && [ -n "$col7" ]; then
#		echo "${col4}/${col5}/${col6}/${col7}"
#	fi
#done
##############################

#mysql -u asan -pmaster123 <<MYSQL
#use asancloud
#select * from g_schedule
#MYSQL


echo "use asancloud; select * from g_schedule;" | mysql -uasan -pmaster123 asancloud | sed 1d | while read col
do
	home_name=$(echo "$col" | cut -f 8 -d '	')
	echo "$home_name"
done
	
