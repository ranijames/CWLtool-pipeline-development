source activate /cluster/home/aalva/software/anaconda/envs/py2
bsub -M 40000 -W 12:00 -R "rusage[mem=40000]" -J spladder_graphs_qunatify -o spladder_graphs_qunatify.job cwltool --enable-ext /cluster/home/aalva/Projects/PHRT-Immuno/CWL-PHRT/tools-cwl/CWLtools_2019/cwltools/spladder_part3_4.cwl /cluster/home/aalva/Projects/PHRT-Immuno/CWL-PHRT/tools-cwl/CWLtools_2019/yml/spladder_part3.yml
