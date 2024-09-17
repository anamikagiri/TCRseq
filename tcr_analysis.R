#!/usr/bin/env Rscript

library(immunarch)
library(optparse)
library(ggplot2)
library(dplyr)

# Parse command line arguments
option_list <- list(
  make_option(c("-i", "--input"), type = "character", help = "Path to input CSV file"),
  make_option(c("-o", "--output"), type = "character", help = "Output directory for results")
)
opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)

# Load TCR data
tcr_data <- read.csv(opt$input)

# Create TCR data object
tcr_data_object <- repLoad(tcr_data, format = "csv")

# TCR Analysis
# Example analysis: Clonality, Diversity, and CDR3 Length
clonality <- repClonality(tcr_data_object)
diversity <- repDiversity(tcr_data_object)
cdr3_length <- repCDR3Length(tcr_data_object)

# Save results
write.csv(clonality, file.path(opt$output, "clonality.csv"), row.names = FALSE)
write.csv(diversity, file.path(opt$output, "diversity.csv"), row.names = FALSE)
write.csv(cdr3_length, file.path(opt$output, "cdr3_length.csv"), row.names = FALSE)

# Plot results
# Clonality plot
ggplot(clonality, aes(x = SampleID, y = Clonality)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "TCR Clonality by Sample", x = "Sample ID", y = "Clonality") +
  ggsave(file.path(opt$output, "clonality_plot.png"))

# Diversity plot
ggplot(diversity, aes(x = SampleID, y = Diversity)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(title = "TCR Diversity by Sample", x = "Sample ID", y = "Diversity") +
  ggsave(file.path(opt$output, "diversity_plot.png"))

# CDR3 Length plot
ggplot(cdr3_length, aes(x = Length)) +
  geom_histogram(binwidth = 1) +
  facet_wrap(~ SampleID) +
  theme_minimal() +
  labs(title = "CDR3 Length Distribution", x = "CDR3 Length", y = "Count") +
  ggsave(file.path(opt$output, "cdr3_length_distribution.png"))
