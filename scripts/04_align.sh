#!/bin/bash
# =================================
# 04_align.sh
# Align trimmed RNA-seq reads to reference genome (GRCh38)
# Tool: HISAT2
# =================================

set -euo pipefail
start_time=$(date +%s)

# --------- SETTINGS ---------
TRIM_DIR="results/trimmed"
GENOME_DIR="data/genome"
INDEX_PREFIX="$GENOME_DIR/GRCh38_index"
OUT_DIR="results/alignment"
LOG_DIR="results/logs"
THREADS=4
ACCESSION="SRR35368398"


mkdir -p $OUT_DIR $LOG_DIR

# Input files
R1="$TRIM_DIR/${ACCESSION}_1.trimmed.fastq.gz"
R2="$TRIM_DIR/${ACCESSION}_2.trimmed.fastq.gz"

# --------- CHECK INPUT ---------
if [[ ! -f "$R1" || ! -f "$R2" ]]; then
    echo "Trimmed FASTQ files not found in $TRIM_DIR" >&2
    exit 1
fi

if [[ ! -f "${INDEX_PREFIX}.1.ht2" ]]; then
    echo "HISAT2 index not found: $INDEX_PREFIX" >&2
    exit 1
fi

# --------- RUN HISAT2 ---------
echo ">>> Running HISAT2 alignment..."

hisat2 -p $THREADS \
  -x $INDEX_PREFIX \
  -1 $R1 -2 $R2 \
  -S $OUT_DIR/${ACCESSION}_GRCh38.sam \
  --summary-file $LOG_DIR/${ACCESSION}_alignment_summary.txt

# --------- DONE ---------
end_time=$(date +%s)
runtime=$((end_time - start_time))

echo "================================="
echo "Alignment completed!"
echo "SAM file: $OUT_DIR/${ACCESSION}_chr22.sam"
echo "Summary: $LOG_DIR/${ACCESSION}_alignment_summary.txt"
echo "Total runtime: ${runtime} seconds"
echo "================================="
