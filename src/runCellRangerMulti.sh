#!/bin/sh
# options calculated from cellranger web:
# https://support.10xgenomics.com/single-cell-gene-expression/software/overview/system-requirements
# 128 total mem.
 
#$ -l h_rt=20:00:00
#$ -l h_vmem=8G
#$ -pe sharedmem 16

# cellranger multi

# variables
SAMPLE=$1 # from the submit script TK_$i

# run cellranger
cellrnager multi --id=$SAMPLE --csv=config-files/config_$SAMPLE
