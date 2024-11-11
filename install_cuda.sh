#!/bin/bash

declare -A URLS
URLS["110"]="https://developer.download.nvidia.com/compute/cuda/11.0.3/local_installers/cuda_11.0.3_450.51.06_linux.run"
URLS["111"]="https://developer.download.nvidia.com/compute/cuda/11.1.1/local_installers/cuda_11.1.1_455.32.00_linux.run"
URLS["112"]="https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_460.32.03_linux.run"
URLS["113"]="https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda_11.3.1_465.19.01_linux.run"
URLS["114"]="https://developer.download.nvidia.com/compute/cuda/11.4.4/local_installers/cuda_11.4.4_470.82.01_linux.run"
URLS["115"]="https://developer.download.nvidia.com/compute/cuda/11.5.2/local_installers/cuda_11.5.2_495.29.05_linux.run"
URLS["116"]="https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda_11.6.2_510.47.03_linux.run"
URLS["117"]="https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda_11.7.1_515.65.01_linux.run"
URLS["118"]="https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run"
URLS["120"]="https://developer.download.nvidia.com/compute/cuda/12.0.1/local_installers/cuda_12.0.1_525.85.12_linux.run"
URLS["121"]="https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda_12.1.1_530.30.02_linux.run"
URLS["122"]="https://developer.download.nvidia.com/compute/cuda/12.2.2/local_installers/cuda_12.2.2_535.104.05_linux.run"
URLS["123"]="https://developer.download.nvidia.com/compute/cuda/12.3.2/local_installers/cuda_12.3.2_545.23.08_linux.run"
URLS["124"]="https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda_12.4.1_550.54.15_linux.run"
URLS["125"]="https://developer.download.nvidia.com/compute/cuda/12.5.0/local_installers/cuda_12.5.0_555.42.02_linux.run"

CUDA_VERSION=$1
BASE_PATH=$2
EXPORT_BASHRC=$3

usage() {
    echo "Usage: $0 <CUDA_VERSION> <BASE_PATH> [EXPORT_BASHRC]"
    echo "Example: $0 118 /usr/local 1"
    echo "CUDA_VERSION should be one of: ${!URLS[@]}"
    exit 1
}

if [[ -z "$CUDA_VERSION" ]]; then
    echo "Error: No CUDA version provided."
    usage
fi

if [[ -z "${URLS[$CUDA_VERSION]}" ]]; then
    echo "Error: Invalid CUDA version '$CUDA_VERSION'."
    usage
fi

if [[ -z "$BASE_PATH" ]]; then
    echo "Error: No base path provided."
    usage
fi

if [[ -z "$EXPORT_BASHRC" ]]; then
    EXPORT_BASHRC=0
fi

if ! command -v wget >/dev/null 2>&1; then
    echo "Error: wget is not installed. Please install wget and try again."
    exit 1
fi

URL="${URLS[$CUDA_VERSION]}"
MAJOR=${CUDA_VERSION:0:2}
MINOR=${CUDA_VERSION:2}
FOLDER="cuda-${MAJOR}.${MINOR}"

if [[ ! -w "$BASE_PATH" ]]; then
    echo "Error: Cannot write to $BASE_PATH. Please check permissions."
    exit 1
fi

FILE=$(basename "$URL")
echo "Downloading $URL..."
wget -q "$URL" -O "$FILE"
if [[ $? -ne 0 ]]; then
    echo "Failed to download $URL"
    exit 1
fi

chmod +x "$FILE"

echo "Installing CUDA toolkit..."
bash "$FILE" --no-drm --no-man-page --override --toolkitpath="$BASE_PATH/$FOLDER/" --toolkit --silent
if [[ $? -ne 0 ]]; then
    echo "Failed to install CUDA toolkit."
    exit 1
fi

if [[ "$EXPORT_BASHRC" -eq "1" ]]; then
    echo "Updating ~/.bashrc..."
    {
        echo ""
        echo "# CUDA environment variables"
        echo "export PATH=$BASE_PATH/$FOLDER/bin:\$PATH"
        echo "export LD_LIBRARY_PATH=$BASE_PATH/$FOLDER/lib64:\$LD_LIBRARY_PATH"
        echo "export CUDA_HOME=$BASE_PATH/$FOLDER"
        echo "export CUDA_VERSION=$CUDA_VERSION"
    } >> ~/.bashrc
    echo "Please run 'source ~/.bashrc' to update your environment variables."
fi

rm -f "$FILE"

echo "CUDA toolkit installation completed successfully."
