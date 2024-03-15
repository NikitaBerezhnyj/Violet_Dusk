#!/bin/bash

# Імпортуємо функції з ProgressBar.sh
source ./ProgressBar.sh

# Функція для перенесення необхідних файлів у відповідні теки
transfer_files() {
    echo "File transfer started..."
    progress 0 "Initializing file transfer..."
    # Перевірка існування теки icons
    if [ ! -d "icons" ]; then
        echo "An error occurred during installation."
        echo "The 'icons' folder was not found."
        exit 1
    fi
    # Перевірка існування теки shell
    if [ ! -d "shell" ]; then
        echo "An error occurred during installation."
        echo "The 'shell' folder was not found."
        exit 1
    fi
    # Перевірка існування теки wallpapers
    if [ ! -d "wallpapers" ]; then
        echo "An error occurred during installation."
        echo "The 'wallpapers' folder was not found."
        exit 1
    fi
    # Копіюємо іконки в теку .icons в домашній текі користувача
    mkdir -p "$HOME/.icons"
    cp -r icons/* "$HOME/.icons/"
    progress 50 "Copying icons..."
    # Копіюємо тему в теку .themes в домашній текі користувача
    mkdir -p "$HOME/.themes"
    cp -r shell/* "$HOME/.themes/"
    progress 70 "Copying shell themes..."
    # Копіюємо шпалери в теку Wallpapers
    # Перевірка наявності теки Wallpapers у домашній директорії
    if [ ! -d "$HOME/Wallpapers" ]; then
        echo "The 'Wallpapers' tag is not found."
        echo "Creating the Wallpapers theme..."
        mkdir -p "$HOME/Wallpapers"
        echo "The 'Wallpapers' theme is created."
    fi
    cp -r wallpapers/* "$HOME/wallpapers/"
    progress 100 "File transfer successful..."
}

# Функція для встановлення тем із файлів що були перенесені раніше
install_themes() {
    echo "Theme installation started..."
    progress 0 "Initializing theme installation..."
    # Встановлення піктограм
    gsettings set org.gnome.desktop.interface icon-theme 'Oranchelo'
    progress 25 "Setting up icons..."
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
    gsettings set org.gnome.desktop.background picture-uri file://$HOME/wallpapers/first.jpg
    progress 100 "Theme installation complete."
}

# Функція для встановлення Gnome розширень
install_gnome_extensions() {
    echo "Installing Gnome extensions has started..."
    progress 0 "Initializing Gnome extensions installation..."
    # Перевірка наявності програми gnome-extensions
    if ! which gnome-extensions &> /dev/null; then
        echo "The gnome-extensions program is installed..."
        case "$(uname -s)" in
            Linux)
                if [ -x "$(command -v apt)" ]; then
                    sudo apt install gnome-shell-extensions
                elif [ -x "$(command -v pacman)" ]; then
                    sudo pacman -S gnome-shell-extensions
                elif [ -x "$(command -v dnf)" ]; then
                    sudo dnf install gnome-shell-extensions
                else
                    echo "System is not supported"
                    exit 1
                fi
                ;;
            *)
                echo "System is not supported"
                exit 1
                ;;
        esac
    fi
    # Список розширень для встановлення
    extensions=(
        "QSTWeak@github.com"                                   # Quick Setting Tweaker
        "blur-my-shell@rockon999.github.io"                    # Blur my Shell
        "logo-menu@gnome-shell-extensions.gcampax.github.com"  # Logo Menu
        "top-bar-organizer@phocean.net"                        # Top Bar Organizer
        "vitals@CoreCoding.com"                                # Vitals
    )
    # Встановлення кожного розширення
    Iterator = 20
    for extension in "${extensions[@]}"; do
        gnome-extensions install "$extension"
        progress $Iterator "Installing extension: $extension..."
        Iterator=$((Iterator + 10))
    done
    progress 100 "Installing Gnome extensions is complete..."
}

transfer_files
install_themes
install_gnome_extensions