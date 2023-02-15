# ONT_data_processing

Pipeline for filtering and mapping Oxford Nanopore (ONT) reads

## Pipeline Overview

1. Concatenate raw fastq files for each sample : `00_cat_fastq_files.sh`
2. Plot summary statistics for each sample : `00_NanoPlot.sh` 
3. Filter reads according to lenght and minimum quality : `01_NanoFilt.sh` 
4. Map reads to the reference : `02_winnowmap.sh` 

## Prerequisites

### Files

* A reference genome (.fasta) and its index (.fai) in `03_genome`
* Raw fastq files in `04_raw_data`, in a seperate folder for each sample (e.g., `04_raw_data/SAMPLE_X`, `04_raw_data/SAMPLE_Y`, ...)
* A sample IDs list (`02_infos/ind_ONT.txt`), one ID per line
* 

### Software
* [NanoPlot 1.33.0+](https://github.com/wdecoster/NanoPlot/releases/tag/1.33.0)
* [NanoFilt 2.8.0+](https://github.com/wdecoster/nanofilt/releases/tag/v2.8.0)
* [Winnowmap 2.03+](https://github.com/marbl/Winnowmap/releases/tag/v2.03)
* GNU parallel