# ThinkPad RyzenADJ Battery Saver

A lightweight bash script utilizing `ryzenadj` and `wofi` to dynamically manage TDP (Thermal Design Power) profiles on AMD-based laptops. Designed primarily for Wayland compositors like Hyprland, this tool provides a fast, graphical menu to switch between custom power profiles—allowing you to maximize battery life or boost performance on the fly.

While originally configured and tested on a Lenovo ThinkPad T14 Gen 2 (AMD Ryzen 5 Pro 5650U), the script is highly customizable and works seamlessly across most AMD APUs supported by `ryzenadj`.

##  Features

*   **Quick Access Menu:** Uses `wofi` (can be adapted for `rofi`) to display a clean graphical selection menu.
*   **Custom TDP Profiles:** 5 pre-configured profiles ranging from ultra-low power (2W) to full performance (25W).
*   **Passwordless Execution:** Configured to run silently in the background without prompting for `sudo` passwords.
*   **Status Bar Integration:** Outputs the current active profile to `/tmp/perfil_tdp`, making it trivial to display your current power state in status bars like Waybar.

## Prerequisites

Ensure you have the following packages installed on your system:

*   `ryzenadj` (to apply the TDP limits)  #you can find it here: https://github.com/flygoat/ryzenadj
*   `wofi` (for the graphical menu)  #you can find it here: https://github.com/SimplyCEO/wofi
*   `polkit` / `pkexec` (as a fallback execution method) #install polkit: https://github.com/polkit-org/polkit

## Installation & Setup

### 1. clone the Repository

    Bash
   
     git clone https://github.com/Julcal008/thinkpad-savebatteryryzenadj.git
     cd thinkpad-savebatteryryzenadj

### 2. Make the Script Executable

*   Grant execution permissions to the script:

        Bash
        
        chmod +x tdp_menu.sh

*  (Optional) Move the script to a directory in your $PATH for easier access, such as ~/.local/bin/ :

        mkdir -p ~/.local/bin
        mv tdp-menu.sh ~/.local/bin/
    
### 3. Configure Passwordless sudo for RyzenADJ

*   To allow the script to change CPU power limits without asking for your password every time, you need to create a specific sudoers rule.
    Open the sudoers directory safely using visudo:

        Bash
 
        sudo visudo /etc/sudoers.d/ryzenadj_nopasswd

*   Add the following line to the file, save, and exit:
 
        ALL ALL=(ALL:ALL) NOPASSWD: /usr/bin/ryzenadj

    (f your ryzenadj binary is located somewhere else, like /usr/local/bin/ryzenadj, adjust the path accordingly. You can find the path by running which ryzenadj)

### 4. Keybinding in Hyprland

*   To trigger the menu easily, add a keybinding to your hyprland.conf file

    ### in hyprland.conf:

        # Open TDP Menu with Super + Shift + P
        bind = $mainMod SHIFT, P, exec, ~/.local/bin/tdp-menu.sh  #change ~/.local/bin/tdp-menu.sh to your tdp-menu.sh Path

###    Waybar Integration

*   Since the script writes the current profile to /tmp/perfil_tdp, you can easily display your current power profile in Waybar. Add a custom module to your waybar/config file:
    ### in waybar/config file:

        "custom/tdp": {
        "exec": "cat /tmp/perfil_tdp",
        "interval": 5,
        "format": "⚡ {}", 
        "tooltip": false
        }
        // feel free to change this values to your like.
        // Don't forget to add "custom/tdp" to your modules-right or modules-left array!

###   Customization

*   You can easily modify the script to match your specific CPU's capabilities or your personal preferences.
    Open tdp-menu.sh and edit the Options variable and the corresponding apply_tdp values within the case statement. The values are written in milliwatts (e.g., 12000 = 12 Watts).

## Bash

     //Example: Changing the Balanced profile to 15W instead of 12W
    "Balanced (15W)")
    apply_tdp --stapm-limit=15000 --fast-limit=15000 --slow-limit=15000
    echo "Balanced (15W)" > /tmp/perfil_tdp ;;


## Final Notes

*  this project was somethin i did to extend the battery life of my thinkpad, you can use it and see if it works for you. This is not going to make any miracle but can help to improve the battery for whatever case you need it
   that could be maximum battery or maximum performance. 