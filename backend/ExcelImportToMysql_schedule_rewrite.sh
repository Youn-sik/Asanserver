#!/bin/bash

flag=0
file="schedule.csv"
file_name="schedule.csv"
file_path="/home/asan/asan/backend/upload/csv/"
db_name="asancloud"
db_table_g_checklist="g_checklist"
db_table_g_checklist_list="g_checklist_list"
db_table_g_home="g_home"
db_table_g_home_list="g_home_list"
db_table_g_instrument="g_instrument"
db_table_g_surgery="g_surgery"
db_table_g_patient="g_patient"
db_table_g_staff="g_staff"
db_table_g_process="g_process"
db_table_g_process_list="g_process_list"
db_user="asan"
db_password="master123"
	
function setup_database() {
	echo "setting database..."
	mysql -u$db_user -p$db_password << MYSQL
USE $db_name;
TRUNCATE $db_table_g_checklist;
TRUNCATE $db_table_g_checklist_list;
TRUNCATE $db_table_g_home;
TRUNCATE $db_table_g_home_list;
TRUNCATE $db_table_g_instrument;
TRUNCATE $db_table_g_surgery;
TRUNCATE $db_table_g_patient;
TRUNCATE $db_table_g_staff;
TRUNCATE $db_table_g_process;
TRUNCATE $db_table_g_process_list;
MYSQL
}

