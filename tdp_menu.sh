#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/$(id -u)

Options="Videos (2W)\nPower_saver (4W)\nPower_saver_balanced (7W)\nBalanced (12W)\nPerformance (25W)" #these are the options that will be displayed in the menu, feel free to change the values to your liking.

Choice=$(echo -e "$Options" | wofi --dmenu --cache-file /dev/null --p "Energy Profile:") #this line will display the menu with the options defined above, and store the selected option in the variable Choice.

apply_tdp() {
    sudo -n ryzenadj "$@" 2>/dev/null || pkexec ryzenadj "$@" #this function will apply the selected TDP profile using ryzenadj, it will try to use sudo first, if it fails it will use pkexec, and it will suppress any error messages.
}

case $Choice in
    "Videos (2W)")
        apply_tdp --stapm-limit=2000 --fast-limit=2000 --slow-limit=2000  #i created this profile for videos, so the consumption is lower and even if the system feels slow, the idea is to put it only whem watching a video.
        echo "Videos (2W)" > /tmp/perfil_tdp ;;
    "Power_saver (4W)")
        apply_tdp --stapm-limit=4000 --fast-limit=4000 --slow-limit=4000 #depending on your cpu your system can feel slower, but is good enough for light tasks like browsing, reading, etc. Feel free to change the values to your liking.
        echo "Power_saver (4W)" > /tmp/perfil_tdp ;;
    "Power_saver_balanced (7W)")
        apply_tdp --stapm-limit=7000 --fast-limit=7000 --slow-limit=7000 #this profile is a balance between performance and power saving, it can be used for light tasks and even some games, the system can feel normal but feel free to change the values.
        echo "Power_saver_balanced (7W)" > /tmp/perfil_tdp ;;
    "Balanced (12W)")
        apply_tdp --stapm-limit=12000 --fast-limit=12000 --slow-limit=12000 #this profile is perfect if you want good performance but without so much power consumption and heat, not god enough to save battery but is balanced, feel free to change the values to your liking.
        echo "Balanced (12W)" > /tmp/perfil_tdp ;;
    "Performance (25W)")
        apply_tdp --stapm-limit=25000 --fast-limit=25000 --slow-limit=25000 #this profile is for when you want the best performance possible, but it will consume more power and generate more heat, feel free to change the values to your liking.
        echo "Performance (25W)" > /tmp/perfil_tdp ;;
esac
