#!/bin/sh
# options calculated from cellranger web:
# https://support.10xgenomics.com/single-cell-gene-expression/software/overview/system-requirements
# 128 total mem.
#$ -cwd
#$ -l h_rt=20:00:00
#$ -l h_vmem=8G
#$ -pe sharedmem 16
##$ -t 1
#$ -l test=1
# Initialise the environment modules
. /etc/profile.d/modules.sh

module load igmm/apps/cellranger/7.0.0
# check if this is the Cellranger version you would like to use. 

#ID file With these names no need to use idfile
#IDFILE=/exports/eddie/scratch/$USER/TK/src/samples.txt
# Assigning SAMPLE variable from the built-in array counter
#SAMPLE=`sed -n ${SGE_TASK_ID}p "$IDFILE"`

# change to a temporal directory, so intermediate files do not take space here
cd $TMPDIR
# cellranger multi

# variables
SAMPLE="TK_8"
csv=/exports/eddie/scratch/$USER/TK/src/config-files/config_${SAMPLE}.csv
# run cellranger
cellranger multi --id=$SAMPLE --csv=$csv

mkdir -p /exports/eddie/scratch/$USER/TK/outs/CellRanger/
rsync -rl $SAMPLE /exports/eddie/scratch/$USER/TK/outs/CellRanger/
