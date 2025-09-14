#!/bin/bash
# =================================
# 06_counts.sh
# Generate gene-level counts using featureCounts
# =================================

set -euo pipefail
start_time=$(date +%s)

BAM_DIR="results/bam"
GENOME_DIR="data/genome"
OUT_DIR="results/counts"
LOG_DIR="results/logs"
ACCESSION="SRR35368398"
THREADS=4

mkdir -p $OUT_DIR $LOG_DIR

BAM="$BAM_DIR/${ACCESSION}_GRCh38.sorted.bam"
GTF="$GENOME_DIR/Homo_sapiens.GRCh38.109.gtf"
COUNTS="$OUT_DIR/${ACCESSION}_gene_counts.txt"
LOG="$LOG_DIR/${ACCESSION}_featureCounts.log"

if [[ ! -f "$BAM" ]]; then
    echo "BAM file not found: $BAM" >&2
    exit 1
fi

if [[ ! -f "$GTF" ]]; then
    echo "GTF file not found: $GTF" >&2
    exit 1
fi

echo ">>> Running featureCounts on $ACCESSION..."

featureCounts -T $THREADS -p -t exon -g gene_id \
  -a $GTF \
  -o $COUNTS \
  $BAM > $LOG 2>&1

end_time=$(date +%s)
runtime=$((end_time - start_time))

echo "================================="
echo "featureCounts completed!"
echo "Counts file: $COUNTS"
echo "Log: $LOG"
echo "Total runtime: ${runtime} seconds"
echo "================================="