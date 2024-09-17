# TCRseq
Analysis of TCR sequencing 

### Nextflow Script (main.nf): ###

prepare_data: Combines TCR sequence files into a single CSV. 
analyze_tcr: Calls the R script to perform TCR analysis and generate results.

### R Script (tcr_analysis.R): ###

Data Loading: Reads the TCR sequence data.

TCR Analysis: Uses immunarch functions for clonality, diversity, and CDR3 length analysis.
Visualization: Creates plots and saves them in the specified output directory.

Running the Pipeline
To run the Nextflow pipeline, navigate to the directory containing main.nf and execute:
nextflow run main.nf
