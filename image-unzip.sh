#!/bin/bash

# Loop through all zip files in the current directory
for zipfile in *.zip; do
    # Check if the zip file is part of a split archive
    if zipinfo "$zipfile" | grep -q "splitting"; then
        echo "Reassembling split zip file: $zipfile"

        # Reassemble the split zip file
        zip -s 0 "$zipfile" --out "reassembled_$zipfile"
        
        # Unzip the reassembled file
        unzip "reassembled_$zipfile"
        
        # Remove the reassembled file
        rm "reassembled_$zipfile"
    else
        # If it's not split, unzip it directly
        echo "Unzipping: $zipfile"
        unzip "$zipfile"
    fi
done

# Remove all the original zip files (including split parts like .z01, .z02, etc.)
echo "Removing all zip files..."
rm -f *.zip *.z0*

echo "Unzipping complete and all zip files removed!"
