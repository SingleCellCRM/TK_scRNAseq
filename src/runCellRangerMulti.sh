#!/bin/sh
# options calculated from cellranger web:
# https://support.10xgenomics.com/single-cell-gene-expression/software/overview/system-requirements
# 128 total mem.
#$ -cwd
#$ -l h_rt=20:00:00
#$ -l h_vmem=8G
#$ -pe sharedmem 16


# Initialise the environment modules
. /etc/profile.d/modules.sh

module load igmm/apps/cellranger/6.0.2
# check if this is the Cellranger version you would like to use. 


# cellranger multi

# variables
SAMPLE=$1 # from the submit script TK_$i
csv=/exports/eddie/scratch/$USER/TK/src/config-files/config_${SAMPLE}.csv
# run cellranger
cellranger multi --id=$SAMPLE --csv=$csv
