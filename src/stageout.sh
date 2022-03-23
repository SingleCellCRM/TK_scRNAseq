#!/bin/bash
#
# Example data staging job script that copies a directory from Datastore to Eddie with rsync
#
# Job will restart from where it left off if it runs out of time
# (so setting an accurate hard runtime limit is less important)

# Grid Engine options start with a #$
#$ -N stageout_Log        
#$ -cwd   
# Choose the staging environment
#$ -q staging 

# Hard runtime limit
#$ -l h_rt=01:00:00   

# Make the job resubmit itself if it runs out of time: rsync will start where it left off
#$ -r yes 
#$ -notify
#trap 'exit 99' sigusr1 sigusr2 sigterm #POSIX signals

# ensure we are in the same directory the folders we want to transfer are

# Source and destination directories
cd /exports/eddie/scratch/nbestard/TK/
# SAMPLE is the name from the samples.txt list. From this base name bellow add the parts of the path that are the same for all samples, and leave "$SAMPLE" as the variable name. 

SAMPLE=$1 # we get this value from the submit script

SOURCE="$SAMPLE"

DESTINATION=/exports/csce/datastore/biology/groups/kunath/scRNAseq/outs/CellRanger


#
# Perform copy with rsync
# Note: do not use -p or -a (implies -p) as this can break file ACLs at the destination
rsync -rl --remove-source-files ${SOURCE} ${DESTINATION}

