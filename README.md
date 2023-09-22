# ONT_data_processing

Pipeline for filtering and mapping Oxford Nanopore (ONT) reads

## Pipeline Overview

1. Concatenate raw fastq files for each sample : `00_cat_fastq_files.sh`
2. Plot summary statistics for each sample (optional) : `00_NanoPlot.sh` 
3. Filter reads according to lenght and minimum quality : `01_NanoFilt.sh` 
4. Map reads to the reference : `02_winnowmap.sh` 

## Prerequisites

### Files

* A reference genome named `genome.fasta` and its index (.fai) in `03_genome`
* Raw fastq files in `04_raw_data`, in a seperate folder for each sample (e.g., `04_raw_data/SAMPLE_X`, `04_raw_data/SAMPLE_Y`, ...)
* A sample IDs list (`02_infos/ind_ONT.txt`), one ID per line

### Software

#### Required tools
* [NanoPlot 1.33.0+](https://github.com/wdecoster/NanoPlot/releases/tag/1.33.0)
* [NanoFilt 2.8.0+](https://github.com/wdecoster/nanofilt/releases/tag/v2.8.0)
* [Winnowmap 2.03+](https://github.com/marbl/Winnowmap/releases/tag/v2.03)
* GNU parallel

#### conda

1. Create env ONT from file : `conda create --name ONT --file NanoTools_env.txt`
2. Activate env : `conda activate ONT`

#### Valeria users

! Warning : `NanoPlot` wheel cannot be installed correctly for now, so `00_NanoPlot.sh` must be executed from Manitou or a conda env

Create a module collection and a python env for running this pipeline from Valeria's frontal node, in the pipeline's main directory : 

```
## clear env
module purge

## load required modules
module load gcc python/3.10 winnowmap/2.03 

## save collection
module save ONT_prepr

## create python env in current dir
virtualenv --no-download --clear env/ONT_env 
source env/ONT_env/bin/activate
pip install nanofilt
```

Before launching any script from this pipeline, run 

```
module restore ONT_prepr
source env/ONT_env/bin/activate
```
