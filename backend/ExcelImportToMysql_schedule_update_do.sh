#!/bin/bash

file="schedule_update.csv"
file_name="schedule_update.csv"
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
	
function setup_database() {
	echo "setting database..."
	echo -n "enter mysql password: "
	read db_password
	mysql -u$db_user -p${db_password} << MYSQL
USE $db_name;
MYSQL
}

function import_data() {
	echo "import into table..."
	iter=0
	cat "${file_path}${file_name}" | sed 1,3d | while read line 
	do
		((iter++))
		#echo "$line"
		g_checklist__name=$(echo $line | cut -f 1 -d ',')
                g_checklist__update_time=$(echo $line | cut -f 2 -d ',')
                g_checklist__stb_sn=$(echo $line | cut -f 3 -d ',')

                g_checklist_list__name=$(echo $line | cut -f 4 -d ',')
                g_checklist_list__update_time=$(echo $line | cut -f 5 -d ',')
                g_checklist_list__checklist_stb_sn=$(echo $line | cut -f 6 -d ',')
                g_checklist_list__value=$(echo $line | cut -f 7 -d ',')

                g_home__name=$(echo $line | cut -f 8 -d ',')
                g_home__update_time=$(echo $line | cut -f 9 -d ',')
                g_home__stb_sn=$(echo $line | cut -f 10 -d ',')

                g_home_list__name=$(echo $line | cut -f 11 -d ',')
                g_home_list__update_time=$(echo $line | cut -f 12 -d ',')
                g_home_list__g_home_stb_sn=$(echo $line | cut -f 13 -d ',')

                g_instrument__thumbnail=$(echo $line | cut -f 14 -d ',')
                g_instrument__name=$(echo $line | cut -f 15 -d ',')
                g_instrument__contents=$(echo $line | cut -f 16 -d ',')

                g_surgery__name=$(echo $line | cut -f 17 -d ',')
                g_surgery__update_time=$(echo $line | cut -f 19 -d ',')
                g_surgery__g_main_home_stb_sn=$(echo $line | cut -f 20 -d ',')

                g_patient__name=$(echo $line | cut -f 21 -d ',')
                g_patient__gender=$(echo $line | cut -f 22 -d ',')
                g_patient__age=$(echo $line | cut -f 23 -d ',')
                g_patient__dob=$(echo $line | cut -f 24 -d ',')
                g_patient__surgicalsite=$(echo $line | cut -f 25 -d ',')
                g_patient__surgicalname=$(echo $line | cut -f 26 -d ',')
                g_patient__g_main_home_stb_sn=$(echo $line | cut -f 27 -d ',')
                g_patient__g_surgery_uid=$(echo $line | cut -f 28 -d ',')

                g_staff__name=$(echo $line | cut -f 29 -d ',')
                g_staff__position=$(echo $line | cut -f 30 -d ',')
                g_staff__g_surery_uid=$(echo $line | cut -f 31 -d ',')

                g_process__name=$(echo $line | cut -f 32 -d ',')
                g_process__g_surgery_uid=$(echo $line | cut -f 34 -d ',')

                g_process_list__value=$(echo $line | cut -f 35 -d ',')
                g_process_list__g_process_uid=$(echo $line | cut -f 36 -d ',')


		if [ -n "$g_checklist__name" ] && [ -n "$g_checklist__update_time" ] && [ -n "$g_checklist__stb_sn" ]; then
			#echo ""
			#echo "${g_checklist__name}/${g_checklist__update_time}/${g_checklist__stb_sn}"
			echo "UPDATE $db_table_g_checklist SET name = '$g_checklist__name' where uid = $iter;"
			echo "UPDATE $db_table_g_checklist SET update_time = '$g_checklist__update_time' where uid = $iter;"
			echo "UPDATE $db_table_g_checklist SET stb_sn = '$g_checklist__stb_sn' where uid = $iter;"
		fi

	        if [ -n "$g_checklist_list__name" ] && [ -n "$g_checklist_list__update_time" ] && [ -n "$g_checklist_list__checklist_stb_sn" ] && [ -n "$g_checklist_list__value" ]; then
			#echo ""
			#echo "${g_checklist_list__name}/${g_checklist_list__update_time}/${g_checklist_list__checklist_stb_sn}/${g_checklist_list__value}"
			echo "UPDATE $db_table_g_checklist_list SET name = '$g_checklist_list__name' where uid = $iter;"
			echo "UPDATE $db_table_g_checklist_list SET update_time = '$g_checklist_list__update_time' where uid = $iter;"
			echo "UPDATE $db_table_g_checklist_list SET checklist_stb_sn = '$g_checklist_list__checklist_stb_sn' where uid = $iter;"
		fi

		if [ -n "$g_home__name" ] && [ -n "$g_home__update_time" ] && [ -n "$g_home__stb_sn" ]; then
			echo "UPDATE $db_table_g_home SET name = '$g_home__name' where uid = $iter;"
			echo "UPDATE $db_table_g_home SET update_time = '$g_home__update_time' where uid = $iter;"
			echo "UPDATE $db_table_g_home SET stb_sn = '$g_home__stb_sn' where uid = $iter;"
		fi

		if [ -n "$g_home_list__name" ] && [ -n "$g_home_list__update_time" ] && [ -n "$g_home_list__g_home_stb_sn" ]; then
			echo "UPDATE $db_table_g_home_list SET name = '$g_home_list__name' where uid = $iter;"
			echo "UPDATE $db_table_g_home_list SET update_time = '$g_home_list__update_time' where uid = $iter;"
			echo "UPDATE $db_table_g_home_list SET g_home_stb_sn = '$g_home_list__g_home_stb_sn' where uid = $iter;"
		fi

		if [ -n "$g_instrument__thumbnail" ] && [ -n "$g_instrument__name" ] && [ -n "$g_instrument__contents" ]; then
                        echo "UPDATE $db_table_g_instrument SET thumbnail = '$g_instrument__thumbnail' where uid = $iter;"
                        echo "UPDATE $db_table_g_instrument SET name = '$g_instrument__name' where uid = $iter;"
                        echo "UPDATE $db_table_g_instrument SET contents = '$g_instrument__contents' where uid = $iter;"
                fi

		if [ -n "$g_surgery__name" ] && [ -n "$g_surgery__update_time" ] && [ -n "$g_surgery__g_main_home_stb_sn" ]; then
                        echo "UPDATE $db_table_g_surgery SET name = '$g_surgery__name' where uid = $iter;"
                        echo "UPDATE $db_table_g_surgery SET update_time = '$g_surgery__update_time' where uid = $iter;"
                        echo "UPDATE $db_table_g_surgery SET g_main_home_stb_sn = '$g_surgery__g_main_home_stb_sn' where uid = $iter;"
                fi

		if [ -n "$g_patient__name" ] && [ -n "$g_patient__gender" ] && [ -n "$g_patient__age" ] && [ -n "$g_patient__dob" ] && [ -n "$g_patient__surgicalsite" ] && [ -n "$g_patient__surgicalname" ] && [ -n "$g_patient__g_main_home_stb_sn" ] && [ -n "$g_patient__g_surgery_uid" ]; then
                        echo "UPDATE $db_table_g_patient SET name = '$g_patient__name' where uid = $iter;"
                        echo "UPDATE $db_table_g_patient SET gender = '$g_patient__gender' where uid = $iter;"
                        echo "UPDATE $db_table_g_patient SET age = '$g_patient__age' where uid = $iter;"
			echo "UPDATE $db_table_g_patient SET dob = '$g_patient__dob' where uid = $iter;"
                        echo "UPDATE $db_table_g_patient SET surgicalsite = '$g_patient__surgicalsite' where uid = $iter;"
                        echo "UPDATE $db_table_g_patient SET surgicalname = '$g_patient__surgicalname' where uid = $iter;"
			echo "UPDATE $db_table_g_patient SET g_main_home_stb_sn = '$g_patient__g_main_home_stb_sn' where uid = $iter;"
                        echo "UPDATE $db_table_g_patient SET g_surgery_uid = '$g_patient__g_surgery_uid' where uid = $iter;"
                fi

		if [ -n "$g_staff__name" ] && [ -n "$g_staff__position" ] && [ -n "$g_staff__g_surery_uid" ]; then
                        echo "UPDATE $db_table_g_staff SET name = '$g_staff__name' where uid = $iter;"
                        echo "UPDATE $db_table_g_staff SET position = '$g_staff__position' where uid = $iter;"
                        echo "UPDATE $db_table_g_staff SET g_surgery_uid = '$g_staff__g_surery_uid' where uid = $iter;"
                fi

		if [ -n "$g_process__g_surgery_uid" ] && [ -n "$g_process__name" ]; then
                        echo "UPDATE $db_table_g_process SET g_surgery_uid = '$g_process__g_surgery_uid' where uid = $iter;"
                        echo "UPDATE $db_table_g_process SET name = '$g_process__name' where uid = $iter;"
                fi

		if [ -n "$g_process_list__value" ] && [ -n "$g_process_list__g_process_uid" ]; then
                        echo "UPDATE $db_table_g_process_list SET value = '$g_process_list__value' where uid = $iter;"
                        echo "UPDATE $db_table_g_process_list SET g_process_uid = '$g_process_list__g_process_uid' where uid = $iter;"
                fi

	done | mysql -u$db_user -p${db_password} $db_name
}

#################
#     MAIN      #
#################

setup_database
import_data
