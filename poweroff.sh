#!/bin/bash

# Function to schedule power-off
schedule_power_off() {
    # Prompt user to enter the number of minutes to schedule power-off
    minutes=$(zenity --entry --title="Schedule Power-Off" --text="Enter the number of minutes to schedule power-off:" --entry-text "60")
    
    # Validate user input
    if [[ -z $minutes ]]; then
        zenity --error --text="Invalid input. Please enter a valid number of minutes."
        return
    fi

    # Confirm power-off schedule
    zenity --question --title="Confirm Power-Off" --text="Are you sure you want to schedule a power-off in $minutes minutes?"

    # If user confirms, schedule power-off
    if [[ $? -eq 0 ]]; then
        sudo shutdown -h +$minutes
        zenity --info --text="Power-off scheduled in $minutes minutes."
    fi
}

# Function to cancel power-off
cancel_power_off() {
    # Prompt user to confirm power-off cancellation
    zenity --question --title="Cancel Power-Off" --text="Are you sure you want to cancel the scheduled power-off?"

    # If user confirms, cancel power-off
    if [[ $? -eq 0 ]]; then
        sudo shutdown -c
        zenity --info --text="Scheduled power-off cancelled."
    fi
}

# Main menu
choice=$(zenity --list --title="Power-Off Scheduler" --text="Choose an option:" --column="Options" "Schedule Power-Off" "Cancel Scheduled Power-Off" "Exit")

# Perform action based on user choice
case $choice in
    "Schedule Power-Off")
        schedule_power_off
        ;;
    "Cancel Scheduled Power-Off")
        cancel_power_off
        ;;
    "Exit")
        exit
        ;;
    *)
        zenity --error --text="Invalid choice."
        ;;
esac
