#!/bin/bash 
db_menu() {
	local db_name=$1
	PS3="Choose an options: "
	options=("Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Back")

	select choice in "${options[@]}"; do
		case $REPLY in 
			1) create_table "$db_name" ;;
			2) list_tables "$db_name" ;;
			3) drop_table "$db_name" ;;
			4) insert_into_table "$db_name" ;;
			5) select_from_table "$db_name" ;;
		        6) delete_from_table "$db_name" ;;
			7) update_table "$db_name" ;;
			8) echo "you are in main menu"; break ;;
			*) echo "Invalid option. Try again." ;;
		esac 
	done
}




main_menu() {
	PS3="Choose an option: "
	options=("Create Database" "List Databases " "Connect to Database"  "Drop Database" "Exit")
	select choice in "${options[@]}"; do 
		case $REPLY in 
			1) create_database ;;
			2) list_databases ;;
			3) connect_database ;;
			4) drop_database ;;      
			5) exit 0 ;;
			*) echo "Invalid option . Try again." ;;

		esac
	done 
}

