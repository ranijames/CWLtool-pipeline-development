source activate /cluster/home/aalva/software/anaconda/envs/py2/
bsub -M 40000 -W 12:00 -R "rusage[mem=40000]" -J phrt_test1 -o phrt_test1.job cwltool /cluster/home/aalva/Projects/PHRT-Immuno/CWL-PHRT/tools-cwl/CWLtools_2019/cwltools/pipeline_main_parallel.cwl /cluster/home/aalva/Projects/PHRT-Immuno/CWL-PHRT/tools-cwl/CWLtools_2019/yml/pipeline_main_example.yml
