
while true; do
    echo ""
    echo "===== FILE & DIRECTORY MANAGER ====="
    echo "1. List files in current directory"
    echo "2. Create a new directory"
    echo "3. Create a new file"
    echo "4. Delete a file"
    echo "5. Rename a file"
    echo "6. Search for a file"
    echo "7. Count files and directories"
    echo "8. View file permissions"
    echo "9. Copy a file"
    echo "0. Exit"
    echo ""
    read -p "Choose an option: " choice

    case $choice in
        1)
            echo ""
            ls -lh
            ;;
        2)
            read -p "Enter directory name: " dirname
            if [ -d "$dirname" ]; then
                echo "That directory already exists!"
            else
                mkdir "$dirname"
                echo "Directory '$dirname' created."
            fi
            ;;
        3)
            read -p "Enter file name: " fname
            if [ -f "$fname" ]; then
                echo "File already exists!"
            else
                touch "$fname"
                echo "File '$fname' created."
            fi
            ;;
        4)
            read -p "Enter file to delete: " fname
            if [ ! -f "$fname" ]; then
                echo "File not found!"
            else
                read -p "Are you sure you want to delete '$fname'? (yes/no): " confirm
                if [ "$confirm" == "yes" ]; then
                    rm "$fname"
                    echo "File deleted."
                else
                    echo "Cancelled."
                fi
            fi
            ;;
        5)
            read -p "Enter current file name: " oldname
            if [ ! -f "$oldname" ]; then
                echo "File '$oldname' not found!"
            else
                read -p "Enter new file name: " newname
                mv "$oldname" "$newname"
                echo "Renamed '$oldname' to '$newname'."
            fi
            ;;
        6)
            read -p "Enter filename or pattern to search: " pattern
            echo "Searching..."
            find . -name "*$pattern*" 2>/dev/null
            ;;
        7)
            num_files=$(find . -maxdepth 1 -type f | wc -l)
            num_dirs=$(find . -maxdepth 1 -type d | wc -l)
            # subtract 1 because find counts current dir itself
            num_dirs=$((num_dirs - 1))
            echo "Files: $num_files"
            echo "Directories: $num_dirs"
            ;;
        8)
            read -p "Enter file or directory name: " fname
            if [ ! -e "$fname" ]; then
                echo "Not found!"
            else
                ls -la "$fname"
            fi
            ;;
        9)
            read -p "Enter source file: " src
            if [ ! -f "$src" ]; then
                echo "Source file not found!"
            else
                read -p "Enter destination name: " dst
                cp "$src" "$dst"
                echo "Copied '$src' to '$dst'."
            fi
            ;;
        0)
            echo "Goodbye!"
            break
            ;;
        *)
            echo "Invalid option, try again."
            ;;
    esac
done
