# 🧬 Bulk RNA-seq Workflow (Learning Project)

This is a learning project, where I built a complete RNA-seq pipeline from raw FASTQ files to gene counts and basic downstream analysis.
The goal was to practice the main steps of RNA-seq analysis and prepare material for a portfolio.

---

## 🚀 Pipeline steps

##  Part A: Single-sample analysis (Skeletal Muscle)

1. **Download data** – [`scripts/00_download_data.sh`](scripts/00_download_data.sh)  
   Download raw FASTQ files from SRA using `prefetch` and `fasterq-dump`.  
   Download the GRCh38 reference genome (FASTA) and annotation (GTF).

2. **Quality control** – [`scripts/01_qc.sh`](scripts/01_qc.sh)  
   Run FastQC on raw FASTQ files and summarize results with MultiQC.
   QC:
   - Slight drop in the first 10–12 bases (technical bias) 
   - Per-base quality > Q30 across most positions.
   - Small adapter contamination detected.
   - Duplication level high (typical for RNA-seq).

3. **Trimming** – [`scripts/02_trim.sh`](scripts/02_trim.sh)   
   Remove technical bias (first 12 bp) and discard very short reads using `cutadapt`.  
   Re-run QC on trimmed data.

4. **Genome indexing** – [`scripts/03_index.sh`](scripts/03_index.sh)  
   Build a HISAT2 index of the GRCh38 genome. 

5. **Alignment** – [`scripts/04_align.sh`](scripts/04_align.sh)  
   Align trimmed RNA-seq reads to the GRCh38 genome using HISAT2.  
   Output: SAM file with alignment results. **~95%** overall alignment rate. Unique concordant alignments: **86.6%**

6. **SAM → BAM conversion** – [`scripts/05_sam_to_bam.sh`](scripts/05_sam_to_bam.sh)  
   Convert SAM to BAM, sort, and index with samtools.  
   Output: compact, ready-to-use BAM file.

7. **Quantification** – [`scripts/06_counts.sh`](scripts/06_counts.sh)  
   Generate a count matrix with `featureCounts`. **~25.9M** reads assigned to genes.

8. **Exploratory analysis (muscle only)** – []*(planned)*  

⚠️ With only one sample, no differential expression is possible. This part focuses on technical processing and basic exploration.

---
## Part B: Comparative analysis (Muscle vs Brain) [In Progress]

**Added dataset: SRR30607652** (human brain, healthy control, paired-end)
Steps 1–6 repeated for this sample.

7. **Count matrix**
   Combined counts for **muscle + brain** into one table (genes × 2 samples).

8. **Exploratory analysis (DESeq2)**
   PCA: clear separation between muscle and brain.
   Heatmap: clustering of tissue-specific genes.

9. **Illustrative differential expression**
   Muscle up: contractile proteins (MYH7, TTN, ACTN2).
   Brain up: neuronal markers (NEFL, GFAP, SYN1).
   Volcano plot shows strong contrast between tissues.

⚠️ With only one sample per tissue, DE results are illustrative only. Replicates are required for valid statistics.
