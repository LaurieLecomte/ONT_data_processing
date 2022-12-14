#!/bin/bash 

# Align ONT reads with winnowmap
# Launch in a conda env where Winnowmap has been installed
# parallel -a 02_infos/ind_ONT.txt -j 4 srun -p medium -c 2 --time=7-00:00 -J {}_02_winnowmap --mem=70G -o log/02_winnowmap_{}_%j.log 01_scripts/02_winnowmap.sh {} &

# VARIABLES
SAMPLE=$1
GENOME="03_genome/genome.fasta"
FILT_DIR="05_filtered"
FASTQ="$FILT_DIR/"$SAMPLE".fastq.gz"

ALIGNED_DIR="06_aligned"

# LOAD REQUIRED MODULES
module load samtools

# 0. Create output dir
if [[ ! -d "$ALIGNED_DIR" ]]
then
  mkdir $ALIGNED_DIR
fi

# 1. Pre-computing high frequency k-mers (e.g., top 0.02% most frequent) in a reference with meryl
meryl count k=15 output $ALIGNED_DIR/merylDB $GENOME
meryl print greater-than distinct=0.9998 $ALIGNED_DIR/merylDB > $ALIGNED_DIR/"$SAMPLE"_repetitive_k15.txt

# 2. Run winnowmap
winnowmap --MD --cs -W $ALIGNED_DIR/"$SAMPLE"_repetitive_k15.txt -ax map-ont $GENOME $FASTQ > $ALIGNED_DIR/"$SAMPLE".sam

# 3. Sort and convert to bam
samtools sort $ALIGNED_DIR/"$SAMPLE".sam -o $ALIGNED_DIR/"$SAMPLE".sorted.bam

# 4. Index sorted bam file
samtools index $ALIGNED_DIR/"$SAMPLE".sorted.bam
