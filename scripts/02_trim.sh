#!/bin/bash
# =================================
# 02_trim.sh
# Trim first 12 bp and discard very short reads
# Tool: cutadapt
# =================================

set -euo pipefail
start_time=$(date +%s)

RAW_DIR="data/fastq"
OUT_DIR="results/trimmed"
ACCESSION="SRR35368398"
THREADS=4

mkdir -p $OUT_DIR

R1="$RAW_DIR/${ACCESSION}_1.fastq.gz"
R2="$RAW_DIR/${ACCESSION}_2.fastq.gz"

if [[ ! -f "$R1" || ! -f "$R2" ]]; then
    echo "Input FASTQ files not found!" >&2
    exit 1
fi

echo ">>> Running cutadapt trimming on $ACCESSION..."

cutadapt \
    -j $THREADS \
    -u 12 -U 12 \
    -m 30 \
    -o $OUT_DIR/${ACCESSION}_1.trimmed.fastq.gz \
    -p $OUT_DIR/${ACCESSION}_2.trimmed.fastq.gz \
    $R1 $R2 > $OUT_DIR/${ACCESSION}_cutadapt.log

end_time=$(date +%s)
runtime=$((end_time - start_time))

echo "================================="
echo "Trimming completed!"
echo "Trimmed files in: $OUT_DIR"
echo "Cutadapt log: $OUT_DIR/${ACCESSION}_cutadapt.log"
echo "Total runtime: ${runtime} seconds"
echo "================================="
