#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: [/cluster/work/grlab/share/modules/packages/star/2.5.3a/bin/STAR]
doc: "STAR: Alignment"

requirements:
 ResourceRequirement:
  coresMax: $(inputs.runThreadN)
  ramMax: 40000

inputs:
 genomeDir:
  type: Directory
  inputBinding:
   position: 1
   prefix: --genomeDir
 reads1:
  type: File
  inputBinding:
   position: 2
   #itemSeparator: ','
   prefix: --readFilesIn
 reads2:
  type: File
  inputBinding:
   position: 3
   #itemSeparator: ','
 runThreadN:
  type: int?
  inputBinding:
   position: 4
   prefix: --runThreadN
 outFilterMultimapScoreRange:
  type: int?
  inputBinding:
   position: 5
   prefix: --outFilterMultimapScoreRange
 outFilterMultimapNmax:
  type: int?
  inputBinding:
   position: 6
   prefix: --outFilterMultimapNmax
 outFilterMismatchNmax:
  type: int?
  inputBinding:
   position: 7
   prefix: --outFilterMismatchNmax
 alignIntronMax:
  type: int?
  inputBinding:
   position: 8
   prefix: --alignIntronMax
 alignMatesGapMax:
  type: int?
  inputBinding:
   position: 9
   prefix: --alignMatesGapMax
 sjdbScore:
  type: int?
  inputBinding:
   position: 10
   prefix: --sjdbScore
 alignSJDBoverhangMin:
  type: int?
  inputBinding:
   position: 11
   prefix: --alignSJDBoverhangMin
 genomeLoad:
  type: string?
  inputBinding:
   position: 12
   prefix: --genomeLoad
 limitBAMsortRAM:
  type: long?
  inputBinding:
   position: 13
   prefix: --limitBAMsortRAM
 readFilesCommand:
  type: string[]
  inputBinding:
   position: 14
   prefix: --readFilesCommand
 outFilterMatchNminOverLread:
  type: float?
  inputBinding:
   position: 15
   prefix: --outFilterMatchNminOverLread
 outFilterScoreMinOverLread:
  type: float?
  inputBinding:
   position: 16
   prefix: --outFilterScoreMinOverLread
 sjdbOverhang:
  type: int?
  inputBinding:
   position: 17
   prefix: --sjdbOverhang
 outSAMstrandField:
  type: string?
  inputBinding:
   position: 18
   prefix: --outSAMstrandField
 outSAMattributes:
  type: string[]
  inputBinding:
   position: 19
   prefix: --outSAMattributes
   shellQuote: false
 sjdbGTFfile:
  type: File?
  inputBinding:
   position: 20
   prefix: --sjdbGTFfile
 limitSjdbInsertNsj:
  type: int?
  inputBinding:
   position: 21
   prefix: --limitSjdbInsertNsj
 outSAMunmapped:
  type: string?
  inputBinding:
   position: 22
   prefix: --outSAMunmapped
 outSAMtype:
  type: string[]
  inputBinding:
   position: 23
   prefix: --outSAMtype
 outSAMheaderHD:
  type: string[]
  inputBinding:
   position: 24
   prefix: --outSAMheaderHD
 outSAMattrRGline:
  type: string?
  inputBinding:
   position: 25
   prefix: --outSAMattrRGline
 twopassMode:
  type: string?
  inputBinding:
   position: 26
   prefix: --twopassMode
 outSAMmultNmax:
  type: int?
  inputBinding:
   position: 27
   prefix: --outSAMmultNmax
 outFileNamePrefix:
  type: string
  inputBinding:
   position: 28
   prefix: --outFileNamePrefix

outputs:
 star_bam:
  type: File
  outputBinding:
   glob: "*.bam"
