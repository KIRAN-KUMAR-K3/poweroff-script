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

# Function to cancel scheduled power-off
cancel_power_off() {
    echo "Cancelling scheduled power-off."
    sudo shutdown -c
}

# Main program
clear
echo "Welcome to Device Power Off Scheduler"

# Check if there's an existing scheduled power-off
if sudo shutdown -q --list | grep -q "shut down"; then
    echo "There is an existing scheduled power-off."
    read -p "Do you want to cancel it? (yes/no): " cancel_choice

    case "$cancel_choice" in
        yes|YES|y|Y)
            cancel_power_off
            ;;
        no|NO|n|N)
            ;;
        *)
            echo "Invalid choice. Proceeding with new schedule."
            ;;
    esac
fi

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
