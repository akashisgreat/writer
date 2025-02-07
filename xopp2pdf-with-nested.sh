#!/bin/bash

# Define input and output base directories
INPUT_DIR="$1"
OUTPUT_DIR="$2"

# Find all .xopp files and process them
find "$INPUT_DIR" -type f -name "*.xopp" | while read -r file; do
    # Get the relative path of the file
     REL_PATH="${file#./}"  # Remove leading './' if present
     #REL_PATH="${file#"$INPUT_DIR/"}"  # Get relative path

    # Create the corresponding directory structure in new_file
    OUTPUT_PATH="$OUTPUT_DIR/${REL_PATH%/*}"
    mkdir -p "$OUTPUT_PATH"

    # Convert .xopp file to PDF using xournalpp
    xournalpp_link_tool -p "$OUTPUT_PATH/${REL_PATH##*/}.pdf" "$file"

    #echo "Converted: $file -> $OUTPUT_PATH/${REL_PATH##*/}.pdf"
done

echo "tree data --noreport -X -o data.xml
git add -A
git commit -m 'updated'
git push
"
