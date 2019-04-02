cwlVersion: v1.0
class: CommandLineTool
doc: "Script to incrementally count expression"

baseCommand: [/cluster/home/aalva/software/anaconda/envs/py2/bin/python2.7, /cluster/home/aalva/Projects/PHRT-Immuno/projects2013-pancancertcga/count_expression/collect_counts.py]

inputs:
 increment_tsv:
  type: File
  inputBinding:
   position: 2
   itemSeparator: ','
 increment_out:
  type: string
  inputBinding:
   position: 1

outputs:
 incre_output:
  type: File
  outputBinding:
   glob: $(runtime.outdir)/sample.hdf5
