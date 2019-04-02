#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
 - class: ScatterFeatureRequirement
 - class: SubworkflowFeatureRequirement
 - class: InlineJavascriptRequirement
 - class: MultipleInputFeatureRequirement

inputs:
 reads1:
  type: File[]
 reads2:
  type: File[]
 sample_names:
  type: string[]
 genomeDir:
  type: Directory
 sjdbGTFfile:
  type: File
 annotation:
  type: File
 exp_outs:
  type: string[]
 #increment_out:
  #type: string
 #increment_tsv:
  #type: File

outputs:
 #fastqc_check_dir:
  #type: Directory
  #outputSource: collect/fastqc_check_dir
 #fastqc_summ_dir:
   #type: Directory
   #outputSource: collect/fastqc_summ_dir
 fastqc_dir:
  type: Directory
  outputSource: collect/fastqc_dir
 count_dir:
  type: Directory
  outputSource: collect/count_dir
 bam_dir:
   type: Directory
   outputSource: collect/bam_dir

steps:
  pipeline_workflow:
     run: expression_count_pipeline.cwl
     scatter: [reads1, reads2, sample_name]
#Runs concurrently all the inputs in the array
     scatterMethod: dotproduct
     in:
      reads1: reads1
      reads2: reads2
      sample_name: sample_names
      genomeDir: genomeDir
      sjdbGTFfile: sjdbGTFfile
     out: [fastqc_out, fastqc_html, alignment_out]
  #fastqc_summarize:
     #run: fastqc_summarize.cwl
     #scatter: [sample, fq1_summary]
     #in:
      #sample: sample_names
      #fq1_summary: fastqc_check/fastqc_check_out
     #out: [fastqc_summarize_out]
  count_expression:
    run: count_expression.cwl
    scatter: [bam, exp_out]
    scatterMethod: dotproduct
    in:
     bam: pipeline_workflow/alignment_out
     annotation: annotation
     exp_out: exp_outs
    out: [expression_out]
  #count_collect:
    #run: count_incrementally.cwl
    #scatter: [increment_tsv]
    #scatterMethod: dotproduct
    #in:
      #increment_tsv: count_expression/expression_out
      #increment_out: increment_out
    #out: [incre_output]
# This session is for the expression tool for creating the Directory for each session
  collect:
    in:
      fastqc_files:
        source: [pipeline_workflow/fastqc_out, pipeline_workflow/fastqc_html]
        linkMerge: merge_flattened
      #fastqc_check_files:
        #source: [fastqc_check/fastqc_check_out]
        #linkMerge: merge_flattened
      #fastqc_summ_files:
        #source: [fastqc_summarize/fastqc_summarize_out]
        #linkMerge: merge_flattened
      bam_files:
        source: [pipeline_workflow/alignment_out]
        linkMerge: merge_flattened
      count_files:
        source: [count_expression/expression_out]
        linkMerge: merge_flattened
    out: [fastqc_dir, bam_dir, count_dir]
    run:
      class: ExpressionTool
      id: "collect_step"
      inputs:
        fastqc_files:
          type:
            type: array
            items:
              type: array
              items: File
        #fastqc_check_files: File[]
        count_files: File[]
        bam_files: File[]
      outputs:
        fastqc_dir: Directory
        #fastqc_check_dir: Directory
        count_dir: Directory
        bam_dir: Directory
      expression: |
       ${
        return {
          "fastqc_dir": {
             "class": "Directory",
             "basename": "fastqc_results",
             "listing": [].concat.apply([], inputs.fastqc_files)
          },
          "bam_dir": {
             "class": "Directory",
             "basename": "alignment",
             "listing": inputs.bam_files
          },
          "count_dir": {
             "class": "Directory",
             "basename": "read_quantification",
             "listing": inputs.count_files
          }
        };
        }
