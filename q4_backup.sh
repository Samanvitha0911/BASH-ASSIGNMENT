

echo "=== AUTOMATED BACKUP SCRIPT ==="
echo ""

read -p "Enter directory to backup: " source_dir

if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi

read -p "Enter backup destination: " dest_dir

mkdir -p "$dest_dir"

echo ""
echo "Backup Type:"
echo "1. Simple copy"
echo "2. Compressed archive (tar.gz)"
read -p "Enter choice: " btype

timestamp=$(date +%Y%m%d_%H%M%S)
backup_name="backup_${timestamp}"

start_time=$(date +%s)

echo ""
echo "[*] Starting backup..."
echo "[*] Source: $source_dir"
echo "[*] Destination: $dest_dir"

if [ "$btype" == "1" ]; then
    echo "[*] Copying files..."
    cp -r "$source_dir" "$dest_dir/$backup_name"
    final_path="$dest_dir/$backup_name"
elif [ "$btype" == "2" ]; then
    echo "[*] Creating compressed archive..."
    tar -czf "$dest_dir/${backup_name}.tar.gz" "$source_dir" 2>/dev/null
    final_path="$dest_dir/${backup_name}.tar.gz"
else
    echo "Invalid choice."
    exit 1
fi
if [ $? -eq 0 ]; then
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    size=$(du -sh "$final_path" | cut -f1)

    echo ""
    echo "Backup completed successfully!"
    echo ""
    echo "Backup Details:"
    echo " File     : $(basename $final_path)"
    echo " Location : $dest_dir"
    echo " Size     : $size"
    echo " Time     : ${duration} second(s)"
else
    echo "Backup failed! Something went wrong."
    exit 1
fi
