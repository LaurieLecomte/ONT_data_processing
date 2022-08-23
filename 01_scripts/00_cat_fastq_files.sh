#!/bin/bash

# Merge fastq.gz files for each sample
# Requires that all fasta files for a given sample are in a folder in 04_raw_data named with sample ID, e.g. 04_raw_data/13013A
# parallel -a 02_infos/ind_ONT.txt -j 10 srun -p small -c 1 --mem=20G -J {}_00_cat_fasta_files -o log/00_cat_fasta_files_{}_%j.log 01_scripts/00_cat_fastq_files.sh {} &

# VARIABLES
SAMPLE=$1
CAT_DIR="04_raw_data_cat"
RAW_DATA_DIR="04_raw_data/$SAMPLE"


# 1. Merge fasta files for each sample
cat $RAW_DATA_DIR/*.fastq.gz > $CAT_DIR/"SAMPLE".fastq.gz
