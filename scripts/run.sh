#!/bin/bash

# Function to display usage information
show_usage() {
    echo "Usage: $0 <jurisdiction>"
    echo ""
    echo "Runs all data processing steps for the specified jurisdiction."
    echo ""
    echo "Arguments:"
    echo "  jurisdiction    The jurisdiction name (e.g., 'ontario', 'british-columbia')"
    echo ""
    echo "Examples:"
    echo "  $0 ontario"
    echo "  $0 british-columbia"
    echo ""
    echo "The script will run all steps in sequence:"
    echo "  1. Fetch - Download source data files"
    echo "  2. Extract - Extract data from non-parsable formats (if needed)"
    echo "  3. Transform - Manipulate data to meet requirements"
    echo "  4. Format - Structure data for visualization"
    echo ""
    echo "Each step can also be run individually:"
    echo "  ./scripts/fetch.sh <jurisdiction>"
    echo "  ./scripts/extract.sh <jurisdiction>"
    echo "  ./scripts/transform.sh <jurisdiction>"
    echo "  ./scripts/format.sh <jurisdiction>"
}

# Function to run a step and check for errors
run_step() {
    local step_name="$1"
    local script_path="$2"
    local jurisdiction="$3"

    echo "=========================================="
    echo "Running $step_name step..."
    echo "=========================================="

    if [ -f "$script_path" ]; then
        if "$script_path" "$jurisdiction"; then
            echo "✓ $step_name step completed successfully"
            echo ""
        else
            echo "✗ $step_name step failed"
            echo "Stopping execution due to error in $step_name step"
            exit 1
        fi
    else
        echo "⚠️  Script not found: $script_path"
        echo "Skipping $step_name step..."
        echo ""
    fi
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
SCRIPT_DIR="./scripts"

# Check if jurisdiction directory exists
if [ ! -d "$JURISDICTION_DIR" ]; then
    echo "Error: Jurisdiction directory '$JURISDICTION_DIR' does not exist."
    echo "Available jurisdictions:"
    ls -1 "$DATA_DIR" 2>/dev/null | grep -v "^$" || echo "  No jurisdictions found in $DATA_DIR"
    exit 1
fi

echo "Starting data processing pipeline for jurisdiction: $JURISDICTION"
echo "Data directory: $JURISDICTION_DIR"
echo ""

# Run all steps in sequence
run_step "Fetch" "$SCRIPT_DIR/fetch.sh" "$JURISDICTION"
run_step "Extract" "$SCRIPT_DIR/extract.sh" "$JURISDICTION"
run_step "Transform" "$SCRIPT_DIR/transform.sh" "$JURISDICTION"
run_step "Format" "$SCRIPT_DIR/format.sh" "$JURISDICTION"

echo "=========================================="
echo "Data processing pipeline completed for: $JURISDICTION"
echo "=========================================="