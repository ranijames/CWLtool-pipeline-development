source activate /cluster/home/aalva/software/anaconda/envs/py2
bsub -M 40000 -W 12:00 -R "rusage[mem=40000]" -J spladder_graphs -o spladder_graphs.job cwltool --enable-ext spladder_part2.cwl pispladder_part2.yml
