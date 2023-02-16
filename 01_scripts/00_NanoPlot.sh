#!/bin/bash 

# Summary plots for raw ONT data, on merged files
# parallel -a 02_infos/ind_ONT.txt -j 4 srun -p small -c 1 -J {}_00_NanoPlot --mem=10G -o log/00_NanoPlot_{}_%j.log 01_scripts/00_NanoPlot.sh {} &

# VARIABLES
SAMPLE=$1
CAT_DIR="04_raw_data_cat"
FASTQ="$CAT_DIR/"$SAMPLE".fastq.gz" # merged fastq.gz
OUT_DIR="NanoPlot/$SAMPLE"

# Create output directory
if [[ ! -d "$OUT_DIR" ]]
then
  echo "$OUT_DIR does not exist"
  mkdir $OUT_DIR
else 
  echo "$OUT_DIR exists"
fi

# 1. Run NanoPlot
NanoPlot --fastq $FASTQ --plots dot --legacy hex --title $SAMPLE -o $OUT_DIR --readtype 1D --N50 --verbose #-p "$SAMPLE"_cat

