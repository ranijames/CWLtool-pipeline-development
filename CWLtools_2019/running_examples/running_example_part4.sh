source activate /cluster/home/aalva/software/anaconda/envs/py2
bsub -M 40000 -W 12:00 -R "rusage[mem=40000]" -J spladder_merge_quantified_graphs 4 -o spladder_merge_quantified_graphs.job cwltool --enable-ext spladder_part3_4.cwl spladder_part4.yml
