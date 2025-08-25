#!/bin/bash
# ================================
# download_data.sh
# Download example bulk RNA-seq dataset (SRR1553425, ENCODE human RNA-seq)
# ================================

set -euo pipefail

DATA_DIR="data/fastq"
SRR_ID="SRR1553425"

mkdir -p $DATA_DIR

echo ">>> Downloading $SRR_ID from SRA..."
prefetch $SRR_ID

echo ">>> Converting to FASTQ..."
fasterq-dump --split-files $SRR_ID -O $DATA_DIR

echo ">>> Compressing FASTQ files..."
gzip $DATA_DIR/*.fastq

echo "Download complete. Files in $DATA_DIR:"
ls -lh $DATA_DIR