#!/bin/bash
# =================================
# 01_qc.sh
# Quality control of FASTQ files
# Tools: FastQC + MultiQC
# =================================

set -euo pipefail
start_time=$(date +%s)

# --------- INPUT ARGUMENT ---------
# Default = data/fastq
INPUT_DIR=${1:-"data/fastq"}

# --------- SETTINGS ---------
OUT_DIR="results/fastqc/$(basename $INPUT_DIR)"
MULTIQC_OUT="results/multiqc/$(basename $INPUT_DIR)"
THREADS=4
LOG="results/qc_$(basename $INPUT_DIR).log"

mkdir -p $OUT_DIR $MULTIQC_OUT

# --------- LOGGING ---------
exec > >(tee -i $LOG)
exec 2>&1

# --------- CHECK INPUT ---------
if compgen -G "$INPUT_DIR/*.f*q.gz" > /dev/null; then
    echo "FASTQ files found in $INPUT_DIR"
else
    echo "No FASTQ files found in $INPUT_DIR" >&2
    exit 1
fi

# --------- RUN FASTQC ---------
echo ">>> Running FastQC..."
fastqc -t $THREADS -o $OUT_DIR $INPUT_DIR/*.f*q.gz

# --------- RUN MULTIQC ---------
echo ">>> Summarizing with MultiQC..."
multiqc $OUT_DIR -o $MULTIQC_OUT

# --------- DONE ---------
end_time=$(date +%s)
runtime=$((end_time - start_time))

echo "================================="
echo "QC completed for $INPUT_DIR"
echo "FastQC reports: $OUT_DIR"
echo "MultiQC report: $MULTIQC_OUT"
echo "Total runtime: ${runtime} seconds"
echo "================================="
