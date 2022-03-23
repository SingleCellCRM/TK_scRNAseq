#!/bin/bash
#
cd /exports/eddie/scratch/$USER/TK/
# we do not need read in samples file, as they are just TK_i
#while read -r SAMPLE || [ -n "$SAMPLE" ]
for i in {1..8}
do
  SAMPLE="TK_$i"
  n=$i
  # increment one the counter
 # ((n+=1))
  # for the first one process waiting for stagein, and stageout wait for process
if [[ $n -eq 1 ]]; then
 # the data is already in
#   qsub -N stagein_"$n" stagein.sh $SAMPLE
#   qsub -N cellranger_"$n" -hold_jid stagein_"$n" runCellRanger.sh $SAMPLE
    qsub -N cellranger_"$n" src/runCellRangerMulti.sh $SAMPLE    
    qsub -N stageout_"$n" -hold_jid cellranger_"$n" src/stageout.sh $SAMPLE

  # for the following ones also wait until the previous one has stageout before stagin
else
# data is already in
#   qsub -N stagein_"$n" -hold_jid stageout_"$((n-1))" stagein.sh $SAMPLE
#   qsub -N cellranger_"$n" -hold_jid stagein_"$n" runCellRanger.sh $SAMPLE
    qsub -N cellranger_"$n" -hold_jid stageout_"$((n-1))" src/runCellRangerMulti.sh $SAMPLE
    qsub -N stageout_"$n" -hold_jid cellranger_"$n" src/stageout.sh $SAMPLE
  
fi

done












