#!/bin/bash

# Define the base name of the zip files
BASE_NAME="volatility3memory.zip"

# Define the output combined zip file
COMBINED_ZIP="combined_volatility3memory.zip"

# Check if there are any split zip files
if ls ${BASE_NAME}.* 1> /dev/null 2>&1; then
    echo "Joining split zip files into ${COMBINED_ZIP}..."
    
    # Concatenate the split zip files into one combined zip file
    cat ${BASE_NAME}.* > ${COMBINED_ZIP}
    
    echo "Combined zip file created successfully."

    # Check if the combined file was created successfully
    if [ -f ${COMBINED_ZIP} ]; then
        echo "Unzipping ${COMBINED_ZIP}..."
        
        # Unzip the combined zip file
        unzip ${COMBINED_ZIP}
        
        # Check if the unzip was successful
        if [ $? -eq 0 ]; then
            echo "Unzipped successfully."

            # Delete all the zip files after successful unzipping
            echo "Deleting zip files..."
            rm -f ${BASE_NAME}.* ${COMBINED_ZIP}
            
            if [ $? -eq 0 ]; then
                echo "All zip files deleted successfully."
            else
                echo "Error: Failed to delete the zip files."
            fi
        else
            echo "Error: Failed to unzip the file."
        fi
    else
        echo "Error: Failed to create the combined zip file."
    fi
else
    echo "Error: No split zip files found."
fi

sleep 5
clear
echo ""
echo ""
echo "volatility3 sample memory images are ready.!"
ls -lh