function import_data() {
	echo "import into table..."
	cat "${file_path}${file_name}" | sed 1,3d | while read line 
	do
		#echo "$line"
		g_checklist__name=$(echo $line | cut -f 1 -d ',')
                g_checklist__update_time=$(echo $line | cut -f 3 -d ',')
                g_checklist__stb_sn=$(echo $line | cut -f 4 -d ',')

                g_checklist_list__name=$(echo $line | cut -f 5 -d ',')
                g_checklist_list__update_time=$(echo $line | cut -f 6 -d ',')
                g_checklist_list__checklist_uid=$(echo $line | cut -f 7 -d ',')
                g_checklist_list__value=$(echo $line | cut -f 8 -d ',')

                g_home__name=$(echo $line | cut -f 9 -d ',')
                g_home__update_time=$(echo $line | cut -f 11 -d ',')
                g_home__stb_sn=$(echo $line | cut -f 12 -d ',')

                g_home_list__name=$(echo $line | cut -f 13 -d ',')
                g_home_list__update_time=$(echo $line | cut -f 14 -d ',')
                g_home_list__g_home_uid=$(echo $line | cut -f 15 -d ',')

                g_instrument__thumbnail=$(echo $line | cut -f 16 -d ',')
                g_instrument__name=$(echo $line | cut -f 17 -d ',')
                g_instrument__contents=$(echo $line | cut -f 18 -d ',')

                g_surgery__name=$(echo $line | cut -f 19 -d ',')
                g_surgery__update_time=$(echo $line | cut -f 21 -d ',')
                g_surgery__g_main_home_uid=$(echo $line | cut -f 22 -d ',')

                g_patient__name=$(echo $line | cut -f 23 -d ',')
                g_patient__gender=$(echo $line | cut -f 24 -d ',')
                g_patient__age=$(echo $line | cut -f 25 -d ',')
                g_patient__dob=$(echo $line | cut -f 26 -d ',')
                g_patient__surgicalsite=$(echo $line | cut -f 27 -d ',')
                g_patient__surgicalname=$(echo $line | cut -f 28 -d ',')
                g_patient__g_surgery_uid=$(echo $line | cut -f 29 -d ',')

                g_staff__name=$(echo $line | cut -f 30 -d ',')
                g_staff__position=$(echo $line | cut -f 31 -d ',')
                g_staff__g_surery_uid=$(echo $line | cut -f 32 -d ',')

                g_process__name=$(echo $line | cut -f 33 -d ',')
                g_process__g_surgery_uid=$(echo $line | cut -f 35 -d ',')

                g_process_list__value=$(echo $line | cut -f 36 -d ',')
                g_process_list__g_process_uid=$(echo $line | cut -f 37 -d ',')

		if [ -n "$g_checklist__name" ] && [ -n "$g_checklist__update_time" ] && [ -n "$g_checklist__stb_sn" ]; then
			#echo ""
			#echo "${g_checklist__name}/${g_checklist__update_time}/${g_checklist__stb_sn}"
			echo "INSERT INTO $db_table_g_checklist VALUES (DEFAULT, '$g_checklist__name', '$g_checklist__update_time', '$g_checklist__stb_sn');"
			#echo "UPDATE g_schedule SET checklist_name = $g_checklist__name where  "
		fi

	        if [ -n "$g_checklist_list__name" ] && [ -n "$g_checklist_list__update_time" ] && [ -n "$g_checklist_list__checklist_uid" ] && [ -n "$g_checklist_list__value" ]; then
			#echo ""
			#echo "${g_checklist_list__name}/${g_checklist_list__update_time}/${g_checklist_list__checklist_stb_sn}/${g_checklist_list__value}"
			echo "INSERT INTO $db_table_g_checklist_list VALUES (DEFAULT, '$g_checklist_list__name', '$g_checklist_list__update_time', '$g_checklist_list__checklist_uid', '$g_checklist_list__value');"
		fi

		if [ -n "$g_home__name" ] && [ -n "$g_home__update_time" ] && [ -n "$g_home__stb_sn" ]; then
			echo "INSERT INTO $db_table_g_home VALUES (DEFAULT, '$g_home__name', '$g_home__update_time', '$g_home__stb_sn');"
		fi

		if [ -n "$g_home_list__name" ] && [ -n "$g_home_list__update_time" ] && [ -n "$g_home_list__g_home_uid" ]; then
			echo "INSERT INTO $db_table_g_home_list VALUES (DEFAULT, '$g_home_list__name', '$g_home_list__update_time', '$g_home_list__g_home_uid');"
		fi

		if [ -n "$g_instrument__thumbnail" ] && [ -n "$g_instrument__name" ] && [ -n "$g_instrument__contents" ]; then
			echo "INSERT INTO $db_table_g_instrument VALUES (DEFAULT, '$g_instrument__thumbnail', '$g_instrument__name', '$g_instrument__contents');"
                fi

                if [ -n "$g_surgery__name" ] && [ -n "$g_surgery__update_time" ] && [ -n "$g_surgery__g_main_home_uid" ]; then
			echo "INSERT INTO $db_table_g_surgery VALUES (DEFAULT, '$g_surgery__name', '$g_surgery__update_time', '$g_surgery__g_main_home_uid');"
                fi

                if [ -n "$g_patient__name" ] && [ -n "$g_patient__gender" ] && [ -n "$g_patient__age" ] && [ -n "$g_patient__dob" ] && [ -n "$g_patient__surgicalsite" ] && [ -n "$g_patient__surgicalname" ]  && [ -n "$g_patient__g_surgery_uid" ]; then
			echo "INSERT INTO $db_table_g_patient VALUES (DEFAULT, '$g_patient__name', '$g_patient__gender', '$g_patient__age', '$g_patient__dob', '$g_patient__surgicalsite', '$g_patient__g_surgery_uid', '$g_patient__surgicalname');"
                fi

                if [ -n "$g_staff__name" ] && [ -n "$g_staff__position" ] && [ -n "$g_staff__g_surery_uid" ]; then
			echo "INSERT INTO $db_table_g_staff VALUES(DEFAULT, '$g_staff__name', '$g_staff__position', '$g_staff__g_surery_uid') ;"
                fi

		if [ -n "$g_process__g_surgery_uid" ] && [ -n "$g_process__name" ]; then
			echo "INSERT INTO $db_table_g_process VALUES (DEFAULT, '$g_process__g_surgery_uid', '$g_process__name');"
                fi

                if [ -n "$g_process_list__value" ] && [ -n "$g_process_list__g_process_uid" ]; then
			echo "INSERT INTO $db_table_g_process_list VALUES (DEFAULT, '$g_process_list__value', '$g_process_list__g_process_uid');"
                fi

	done | mysql -u$db_user -p$db_password $db_name && flag=1

	if [ $flag -eq 1 ] ; then
	       	echo "Success Script"	
	else 
		echo "Fail Script"
	fi
}

#################
#     MAIN      #
#################

setup_database
import_data
