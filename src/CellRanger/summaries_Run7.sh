# copy all the web summaries and concatenate them
cd /u/datastore/CSCE/biology/groups/kunath/scRNAseq/outs/CellRanger_Run1-7/
summaries=/u/datastore/CSCE/biology/groups/kunath/scRNAseq/outs/CellRanger_Run1-7/summaries/
summaries_csv=$summaries/combined_metrics_summaries.csv
mkdir -p $summaries
head -1 TK_1/outs/per_sample_outs/TK_1A/metrics_summary.csv > $summaries_csv

for sample in *
 do 
 cd $sample/outs/per_sample_outs
 echo sample: $sample
 echo pwd sample/outs/per_sample_outs: $(pwd)
for subsample in *
	do 
	echo subsample: $subsample
	cp $subsample/web_summary.html $summaries/$subsample.html
	sed "s/$/,$subsample/" $subsample/metrics_summary.csv | tail +2 >> $summaries_csv
	done
cd /u/datastore/CSCE/biology/groups/kunath/scRNAseq/outs/CellRanger_Run1-7/
done
