#!/bin/bash

# Function to display a message and wait for user input
ask_minutes() {
    read -p "Enter the number of minutes after which the device should power off: " minutes
}

# Function to power off the device after specified minutes
power_off() {
    echo "Device will power off in $1 minutes."
    sleep "$1"m && echo "Powering off..." && sudo shutdown -h now
}

# Main program
clear
echo "Welcome to Device Power Off Scheduler"
ask_minutes

# Loop to handle invalid input
while ! [[ "$minutes" =~ ^[0-9]+$ ]]; do
    echo "Invalid input. Please enter a valid number of minutes."
    ask_minutes
done

echo "Device will power off in $minutes minutes."
read -p "Do you want to proceed? (yes/no): " choice

case "$choice" in
    yes|YES|y|Y)
        power_off "$minutes"
        ;;
    no|NO|n|N)
        echo "Operation canceled."
        ;;
    *)
        echo "Invalid choice. Operation canceled."
        ;;
esac
