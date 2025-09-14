#!/bin/bash
# =================================
# 00_download_all.sh
# Download RNA-seq dataset (SRR35368398, human) + full genome (GRCh38)
# =================================

set -euo pipefail
start_time=$(date +%s)

# --------- SETTINGS ---------
DATA_DIR="data"
FASTQ_DIR="$DATA_DIR/fastq"
GENOME_DIR="$DATA_DIR/genome"
ACCESSION="SRR35368398"

mkdir -p $FASTQ_DIR $GENOME_DIR

# --------- Download from SRA ---------
echo ">>> Downloading $ACCESSION from SRA..."
prefetch $ACCESSION -O $FASTQ_DIR

echo ">>> Converting SRA to FASTQ..."
fasterq-dump --split-files --progress -O $FASTQ_DIR $ACCESSION

echo ">>> Compressing FASTQ..."
gzip $FASTQ_DIR/${ACCESSION}_1.fastq
gzip $FASTQ_DIR/${ACCESSION}_2.fastq

# --------- Download genome  ---------
echo ">>> Downloading full genome..."
wget -c ftp://ftp.ensembl.org/pub/release-109/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz -P data/genome
wget -c ftp://ftp.ensembl.org/pub/release-109/gtf/homo_sapiens/Homo_sapiens.GRCh38.109.gtf.gz -P data/genome


# echo ">>> Unzipping genome + annotation..."
gunzip -f $GENOME_DIR/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
gunzip -f $GENOME_DIR/Homo_sapiens.GRCh38.109.gtf.gz

# --------- DONE ---------
end_time=$(date +%s)
runtime=$((end_time - start_time))

echo "================================="
echo "Download complete!"
echo "FASTQ files: $FASTQ_DIR"
echo "Genome + GTF: $GENOME_DIR"
echo "Total runtime: ${runtime} seconds"
echo "================================="
