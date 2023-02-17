#!/bin/bash 

# Pre-computing high frequency k-mers (e.g., top 0.02% most frequent) in a reference with meryl
# Launch in a conda env where Winnowmap has been installed, or load required modules/wheels

# manitou
# parallel -a 02_infos/ind_ONT.txt -j 4 srun -p medium -c 4 --time=7-00:00 -J 02_compute_kmers --mem=70G -o log/02_compute_kmers_%j.log 01_scripts/02_compute_kmers.sh &

# valeria
# srun -p ibis_medium -c 6 --time=7-00:00 -J 02_compute_kmers --mem=70G -o log/02_compute_kmers_%j.log 01_scripts/02_compute_kmers.sh &

# VARIABLES
SAMPLE=$1
GENOME="03_genome/genome.fasta"
FILT_DIR="05_filtered"
FASTQ="$FILT_DIR/"$SAMPLE".fastq.gz"

ALIGNED_DIR="06_aligned"

CPU=6

# 0. Create output dir
if [[ ! -d "$ALIGNED_DIR" ]]
then
  mkdir $ALIGNED_DIR
fi

# 1. Pre-computing high frequency k-mers (e.g., top 0.02% most frequent) in a reference with meryl
meryl count k=15 output $ALIGNED_DIR/merylDB $GENOME threads=$CPU
meryl print greater-than distinct=0.9998 $ALIGNED_DIR/merylDB > $ALIGNED_DIR/repetitive_k15.txt