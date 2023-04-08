#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Get current script path
extract_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

VMOPTIONS_FILENAME="BurpSuitePro.vmoptions"
KEYGEN_JAR_FILENAME="BurpLoaderKeygen.jar"

function append_line() {
    filename=$1
    line=$2
    
    
    # Check if the line exists in the file
    if grep -qsF -- "$line" "$filename"; then
        echo "Already Patched!"
        return 0
    else
        # Append the line to the file
        echo "$line" >> "$filename"
        return 0
    fi
}

# Find all BurpSuite installed on the system
echo "[+] Finding Burp Suite Installations..."
installs=$(find / -type f -name $VMOPTIONS_FILENAME -printf "%h\n" 2>/dev/null || true)

# Check if we found any installations
if [[ -z "$installs" ]]; then
    echo "[!] Couldn't find the Burp Suite installation."
    exit 1
fi

# Prompt the user to choose a file
echo "[?] Choose Installation:"
select burp_dir in "${installs[@]}"; do
    vmoptions="$burp_dir/$VMOPTIONS_FILENAME"
    if [[ -n "$vmoptions" ]]; then
        echo "[+] Patching $vmoptions..."
        # Add the activation file to the vmoptions file
        append_line "$vmoptions" "-include-options activation.vmoptions"

        
        # Create the activation file
        echo "[+] Creating 'activation.vmoptions' file..."
        activation_file="$burp_dir/activation.vmoptions"
        append_line "$activation_file" "-noverify"
        append_line "$activation_file" "-javaagent:$KEYGEN_JAR_FILENAME"
        append_line "$activation_file" "--add-opens=java.base/java.lang=ALL-UNNAMED"
        append_line "$activation_file" "--add-opens=java.desktop/javax.swing=ALL-UNNAMED"
        append_line "$activation_file" "--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED"
        append_line "$activation_file" "--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED"
        append_line "$activation_file" "--add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED"

        # Download the keygen jar file
        echo "[+] Copying $KEYGEN_JAR_FILENAME file..."
        cp "$extract_path/$KEYGEN_JAR_FILENAME" "$burp_dir/$KEYGEN_JAR_FILENAME"

        echo "[+] Finished!"
        echo "
Activation Instructions: 
    1. Run the keygen
    2. Copy the activation code to burp and proceed
    3. Click "Manual Activation"
    4. Copy Activation request to the keygen
    5. Copy the generated activation response to burp and activate
    6. That's it ;)

        "

        read -p "Press [Enter] key to start BurpSuite and the Keygen to start the activation process..."
        cd "$burp_dir"
        echo "[+] Starting Burp Suite..."
        "$burp_dir/BurpSuitePro" &
        echo "[+] Starting the keygen..."
        "$burp_dir/jre/bin/java" -jar "$burp_dir/$KEYGEN_JAR_FILENAME" &
        break
    else
        echo "Invalid selection. Please choose again."
    fi
done

exit 0
