#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

doc: "Workflow Components: FASTQC -> Alignment  -> CountExpression"

inputs:
 reads1:
  type: File
 reads2:
  type: File
 sample_name:
  type: string
 #fastqc_check_script:
  #type: File
 genomeDir:
  type: Directory
 sjdbGTFfile:
  type: File
 #annotation:
  #type: File
 #exp_out:
  #type: string[]
 #genome:
  #type: File
  #outSAMattrRGline: string

outputs:
 fastqc_out:
  type: File[]
  outputSource: fastqc/fastqc_zip
 fastqc_html:
   type: File[]
   outputSource: fastqc/fastqc_html
 #fastqc_check_out:
  #type: File[]
  #outputSource: fastqc_check/fastqc_check_out
 #fastqc_summary_out:
  #type: File
  #outputSource: fastqc_summarize/fastqc_summarize_out
 alignment_out:
  type: File
  outputSource: star/star_bam
 #expression_out:
  #type: File
  #outputSource: count_expression/expression_out


steps:
 fastqc:
  run: fastqc.cwl
  in:
   fq1:
    source: reads1
   fq2:
    source: reads2
  out: [fastqc_zip, fastqc_html]
 #fastqc_check:
  #run: fastqc_check.cwl
  #in:
   #source: [fastqc/fastqc_zip]
   #scatter: fq1_zips
   #out: [fastqc_check_out]
 #fastqc_summarize:
  #run: fastqc_summarize.cwl
  #in:
   #sample_names: sample_names
   #fq1_summary:
    #source: fastqc_check/fastqc_check_out
  #out: [fastqc_summarize_out]
 star:
  run: star.cwl
  in:
   genomeDir: genomeDir
   reads1: reads1
   reads2: reads2
   sjdbGTFfile: sjdbGTFfile
   outFileNamePrefix: sample_name
   runThreadN:
    default: 4
   outFilterMultimapScoreRange:
    default: 1
   outFilterMultimapNmax:
    default: 20
   outFilterMismatchNmax:
    default: 10
   alignIntronMax:
    default: 500000
   alignMatesGapMax:
    default: 1000000
   sjdbScore:
    default: 2
   alignSJDBoverhangMin:
    default: 1
   genomeLoad:
    default: NoSharedMemory
   limitBAMsortRAM:
    default: 70000000000
   readFilesCommand:
    default: [gunzip, -c]
   outFilterMatchNminOverLread:
    default: 0.33
   outFilterScoreMinOverLread:
    default: 0.33
   sjdbOverhang:
    default: 100
   outSAMstrandField:
    default: intronMotif
   outSAMattributes:
    default: [NH, HI, NM, MD, AS, XS]
   limitSjdbInsertNsj:
    default: 2000000
   outSAMunmapped:
    default: None
   outSAMtype:
    default: [BAM, SortedByCoordinate]
   outSAMheaderHD:
    default: ["@HD", "VN:1.4"]
   outSAMattrRGline: #outSAMattrRGline
    default: ID::EOC11CTRL
   twopassMode:
    default: Basic
   outSAMmultNmax:
    default: 1
  out: [star_bam]
