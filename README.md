# 🧬 Bulk RNA-seq Analysis 

This repository demonstrates a **complete bulk RNA-seq workflow** on public test data (SRA).  
It is designed as a showcase project for interview preparation and portfolio building.  

Each step is implemented as a standalone script in `scripts/`, making the workflow modular and reproducible.  

---

## 🚀 Pipeline steps

1. **Download data** – [`scripts/download_data.sh`](scripts/download_data.sh)  
   Download raw FASTQ files from SRA using `prefetch` and `fasterq-dump`.

2. **Quality control** – [`scripts/01_qc.sh`](scripts/01_qc.sh)  
   Run FastQC on raw FASTQ files and summarize results with MultiQC.

3. **Trimming** – `scripts/02_trim.sh`  
   Remove adapters and low-quality bases using `cutadapt` or `fastp`.  

4. **Alignment** – `scripts/03_align.sh`  
   Map reads to a reference genome (STAR or HISAT2).  

5. **Quantification** – `scripts/04_counts.sh`  
   Generate a count matrix (featureCounts or Salmon).  

6. **Differential expression** – `notebooks/deseq2_analysis.Rmd`  
   Perform DE analysis in R (PCA, volcano plot, identify DE genes with DESeq2).  

---

## 📊 QC results

**Sample:** SRR1553425 (paired-end RNA-seq, 2×75bp)  
**Tools:** FastQC + MultiQC  

### 🔹 Per base sequence quality
- High quality across all positions (Q > 30)  
- Slight drop at the end, still in green zone  
- ✅ No trimming required based on quality  

### 🔹 Per sequence GC content
- Peak at ~40%, consistent with human transcriptome  
- ✅ No contamination detected  

### 🔹 Adapter content
- Adapter signal increases after 60 bp (~2–3% of reads)  
- ⚠️ Trimming required  

### 🔹 Overrepresented sequences
- Only 0.065% of reads affected  
- ✅ Likely adapters or highly expressed transcripts  

### 🔹 Sequence duplication levels
- High duplication (>100 copies peak)  
- ⚠️ Typical for RNA-seq (due to highly expressed genes), but needs validation after alignment  

### 🔹 Per base N content
- 0% across all positions  
- ✅ No undetermined bases  

---

## ✂️ Trimming results

Performed with **cutadapt**.  

- **Adapter content** → removed (was ~2–3%, now <2.5%)  
- **Overrepresented sequences** → gone  
- ✅ Data is clean and ready for alignment 

---
