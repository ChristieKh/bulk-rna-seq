#!/bin/bash
# =================================
# 03_index.sh
# Build HISAT2 index from full human genome (GRCh38)
# =================================

set -euo pipefail
start_time=$(date +%s)

# --------- SETTINGS ---------
GENOME_DIR="data/genome"
FASTA="$GENOME_DIR/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
INDEX_PREFIX="$GENOME_DIR/GRCh38_index"
THREADS=8
LOG="results/index_GRCh38.log"

mkdir -p results

# --------- LOGGING ---------
exec > >(tee -i $LOG)
exec 2>&1

# --------- CHECK INPUT ---------
if [[ ! -f "$FASTA" ]]; then
    echo "Reference FASTA not found: $FASTA" >&2
    exit 1
fi

# --------- BUILD INDEX ---------
echo ">>> Building HISAT2 index for GRCh38 (this may take ~30-40 minutes)..."
hisat2-build -p $THREADS $FASTA $INDEX_PREFIX

# --------- DONE ---------
end_time=$(date +%s)
runtime=$((end_time - start_time))

echo "================================="
echo "Index built successfully!"
echo "Index prefix: $INDEX_PREFIX"
echo "Total runtime: ${runtime} seconds"
echo "================================="
