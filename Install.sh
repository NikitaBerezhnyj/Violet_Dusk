#!/bin/bash

# Перенесення необхідних файлів у відповідні теки
echo "File transfer started..."
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
echo "Icons moved"
# Копіюємо тему в теку .themes в домашній текі користувача
mkdir -p "$HOME/.themes"
cp -r shell/* "$HOME/.themes/"
echo "The topic has been moved"
# Копіюємо шпалери в стандартну теку Зображення та створюємо теку wallpapers
mkdir -p "$HOME/Pictures/wallpapers"
cp -r wallpapers/* "$HOME/wallpapers/"
echo "wallpapers transferred"
echo "File transfer successful..."

# Встановлення тем із файлів що були перенесені раніше
echo "Theme installation started..."
# Встановлення піктограм
gsettings set org.gnome.desktop.interface icon-theme 'Oranchelo'
echo "Icons are installed."
# Встановлення оболонки
gsettings set org.gnome.shell.extensions.user-theme name Lavanda-Dark
echo "The shell is installed"
# Встановлення оболонки для застарілих програм
gsettings set org.gnome.desktop.interface gtk-theme 'Adw-dark'
echo "The shell for gtk-3 is installed."
# Встановлення курсора
gsettings set org.gnome.desktop.interface cursor-theme 'Bibita-Modern-Classic'
echo "Cursor is set."
# Встановлення шпалерів
gsettings set org.gnome.desktop.background picture-uri file://$HOME/wallpapers/first.jpg
echo "Шпалери встановлено."
echo "Розпочато встановлення розширень Gnome..."

# Встановлення Gnome розширень
echo "Installing Gnome extensions has started..."
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
    "QSTWeak@github.com"    									# Quick Setting Tweaker
    "blur-my-shell@rockon999.github.io"    						# Blur my Shell
    "logo-menu@gnome-shell-extensions.gcampax.github.com"    	# Logo Menu
    "top-bar-organizer@phocean.net"    							# Top Bar Organizer
    "vitals@CoreCoding.com"    									# Vitals
)
# Встановлення кожного розширення
for extension in "${extensions[@]}"; do
    gnome-extensions install "$extension"
    echo "$extension installing complite"
done
echo "Installing Gnome extensions is complete..."
echo "The theme is installed"
echo "Thank you for installing!"

