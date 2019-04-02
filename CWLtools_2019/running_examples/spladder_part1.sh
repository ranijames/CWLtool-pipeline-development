source activate /cluster/home/aalva/software/anaconda/envs/py2/
bsub -M 40000 -W 12:00 -R "rusage[mem=40000]" -J phrt_test1 -o phrt_test1.job cwltool ../cwltools/spladder_part1.cwl ../yml/sp1adder_part1.yml 
