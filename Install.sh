#!/bin/bash

CURRENT_PROGRESS=0

# Встановлення затримки в оновлені прогресу
function delay()
{
    sleep 0.1;
}

# Функція для відображення progressbar
function progress()
{
    PARAM_PROGRESS=$1;
    PARAM_PHASE=$2;

    if [ $CURRENT_PROGRESS -le 0 -a $PARAM_PROGRESS -ge 0 ]  ; then echo -ne "[..........................] (0%)  $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 5 -a $PARAM_PROGRESS -ge 5 ]  ; then echo -ne "[#.........................] (5%)  $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 10 -a $PARAM_PROGRESS -ge 10 ]; then echo -ne "[##........................] (10%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 15 -a $PARAM_PROGRESS -ge 15 ]; then echo -ne "[###.......................] (15%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 20 -a $PARAM_PROGRESS -ge 20 ]; then echo -ne "[####......................] (20%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 25 -a $PARAM_PROGRESS -ge 25 ]; then echo -ne "[#####.....................] (25%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 30 -a $PARAM_PROGRESS -ge 30 ]; then echo -ne "[######....................] (30%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 35 -a $PARAM_PROGRESS -ge 35 ]; then echo -ne "[#######...................] (35%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 40 -a $PARAM_PROGRESS -ge 40 ]; then echo -ne "[########..................] (40%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 45 -a $PARAM_PROGRESS -ge 45 ]; then echo -ne "[#########.................] (45%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 50 -a $PARAM_PROGRESS -ge 50 ]; then echo -ne "[##########................] (50%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 55 -a $PARAM_PROGRESS -ge 55 ]; then echo -ne "[###########...............] (55%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 60 -a $PARAM_PROGRESS -ge 60 ]; then echo -ne "[############..............] (60%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 65 -a $PARAM_PROGRESS -ge 65 ]; then echo -ne "[#############.............] (65%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 70 -a $PARAM_PROGRESS -ge 70 ]; then echo -ne "[###############...........] (70%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 75 -a $PARAM_PROGRESS -ge 75 ]; then echo -ne "[#################.........] (75%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 80 -a $PARAM_PROGRESS -ge 80 ]; then echo -ne "[####################......] (80%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 85 -a $PARAM_PROGRESS -ge 85 ]; then echo -ne "[#######################...] (85%) $PARAM_PHASE \r"  ; delay; fi;
    if [ $CURRENT_PROGRESS -le 90 -a $PARAM_PROGRESS -ge 90 ]; then echo -ne "[##########################] (100%) $PARAM_PHASE \r" ; delay; fi;
    if [ $CURRENT_PROGRESS -le 100 -a $PARAM_PROGRESS -ge 100 ];then echo -ne 'Done!                                            \n' ; delay; fi;

    CURRENT_PROGRESS=$PARAM_PROGRESS;

}

# Функція для перенесення необхідних файлів у відповідні теки
transfer_files() {
    echo "File transfer started..."
    progress 0 "Initializing file transfer..."
    # Перевірка існування теки Icons
    if [ ! -d "Icons" ]; then
        echo "An error occurred during installation."
        echo "The 'Icons' folder was not found."
        exit 1
    fi
    # Перевірка існування теки shell
    if [ ! -d "Shell" ]; then
        echo "An error occurred during installation."
        echo "The 'shell' folder was not found."
        exit 1
    fi
    # Перевірка існування теки Wallpapers
    if [ ! -d "Wallpapers" ]; then
        echo "An error occurred during installation."
        echo "The 'Wallpapers' folder was not found."
        exit 1
    fi
    # Копіюємо іконки в теку .Icons в домашній текі користувача
    mkdir -p "$HOME/.icons"
    cp -r Icons/* "$HOME/.icons/"
    progress 50 "Copying icons..."
    # Копіюємо тему в теку .themes в домашній текі користувача
    mkdir -p "$HOME/.themes"
    cp -r Shell/* "$HOME/.themes/"
    progress 70 "Copying shell themes..."
    # Копіюємо шпалери в теку Wallpapers
    # Перевірка наявності теки Wallpapers у домашній директорії
    if [ ! -d "$HOME/Wallpapers" ]; then
        mkdir -p "$HOME/Wallpapers"
    fi
    cp -r Wallpapers/* "$HOME/Wallpapers/"
    progress 100 "File transfer successful..."
}

# Функція для встановлення тем із файлів що були перенесені раніше
install_themes() {
    echo "Theme installation started..."
    progress 0 "Initializing theme installation..."
    # Встановлення піктограм
    gsettings set org.gnome.desktop.interface icon-theme 'Oranchelo'
    progress 25 "Setting up Icons..."
    # Встановлення оболонки
    gsettings set org.gnome.shell.extensions.user-theme name Lavanda-Dark
    progress 50 "Setting up shell themes..."
    # Встановлення оболонки для застарілих програм
    gsettings set org.gnome.desktop.interface gtk-theme 'Adw-dark'
    progress 75 "Setting up GTK themes..."
    # Встановлення курсора
    gsettings set org.gnome.desktop.interface cursor-theme 'Bibita-Modern-Classic'
    progress 90 "Setting up cursors..."
    # Встановлення шпалерів
    image_full_path = $HOME/Wallpapers/walpaper.jpg
    gsettings set org.gnome.desktop.background picture-uri "file://$image_full_path"
    gsettings set org.gnome.desktop.background picture-uri-dark "file://$image_full_path"
    gsettings set org.gnome.desktop.background picture-uri "$image_full_path"
    gsettings set org.gnome.desktop.background picture-uri-dark "$image_full_path"
    progress 100 "Theme installation complete."
}

# # Функція для встановлення Gnome розширень
# install_gnome_extensions() {
#     echo "Installing Gnome extensions has started..."
#     progress 0 "Initializing Gnome extensions installation..."

#     local extension_dir="$HOME/.local/share/gnome-shell/extensions"
#     local extensions=(
#         "./Extensions/quick-settings-tweaks@qwreey.zip"
#         "./Extensions/blur-my-shell@aunetx.zip"
#         "./Extensions/logomenu@aryan_k.zip"
#         "./Extensions/top-bar-organizer@julian.gse.jsts.xyz.zip"
#         "./Extensions/Vitals@CoreCoding.com.zip"
#     )

#     mkdir -p "$extension_dir"

#     # Встановлення кожного розширення
#     progress_iterator = 20

#     for ext in "${extensions[@]}"; do
#         ext_name=$(basename "$ext" .zip)
#         ext_dir="$extension_dir/$ext_name"
#         progress $progress_iterator "Installing extension: $ext_name..."
#         progress_iterator=$((progress_iterator + 20))

#         if [ -d "$ext_dir" ]; then
#             echo "Розширення $ext_name вже встановлене. Пропускаємо..."
#         else
#             unzip -qq "$ext" -d "$extension_dir"
#             echo "Встановлено розширення $ext_name"
#         fi
#     done

#     progress 100 "Installing Gnome extensions is complete..."

#     gnome-shell-extension-tool -r  # Перезавантажуємо GNOME Shell для застосування змін
# }
install_gnome_extensions() {
    echo "Installing Gnome extensions has started..."
    progress 0 "Initializing Gnome extensions installation..."

    local extensions=(
        "quick-settings-tweaks@qwreey"
        "blur-my-shell@aunetx"
        "logomenu@aryan_k"
        "top-bar-organizer@julian.gse.jsts.xyz"
        "Vitals@CoreCoding.com"
    )

    progress_iterator=20

    for ext_uuid in "${extensions[@]}"; do
        ext_dir="$HOME/.local/share/gnome-shell/extensions/$ext_uuid"
        ext_zip="./Extensions/${ext_uuid}.zip"

        if [ -d "$ext_dir" ]; then
            echo "Розширення $ext_uuid вже встановлене. Пропускаємо..."
        else
            mkdir -p "$ext_dir"
            unzip -qq "$ext_zip" -d "$ext_dir"
            echo "Встановлено розширення $ext_uuid"
            gnome-shell-extension-tool -e "$ext_uuid"
            echo "'$ext_uuid' is now enabled."
            progress $progress_iterator "Installing extension: $ext_uuid..."
            progress_iterator=$((progress_iterator + 20))
        fi
    done

    progress 100 "Installing Gnome extensions is complete..."
}

transfer_files
install_themes
install_gnome_extensions