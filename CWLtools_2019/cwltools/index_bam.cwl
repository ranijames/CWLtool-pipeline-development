cwlVersion: v1.0
class: CommandLineTool
doc: "samtools: index"

baseCommand: [/cluster/apps/gcc-4.8.5/samtools-1.2-lviwhrwl3wjrqqyloh3362zjxnwhpops/bin/samtools, index]

requirements:
 InitialWorkDirRequirement:
  listing: [ $(inputs.bam) ]

inputs:
 bam:
  type: File
  inputBinding:
   position: 1
   valueFrom: $(self.basename)

outputs:
 indexed_bam:
  type: File
  secondaryFiles: .bai
  outputBinding:
   glob: $(inputs.bam.basename)
