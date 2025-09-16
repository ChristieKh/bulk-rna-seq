# Load libraries
library(ggplot2)
library(dplyr)

# Close old devices
if (!is.null(dev.list())) graphics.off()

# Create output folder for figures
dir.create("results/figures", showWarnings = FALSE)

# Load featureCounts output
counts <- read.delim("results/counts/SRR35368398_gene_counts.txt", comment.char="#")

# Rename column 7 to sample ID
colnames(counts)[7] <- "SRR35368398"

# Total reads assigned
total_reads <- sum(counts$SRR35368398)
cat("Total assigned reads:", total_reads, "\n")

# Histogram of expression distribution
png("results/figures/muscle_histogram.png", width=800, height=600)
print(
    ggplot(counts, aes(x = log10(SRR35368398 + 1))) +
    geom_histogram(bins = 50, fill = "steelblue") +
    theme_minimal() +
    labs(title = "Expression distribution (skeletal muscle)",
        x = "log10(counts + 1)", y = "Number of genes")
)
dev.off()

# Top 20 expressed genes
top20 <- counts %>%
  arrange(desc(SRR35368398)) %>%
  head(20)

# Save top 20 to file
write.table(top20[, c("Geneid", "SRR35368398")],
            file = "results/figures/muscle_top20_genes.txt",
            sep = "\t", quote = FALSE, row.names = FALSE)

# Print only top 5 to console
cat("Top 5 expressed genes:\n")
print(head(top20[, c("Geneid", "SRR35368398")], 5))

# Barplot of top 20 genes
png("results/figures/muscle_top20.png", width=800, height=600)
print(ggplot(top20, aes(x = reorder(Geneid, SRR35368398), y = SRR35368398)) +
  geom_col(fill = "firebrick") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Top 20 expressed genes in skeletal muscle",
       x = "Gene", y = "Counts")
)
dev.off()

cat("Figures saved in results/figures/\n")