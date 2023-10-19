#!/bin/bash

clear

echo "Welcome to Patient nurse managment system "

p=0
p_name=()
p_age=()

n=0
n_name=()
n_age=()
n_p1=()
n_p2=()




delete_patient(){
clear 
if [[ $1 -ge 0 && $1 -le $p ]]; then  
	p_name[$1]=" "
	p_age[$1]=" "

	if [[ $p -gt 0 ]]; then 

	p_name[$1]=${p_name[$p-1]}
	p_age[$1]=${p_age[$p-1]}

	p_name[$p-1]=" "
	p_age[$p-1]=" "
	
	p=$((p-1))

	fi
	
	
	echo "the new p is $p and 1 is $1"
	for ((i = 0; i < n; i++)); do
   		if [[ "${n_p1[$i]}" == "$p" ]]; then
   			echo "y1"
   			n_p1[$i]=$1
   			
   		elif [[ "${n_p2[$i]}" == "$p" ]]; then 
   			n_p2[$i]=$1
   			echo "y2"
   		fi
   		
   		if [[ "${n_p1[$i]}" == "$1" ]]; then
   			echo "y3"
   			n_p1[$i]=" "
   			
   		elif [[ "${n_p2[$i]}" == "$1" ]]; then 
   			n_p2[$i]=" "
   			echo "y4"
   		fi
   		
 	done
	
	
	
	display_patients
else 
	echo -e "invalid ID: $1"
fi
}

delete_nurse(){
clear 
if [[ $1 -ge 0 && $1 -le $n ]]; then  
	n_name[$1]=" "
	n_age[$1]=" "
	n_p1[$1]=" "
	n_p2[$1]=" "


	if [[ $n -gt 0 ]]; then 

	n_name[$1]=${n_name[$n-1]}
	n_age[$1]=${n_age[$n-1]}
	n_p1[$1]=${n_p1[$n-1]}
	n_p2[$1]=${n_p2[$n-1]}

	n_name[$n-1]=" "
	n_age[$n-1]=" "
	n_p1[$n-1]=" "
	n_p2[$n-1]=" "
	
	n=$n-1
	fi
	
	display_patients
else 
	echo -e "invalid ID: $1"
fi
}

add_paitent(){
	echo -e "Enter Patient name"
	read name
	if [[ "$name" =~ ^[a-zA-Z[:space:]]+$ ]]; then
    		cleaned_input=$(echo "$name" | tr -s ' ')
    		
	else
    		echo -e "\nThe input contains characters other than alphabets and spaces."
    		p=$p-1
		return 1
	fi
	
	read -p "Enter the age of Patient " age
	# Check if the input is a valid integer
	if [[ "$age" =~ ^[0-9]+$ ]]; then
    		# Convert the input to an integer for comparison
    		input_int=$((age))

    		if [ $input_int -gt 0 ]; then
        		p_name[$1]="$name"
        		p_age[$1]="$input_int"
        		
    		else
        		echo "The input is not greater than 0."
        		p=$p-1
        		return 2
    		fi
    		
    		

	else
	    	echo "The input is not a valid integer."
	    	p=$p-1
	    	return 3
	fi
	
}

add_nurse(){
	echo -e "Enter Nurse name"
	read name
	if [[ "$name" =~ ^[a-zA-Z[:space:]]+$ ]]; then
    		cleaned_input=$(echo "$name" | tr -s ' ')
    		
	else
    		echo -e "\nThe input contains characters other than alphabets and spaces."
    		n=$n-1
		return 1
	fi
	
	read -p "Enter the age of Nurse " age
	# Check if the input is a valid integer
	if [[ "$age" =~ ^[0-9]+$ ]]; then
    		# Convert the input to an integer for comparison
    		input_int=$((age))

    		if [ $input_int -gt 0 ]; then
    		
        		n_name[$1]="$name"
        		n_age[$1]="$input_int"
        		n_p1[$1]=" "
        		n_p2[$1]=" "
        		
    		else
        		echo "The input is not greater than 0."
        		n=$n-1
        		return 2
    		fi
    		
    		

	else
	    	echo "The input is not a valid integer."
	    	n=$n-1
	    	return 3
	fi
	
}

