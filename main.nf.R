#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.tcr_data_dir = '/Users/anamika/tcr_sequences/'
params.output_dir = '/Users/anamika/results/tcr_analysis/'
params.r_script = '/Users/anamika/scripts/tcr_analysis.R'

process prepare_data {
  input:
    path tcr_files from file(params.tcr_data_dir + '*.csv')
  
  output:
    path 'prepared_data.csv'
  
  script:
    """
    # Combine all TCR sequence files into a single CSV file
    cat ${tcr_files} > prepared_data.csv
    """
}

process analyze_tcr {
  input:
    path prepared_data from 'prepared_data.csv'
  
  output:
    path 'tcr_analysis_results/'
  
  script:
    """
    Rscript ${params.r_script} --input ${prepared_data} --output tcr_analysis_results/
    """
}

workflow {
  prepare_data()
  analyze_tcr()
}
