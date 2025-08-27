#!/bin/bash
# =================================
# 01_qc.sh
# Quality control of raw FASTQ files
# Tools: FastQC + MultiQC
# =================================

# Exit immediately on error, treat unset vars as error, fail on pipe errors
set -euo pipefail

# Record start time
start_time=$(date +%s)

# --------- SETTINGS ---------
# Raw FASTQ folder
RAW_DIR="data/fastq"

# Output folders
OUT_DIR="results/fastqc"
MULTIQC_OUT="results/multiqc"

# Create directories if not exist
mkdir -p $OUT_DIR $MULTIQC_OUT

# --------- RUN FASTQC ---------
# echo ">>> Running FastQC..."
# fastqc -t 4 -o $OUT_DIR $RAW_DIR/*.fastq.gz

# --------- RUN MULTIQC ---------
echo ">>> Summarizing with MultiQC..."
multiqc $OUT_DIR -o $MULTIQC_OUT

# --------- DONE ---------
end_time=$(date +%s)
runtime=$((end_time - start_time))


echo "QC completed. Reports in $OUT_DIR and $MULTIQC_OUT"
echo "Total runtime: ${runtime} seconds"