display_patients(){
clear
for ((i = 0; i < p; i++)); do
    echo -e "\n-------------------------------------------------------\n"
    echo -e "Patient id: $i\n"
    echo -e "Patient name ${p_name[$i]}"
    echo -e "Patient age ${p_age[$i]}"
    echo -e "\n-------------------------------------------------------\n"
 
done

}

display_nurses(){
clear
for ((i = 0; i < n; i++)); do
    echo -e "\n-------------------------------------------------------\n"
    echo -e "nurse id: $i\n"
    echo -e "nurse name ${n_name[$i]}"
    echo -e "nurse age ${n_age[$i]}"
    echo -e "nurse\'s Patient 1: ${n_p1[$i]}"
    echo -e "nurse\'s Patient 2: ${n_p2[$i]}"
    echo -e "\n-------------------------------------------------------\n"
 
done

}

edit_patient(){

clear 
if [[ $1 -ge 0 && $1 -le $p ]]; then  
	echo -e "Editing patient id:$1"
	echo -e "Patient name ${p_name[$1]}"
	echo -e "Patient age ${p_age[$1]}"
	add_paitent $1
	p=$p+1
else 
	echo -e "invalid ID: $1"
fi


}

edit_nurse(){

clear 
if [[ $1 -ge 0 && $1 -le $n ]]; then  
	echo -e "Editing nurse id:$1"
	echo -e "nurse id: $i\n"
   	echo -e "nurse name ${n_name[$i]}"
   	echo -e "nurse age ${n_age[$i]}"
 	echo -e "nurse\'s Patient 1: ${n_p1[$i]}"
  	echo -e "nurse\'s Patient 2: ${n_p2[$i]}"
	add_nurse $1
	n=$n+1
else 
	echo -e "invalid ID: $1"
fi


}

patient_menu(){

count2=1
clear
while [ $count2 -eq 1 ]; do

echo -e "\n\n Patient-Menu\n1) Add Patient\n2) Edit Patient\n3) List Patients\n4) Delete Patient\n5) Back\n\nEnter the option number "

	read u
if [[ "$u" =~ ^[0-9]+$ ]]; then
	if [ $u -eq 1 ]; then 

		add_paitent $p
		p=$p+1
	
	elif [ $u -eq 2 ]; then
		read -p "Enter the id of the patient to edit: " pid
		edit_patient $pid
		
	 
	elif [ $u -eq 3 ]; then 
	

		display_patients
	elif [ $u -eq 4 ]; then 	
		read -p "Enter the id of the patient to delete: " pid
		delete_patient $pid
	elif [ $u -eq 5 ]; then 

		count2=0
	
	else 
		echo -e "\n\nPlease enter valid integer \n"
		count2=0
	fi
else
	echo "Please enter integer as option no"
fi
done

}

nurse_menu(){

count3=1
clear
while [ $count3 -eq 1 ]; do

echo -e "\n\n Nurse-Menu\n1) Add Nurse\n2) Edit Nurse\n3) List Nurses\n4) Delete Nurse\n5) Back\n\nEnter the option number "

	read u
if [[ "$u" =~ ^[0-9]+$ ]]; then
	if [ $u -eq 1 ]; then 

		add_nurse $n
		n=$n+1
	
	elif [ $u -eq 2 ]; then
		read -p "Enter the id of the patient to edit: " pid
		edit_nurse $pid
		
	 
	elif [ $u -eq 3 ]; then 
	

		display_nurses
		
	elif [ $u -eq 4 ]; then 	
		read -p "Enter the id of the nurse to delete: " pid
		delete_nurse $pid	
		
		
	elif [ $u -eq 5 ]; then 

		count3=0
	
	else 
		echo -e "\n\nPlease enter valid integer \n"
		count3=0
	fi
else
	echo "Please enter integer as option no"
fi
done

}


