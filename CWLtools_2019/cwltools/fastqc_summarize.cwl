cwlVersion: v1.0
class: CommandLineTool
doc: "Combines the FASQTC fails for a sample"

baseCommand: [cat]

inputs:
 sample: string
 fq1_summary:
  type: File[]
  inputBinding:
   position: 1
outputs:
 fastqc_summarize_out:
  type: stdout

stdout: $(inputs.sample)_fastqc.summary
