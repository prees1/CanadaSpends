#!/bin/bash

# Function to display usage information
show_usage() {
    echo "Usage: $0 <jurisdiction>"
    echo ""
    echo "Downloads source data files for the specified jurisdiction."
    echo ""
    echo "Arguments:"
    echo "  jurisdiction    The jurisdiction name (e.g., 'ontario', 'british-columbia')"
    echo ""
    echo "Examples:"
    echo "  $0 ontario"
    echo "  $0 british-columbia"
    echo ""
    echo "The script will:"
    echo "  1. Look for sources.txt in ./data/[jurisdiction]/"
    echo "  2. Download each URL listed in the file"
    echo "  3. Store files in ./data/[jurisdiction]/source_data/"
}

# Check if jurisdiction argument is provided
if [ $# -eq 0 ]; then
    show_usage
    exit 1
fi

# Get jurisdiction name from first argument
JURISDICTION="$1"

# Define paths
DATA_DIR="./data"
JURISDICTION_DIR="$DATA_DIR/$JURISDICTION"
SOURCES_FILE="$JURISDICTION_DIR/sources.txt"
SOURCE_DATA_DIR="$JURISDICTION_DIR/source_data"

# Check if jurisdiction directory exists
if [ ! -d "$JURISDICTION_DIR" ]; then
    echo "Error: Jurisdiction directory '$JURISDICTION_DIR' does not exist."
    echo "Available jurisdictions:"
    ls -1 "$DATA_DIR" 2>/dev/null | grep -v "^$" || echo "  No jurisdictions found in $DATA_DIR"
    exit 1
fi

# Check if sources.txt exists
if [ ! -f "$SOURCES_FILE" ]; then
    echo "Error: Sources file '$SOURCES_FILE' does not exist."
    exit 1
fi

# Create source_data directory if it doesn't exist
if [ ! -d "$SOURCE_DATA_DIR" ]; then
    echo "Creating directory: $SOURCE_DATA_DIR"
    mkdir -p "$SOURCE_DATA_DIR"
fi

# Read each line from sources.txt and download the file
echo "Downloading source files for jurisdiction: $JURISDICTION"
echo "Source file: $SOURCES_FILE"
echo "Target directory: $SOURCE_DATA_DIR"
echo ""

line_number=0
while IFS= read -r url; do
    line_number=$((line_number + 1))

    # Clean line endings (remove \r and trim whitespace)
    url=$(echo "$url" | tr -d '\r' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Skip empty lines
    if [ -z "$url" ]; then
        continue
    fi

    # Skip comment lines (starting with #)
    if [[ "$url" =~ ^[[:space:]]*# ]]; then
        continue
    fi

    echo "Processing line $line_number: '$url'"

        # Extract filename from URL and clean it
    filename=$(basename "$url" | tr -d '\r')

    # If filename is empty or doesn't have an extension, try to get it from the URL
    if [ -z "$filename" ] || [[ "$filename" != *.* ]]; then
        # Try to extract filename from URL path
        filename=$(echo "$url" | sed 's/.*\///' | sed 's/\?.*//' | tr -d '\r')
        # If still empty, use a default name
        if [ -z "$filename" ]; then
            filename="source_${line_number}"
        fi
    fi

    # Create full path for the target file
    target_file="$SOURCE_DATA_DIR/$filename"

    # Check if file already exists
    if [ -f "$target_file" ]; then
        echo "  File already exists: $target_file"
        echo "  Skipping download..."
    else
        echo "  Downloading to: $target_file"

        # Download the file
        echo "  Attempting to download with curl..."
        if curl -L -o "$target_file" "$url" 2>/dev/null; then
            echo "  ✓ Successfully downloaded"
        else
            echo "  ✗ Failed to download with curl"
            echo "  Trying with wget as fallback..."
            if wget -O "$target_file" "$url" 2>/dev/null; then
                echo "  ✓ Successfully downloaded with wget"
            else
                echo "  ✗ Failed to download with both curl and wget"
                echo "  Please check if the URL is accessible: $url"
                # Remove the file if it was partially downloaded
                rm -f "$target_file"
            fi
        fi
    fi

    echo ""
done < "$SOURCES_FILE"

echo "Download process completed for jurisdiction: $JURISDICTION"