assign(){
clear
read -p "enter the id of patient you want to select: " pid
if [[ "$pid" =~ ^[0-9]+$ && $pid -ge 0 ]]; then

	if [[ $pid -le p ]]; then 
		read -p "enter the id of nurse you want the patient to be added to: " nid
		
		if [[ "$nid" =~ ^[0-9]+$ && $nid -ge 0 ]]; then

			if [[ $nid -le n ]]; then 
				# patient and nurse both exists 
				
				echo " yues both exists "
				
				for ((i = 0; i < n; i++)); do
   					if [[ "${n_p1[$i]}" == "$pid" || "${n_p2[$i]}" == "$pid" ]]; then 
   						echo "this patient id:$pid is already assigned to nurse id:$i"
   						return 1
   					fi
 
				done
				
				if [[ "${n_p1[$nid]}" == " " ]]; then 
					n_p1[$nid]=$pid
				elif [[ "${n_p2[$nid]}" == " " ]]; then 
					n_p2[$nid]=$pid
				else 
					echo "this nurse already has 2 patients "
				fi
				
				
			else
				echo "nurse do not exists"
			fi

		else

			echo "The id must be non 0 integer and greater then zero"
		fi
		
		
		
	else
		echo "patient do not exist"
	fi

else

	echo "The id must be non 0 integer and greater then zero"
fi



}


display_specific_paitent(){

str_num=$1

no=$((str_num))

    echo -e "\n-------------------------------------------------------\n"
    echo -e "Patient id: $no\n"
    echo -e "Patient name ${p_name[$no]}"
    echo -e "Patient age ${p_age[$no]}"
    echo -e "\n-------------------------------------------------------\n"


}

display_patients_of_nurses(){

for ((i = 0; i < n; i++)); do
    if [[ "${n_p1[$i]}" != " " ]]; then 
    	display_specific_paitent ${n_p1[$i]}
    fi
    
    if [[ "${n_p2[$i]}" != " " ]]; then 
    	display_specific_paitent ${n_p2[$i]}
    fi
 
done

}

check_nonassigned(){
cheked=0
for ((j = 0; j < n; j++)); do
	if [[ "${n_p1[$j]}" == "$1" || "${n_p2[$j]}" == "$1" ]]; then 
		cheked=1
	fi
	
	
done

if [[ $cheked -eq 0 ]]; then 
	display_specific_paitent $1
fi
}

list_non_assigned(){
p=$((p))
for ((i = 0; i < p; i++)); do
	pno=$i
	check_nonassigned $pno
done

}

main_menu(){
count=1

while [ $count -eq 1 ]; do
	echo -e "1)Add/Edit/Delete/List Patient\n2)Add/Edit/Delete/List Nurse\n3)assign patients to nurse \n4)Report - List Nurse Patients\n5)List all the patients that are attached to any Nurse\n6)List all the patients that are not attached to any Nurse\n7) Exit\n\nEnter the option number "

	read u
if [[ "$u" =~ ^[0-9]+$ ]]; then
	if [ $u -eq 1 ]; then 
		patient_menu
	elif [ $u -eq 2 ]; then 
		nurse_menu
	elif [ $u -eq 3 ]; then
		assign
	
	elif [ $u -eq 4 ]; then
		display_nurses
		
	elif [ $u -eq 5 ]; then
		clear
		display_patients_of_nurses
	elif [ $u -eq 6 ]; then
		clear
		list_non_assigned
		
	elif [ $u -eq 7 ]; then 
		count=0
	else 
		echo -e "\n\nPlease enter valid integer \n"
		count=0
	fi
else
	echo "Please enter integer as option no"
fi
done

}


main_menu
