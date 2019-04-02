cwlVersion: v1.0
class: CommandLineTool
doc: "Script to figure out the failed FASTQC results"

baseCommand: [sh, /cluster/work/grlab/share/software/rnaseq/fastqc_check_v0.sh]

inputs:
 fq1_zips:
  type: File[]
  inputBinding:
   position: 1
outputs:
 fastqc_check_out:
  type: File
  outputBinding:
   glob: $(inputs.fq1_zips.nameroot).summary
