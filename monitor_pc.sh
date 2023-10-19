#!/bin/bash



monitor_disk_space(){
clear
while [ 1 -eq 1 ]; do
echo -e "\t\tDisk Monitoring\t press any key to stop\n\n"
df -h
if read -t 2 -n 1 key; then
    break
fi
clear
done

}

mon_top_10_p_cpu(){
clear
while [ 1 -eq 1 ]; do
echo -e "\t\tCPU Monitoring\t press any key to stop\n\n"
top -n 1 -o %CPU -b | head -n 17 | tail -n 11
if read -t 2 -n 1 key; then
   break
fi
clear
done

}
mon_top_10_p_mem(){
clear
while [ 1 -eq 1 ]; do
echo -e "\t\tMEMORY Monitoring\t press any key to stop\n\n"
top -b -n 1 -o %MEM | head -n 17 | tail -n 11
if read -t 2 -n 1 key; then
    break

fi
clear
done

}

mon_all(){
clear
while [ 1 -eq 1 ]; do
echo -e "\t\tMonitoring ALL\t press any key to stop\n\n"
echo -e "\t\tDisk Monitoring\n\n"
df -h
echo -e "\n\n\t\tCPU Monitoring\n\n"
top -n 1 -o %CPU -b | head -n 17 | tail -n 11
echo -e "\n\n\t\tMEMORY Monitoring\n\n"
top -b -n 1 -o %MEM | head -n 17 | tail -n 11
if read -t 2 -n 1 key; then
    break

fi
clear
done

}
main(){

toilet "Wellcome to CPU-MON"
count=1

while [ $count -eq 1 ]; do
	echo -e "1) monitor disk space\n2) Top 10 cpu process consumption \n3) Top 10 process memory consumption \n4) all\n5) Exit\n"

	read u

	if [[ "$u" =~ ^[0-9]+$ ]]; then
		if [ $u -eq 1 ]; then 
			monitor_disk_space
		elif [ $u -eq 2 ]; then 
			mon_top_10_p_cpu	
		elif [ $u -eq 3 ]; then
			mon_top_10_p_mem
		
		elif [ $u -eq 4 ]; then
			mon_all
		elif [ $u -eq 5 ]; then
			toilet "Bye :("
			exit
		else 
			echo -e "\n\nPlease enter valid integer \n"
			count=0
		fi
	else
		echo "Please enter integer as option no"
	fi
	
	clear 
	toilet "Wellcome to CPU-MON"
done
}
 
 
main
