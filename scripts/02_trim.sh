#!/bin/bash
# =================================
# 02_trim.sh
# Adapter and quality trimming
# Tool: cutadapt
# =================================

set -euo pipefail
start_time=$(date +%s)

# --------- SETTINGS ---------
RAW_DIR="data/fastq"
TRIM_DIR="results/trimmed"

# Create output dir
mkdir -p $TRIM_DIR

# --------- RUN CUTADAPT ---------
echo ">>> Running cutadapt..."
cutadapt \
    -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
    -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
    -q 20,20 \
    -m 20 \
    -o $TRIM_DIR/SRR1553425_1.trimmed.fastq.gz \
    -p $TRIM_DIR/SRR1553425_2.trimmed.fastq.gz \
    $RAW_DIR/SRR1553425_1.fastq.gz \
    $RAW_DIR/SRR1553425_2.fastq.gz

# --------- DONE ---------
end_time=$(date +%s)
runtime=$((end_time - start_time))

echo "Trimming completed. Results in $TRIM_DIR"
echo "Total runtime: ${runtime} seconds"
