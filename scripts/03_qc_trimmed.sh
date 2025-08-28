#!/bin/bash
# =================================
# 03_qc_trimmed.sh
# QC of trimmed FASTQ files
# Tools: FastQC + MultiQC
# =================================

set -euo pipefail
start_time=$(date +%s)

# --------- SETTINGS ---------
TRIM_DIR="results/trimmed"
QC_DIR="results/fastqc_trimmed"
MULTIQC_OUT="results/multiqc_trimmed"

# Create dirs if not exist
mkdir -p $QC_DIR $MULTIQC_OUT

# --------- RUN FASTQC ---------
echo ">>> Running FastQC on trimmed reads..."
fastqc -t 4 -o $QC_DIR $TRIM_DIR/*.fastq.gz

# --------- RUN MULTIQC ---------
echo ">>> Summarizing with MultiQC..."
multiqc $QC_DIR -o $MULTIQC_OUT

# --------- DONE ---------
end_time=$(date +%s)
runtime=$((end_time - start_time))

echo "QC on trimmed reads completed. Reports saved in:"
echo " - $QC_DIR"
echo " - $MULTIQC_OUT"
echo "Total runtime: ${runtime} seconds"
