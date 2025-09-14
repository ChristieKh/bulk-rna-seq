# 🧬 Bulk RNA-seq Analysis (Human Skeletal Muscle, SRR35368398)

This repository demonstrates a **complete bulk RNA-seq workflow** using a public human skeletal muscle dataset (SRA: SRR35368398).  
It is designed as a showcase project for **portfolio building and interview preparation** in bioinformatics.

Each step is implemented as a standalone script in `scripts/`, making the workflow **modular, reproducible, and easy to extend**.

---

## 🚀 Pipeline steps

1. **Download data** – [`scripts/00_download_data.sh`](scripts/00_download_data.sh)  
   Download raw FASTQ files from SRA using `prefetch` and `fasterq-dump`.  
   Download the GRCh38 reference genome (FASTA) and annotation (GTF).

2. **Quality control** – [`scripts/01_qc.sh`](scripts/01_qc.sh)  
   Run FastQC on raw FASTQ files and summarize results with MultiQC.

3. **Trimming** – [`scripts/02_trim.sh`](scripts/02_trim.sh)   
   Remove technical bias (first 12 bp) and discard very short reads using `cutadapt`.  
   Re-run QC on trimmed data.

4. **Genome indexing** – [`scripts/03_index.sh`](scripts/03_index.sh)  
   Build a HISAT2 index of the GRCh38 genome.

5. **Alignment** – [`scripts/04_align.sh`](scripts/04_align.sh)  
   Align trimmed RNA-seq reads to the GRCh38 genome using HISAT2.  
   Output: SAM file with alignment results.

6. **SAM → BAM conversion** – [`scripts/05_sam_to_bam.sh`](scripts/05_sam_to_bam.sh)  
   Convert SAM to BAM, sort, and index with samtools.  
   Output: compact, ready-to-use BAM file.

7. **Quantification** – [`scripts/06_counts.sh`](scripts/06_counts.sh)  
   Generate a count matrix with `featureCounts`. 

8. **Differential expression** – [`notebooks/deseq2_analysis.Rmd`](notebooks/deseq2_analysis.Rmd) *(planned)*  
   Perform DE analysis in R: PCA, volcano plots, and DE gene identification with DESeq2.

---

## 📊 Current QC results (SRR35368398, skeletal muscle)

### 🔹 Per base sequence quality
- Slight drop in the first 10–12 bases (technical bias)  
- ✅ Trimmed away with `cutadapt`  
- Remaining bases have very high quality (Q > 35)

### 🔹 Per sequence GC content
- Centered around ~48%  
- ✅ Consistent with human transcriptome

### 🔹 Adapter content
- ✅ No adapter contamination detected

### 🔹 Overrepresented sequences
- ~0.3% of reads, likely due to highly expressed muscle transcripts  
- ⚠️ Expected for RNA-seq (e.g., actin, myosin genes)

### 🔹 Sequence duplication levels
- ~50% duplication rate  
- ⚠️ Normal for RNA-seq due to highly expressed genes

---

## ✂️ Trimming results

Performed with **cutadapt**:  

- First 12 bp removed (bias fixed)  
- Short reads (<30 bp) discarded  
- ✅ Data is clean and ready for alignment

---

## 📌 Alignment results (HISAT2, GRCh38)

- Sample: **SRR35368398**  
- Aligner: **HISAT2**  
- Overall alignment rate: **95.0%**  
- Unique concordant alignments: **86.6%**  
- ✅ High-quality alignment suitable for downstream quantification

---

## 📌 Quantification results (featureCounts)

- Input: `SRR35368398_GRCh38.sorted.bam`
- Annotation: `Homo_sapiens.GRCh38.109.gtf`
- Assigned reads: **25,927,919**
- Multi-mapped reads: 12,066,540
- No features: 25,319,765
- Ambiguous: 4,643,885
---

## 🔮 Next steps 
- Perform differential expression analysis in R (DESeq2)  
- Visualize results (PCA, heatmaps, volcano plots)  
