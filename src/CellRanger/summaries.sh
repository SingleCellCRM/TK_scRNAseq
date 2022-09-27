# copy all the web summaries and concatenate them
cd /u/datastore/CSCE/biology/groups/kunath/scRNAseq/outs/CellRanger/
summaries=/u/datastore/CSCE/biology/groups/kunath/scRNAseq/outs/CellRanger/summaries/combined_metrics_summaries.csv
head -1 TK_1/outs/per_sample_outs/TK_1A/metrics_summary.csv > $summaries

for sample in *
 do 
 cd $sample/outs/per_sample_outs
 echo sample: $sample
 echo pwd sample/outs/per_sample_outs: $(pwd)
for subsample in *
	do 
	echo subsample: $subsample
	cp $subsample/web_summary.html /u/datastore/CSCE/biology/groups/kunath/scRNAseq/outs/CellRanger/summaries/$subsample.html
	sed "s/$/,$subsample/" $subsample/metrics_summary.csv | tail +2 >> $summaries
	done
cd /u/datastore/CSCE/biology/groups/kunath/scRNAseq/outs/CellRanger/
done
