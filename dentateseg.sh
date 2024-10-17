#!/bin/bash

# echo "Starting the script..."

function usage() {
    echo "DentateSeg: A dentate nucleus segmentation tool"
    echo
    echo "Usage: $0 -i INPUT_RESOURCE -o OUTPUT_DIRECTORY [--gpu]"
    echo
    echo "Args:"
    echo "  -i, --input_resource INPUT_RESOURCE"
    echo "      Path to the input resource file. (Required)"
    echo
    echo "  -o, --output_directory OUTPUT_DIRECTORY"
    echo "      Path to the output directory where results will be saved. (Required)"
    echo
    echo "  --gpu"
    echo "      Enable GPU support for processing. (Optional)"
    echo
    echo "  -h, --help"
    echo "      Display this help message and exit."
    echo
    echo "Examples:"
    echo "  ./run_script.sh -i /path/to/input -o /path/to/output"
    echo "      Runs the script with the specified input and output paths without GPU support."
    echo
    echo "  ./run_script.sh -i /path/to/input -o /path/to/output --gpu"
    echo "      Runs the script with GPU support enabled."
    echo
    echo "  ./run_script.sh --input_resource /path/to/input --output_directory /path/to/output --gpu"
    echo "      Uses long options to specify arguments and enables GPU support."
    echo
    echo "Notes:"
    echo "  - Both the input resource and output directory options are mandatory."
    echo "  - The order of the arguments does not matter."
    echo "  - Use the '-h' or '--help' option to display this help message."
    exit 1
}

INPUT_RESOURCE=""
OUTPUT_DIRECTORY=""
USE_GPU=false

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            exit 0
            ;;
        -i|--input_resource)
            INPUT_RESOURCE="$2"
            shift 2
            ;;
        -o|--output_directory)
            OUTPUT_DIRECTORY="$2"
            shift 2
            ;;
        --gpu)
            USE_GPU=true
            shift
            ;;
        *)
            echo "Unknown parameter passed: $1"
            usage
            exit 0
            ;;
    esac
done

# Check if mandatory arguments are provided
if [ -z "$INPUT_RESOURCE" ] || [ -z "$OUTPUT_DIRECTORY" ]; then
    echo "Error: Input resource and output directory are required."
    usage
fi

INPUT_RESOURCE="/dentateseg-storage/${INPUT_RESOURCE}"
OUTPUT_DIRECTORY="/dentateseg-storage/${OUTPUT_DIRECTORY}"

# Build the command to execute the Python script
CMD="python3 main.py -i \"$INPUT_RESOURCE\" -o \"$OUTPUT_DIRECTORY\""

# Add GPU flag if specified
if [ "$USE_GPU" = true ]; then
    CMD="$CMD --gpu"
fi

# dirname
echo "dirname: $(dirname $0)"

# Execute the command
echo "Executing: $CMD"
eval $CMD
