#!/bin/bash 

# Quality filter raw ONT reads from merged files

# manitou
# parallel -a 02_infos/ind_ONT.txt -j 4 srun -p small -c 1 --time=1-00:00 -J {}_01_NanoFilt --mem=20G -o log/01_NanoFilt_{}_%j.log 01_scripts/01_NanoFilt.sh {} &

# valeria
# parallel -a 02_infos/ind_ONT.txt -j 4 srun -p ibis_small -c 1 --time=1-00:00 -J {}_01_NanoFilt --mem=20G -o log/01_NanoFilt_{}_%j.log 01_scripts/01_NanoFilt.sh {} &

# VARIABLES
SAMPLE=$1
CAT_DATA="04_raw_data_cat" 
FASTQ="$CAT_DATA/"$SAMPLE".fastq.gz" # merged fastq.gz

FILT_DIR="05_filtered"

MIN_LEN=1000 # exclude reads shorter than this
MIN_QUAL=10 # exclude reads blow this quality threshold


# 1. Run NanoFilt
gunzip -c $FASTQ | NanoFilt -q $MIN_QUAL -l $MIN_LEN --readtype 1D | gzip > $FILT_DIR/"$SAMPLE".fastq.gz

