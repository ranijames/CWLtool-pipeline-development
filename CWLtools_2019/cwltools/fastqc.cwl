cwlVersion: v1.0
class: CommandLineTool
doc: "CWL file for the tool FASTQC"
baseCommand: [/cluster/apps/gcc-4.8.5/fastqc-0.11.4-cws7mmvqaryah6hhesttbnzuqgpv6juu/bin/fastqc, -o, .]

requirements:
 ResourceRequirement:
   ramMax: 8000
   outdirMax: 4000

inputs:
 fq1:
  type: File
  inputBinding:
   position: 1
 fq2:
  type: File
  inputBinding:
   position: 2
arguments:
  - prefix: -o
    valueFrom: $(runtime.outdir)
outputs:
 fastqc_zip:
  type: File[]
  outputBinding:
   glob: "$(runtime.outdir)/*.zip"
 fastqc_html:
  type: File[]
  outputBinding:
   glob: "$(runtime.outdir)/*.html"
