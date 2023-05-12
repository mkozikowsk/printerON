#!/bin/bash
job_pending=$(lpstat -W not-completed -u | wc -l)
printer_on=$(lpstat -p | grep -e 'is idle*' | wc -l)

if [ $job_pending -gt 0 ]
then
	echo "Found pending jobs. Printer -> POWER ON"
	echo "`date` -> Power ON" >> /home/pixel/Scripts/logs.txt
	python /home/pixel/Scripts/Printer_ON_Power.py
else
	echo "No pending jobs."
	last_on=$(stat -c %Y /home/pixel/Scripts/logs.txt)
	current_time=$(date +%s)
	time_diff=$((current_time - last_on))
	if [ $time_diff -gt 1800 ] && [ $printer_on -gt 0 ]
	then
		echo "Printer -> Power OFF"
		echo "`date` -> Power OFF" >> /home/pixel/Scripts/logs.txt
		python /home/pixel/Scripts/Printer_OFF_Power.py
	else
		echo "Less than 30min after power on or printer is already off."
	fi
fi

