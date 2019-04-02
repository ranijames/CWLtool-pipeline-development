source activate /cluster/home/aalva/software/anaconda/envs/py2
bsub -M 40000 -W 12:00 -R "rusage[mem=40000]" -J phrt_pepetide -o phrt_peptide.job cwltool /cluster/home/aalva/Projects/PHRT-Immuno/CWLtools_2019/cwltools/peptide_main_parallel.cwl /cluster/home/aalva/Projects/PHRT-Immuno/CWLtools_2019/yml/peptide.yml
