#!/bin/bash
# =================================
# 05_sam_to_bam.sh
# Convert SAM to BAM, sort, and index
# Tool: samtools
# =================================

set -euo pipefail
start_time=$(date +%s)

ALIGN_DIR="results/alignment"
BAM_DIR="results/bam"
LOG_DIR="results/logs"
ACCESSION="SRR35368398"
THREADS=4

mkdir -p $BAM_DIR $LOG_DIR

SAM="$ALIGN_DIR/${ACCESSION}_GRCh38.sam"
BAM="$BAM_DIR/${ACCESSION}_GRCh38.bam"
SORTED="$BAM_DIR/${ACCESSION}_GRCh38.sorted.bam"
LOG="$LOG_DIR/${ACCESSION}_samtools.log"

if [[ ! -f "$SAM" ]]; then
    echo "SAM file not found: $SAM" >&2
    exit 1
fi

echo ">>> Converting SAM to BAM..."
samtools view -@ $THREADS -bS $SAM > $BAM

echo ">>> Sorting BAM..."
samtools sort -@ $THREADS -o $SORTED $BAM

echo ">>> Indexing BAM..."
samtools index $SORTED

end_time=$(date +%s)
runtime=$((end_time - start_time))

echo "================================="
echo "SAM -> BAM conversion completed!"
echo "Sorted BAM: $SORTED"
echo "Index: ${SORTED}.bai"
echo "Total runtime: ${runtime} seconds"
echo "=================================" | tee -a $LOG
