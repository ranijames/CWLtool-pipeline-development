#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
doc: "Script to calculate the expression counts"

baseCommand: [python2.7, /cluster/work/grlab/share/software/count_expression.py]

inputs:
 annotation:
  type: File
  inputBinding:
   prefix: -a
 bam:
  type: File
  inputBinding:
   prefix: -A
 exp_out:
  type: string
  inputBinding:
   prefix: -o

outputs:
 expression_out:
  type: File
  outputBinding:
   glob: $(inputs.exp_out)
