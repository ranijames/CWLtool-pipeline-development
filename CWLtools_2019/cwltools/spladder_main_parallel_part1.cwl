#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
 - class: ScatterFeatureRequirement
 - class: SubworkflowFeatureRequirement
 - class: InlineJavascriptRequirement
 - class: MultipleInputFeatureRequirement

inputs:
 spladder_gtf:
  type: File
 spladder_confidence:
  type: int
 spladder_merge_graphs:
  type: string
 spladder_primary_alignment:
  type: string
 spladder_phase2:
  type: string
 spladder_alt:
  type: string
 spladder_RL:
  type: int
 spladder_validate:
  type: string
 spladder_outDir:
  type: string
 spladder_pythonpath:
  type: string
 bams:
   type: File[]


outputs:
 spladder_dir:
   type: Directory
   outputSource: collect/spladder_dir

steps:
  bam_index:
   run: index_bam.cwl
   scatter: [bam]
   scatterMethod: dotproduct
   in:
    bam: bams
   out: [indexed_bam]
  spladder:
    run: spladder_part1.cwl
    scatter: [spladder_bam]
    scatterMethod: dotproduct
    in:
     spladder_bam: bam_index/indexed_bam
     spladder_gtf: spladder_gtf
     spladder_confidence: spladder_confidence
     spladder_primary_alignment: spladder_primary_alignment
     spladder_merge_graphs: spladder_merge_graphs
     spladder_phase2: spladder_phase2
     spladder_alt: spladder_alt
     spladder_RL: spladder_RL
     spladder_validate: spladder_validate
     spladder_outDir: spladder_outDir
     spladder_pythonpath: spladder_pythonpath
    out: [spladder_out]
# This session is for the expression tool for creating the Directory for each session
  collect:
    in:
      spladder_bam_files:
        source: [spladder/spladder_out, bam_index/indexed_bam]
        linkMerge: merge_flattened
    out: [spladder_dir]
    run:
      class: ExpressionTool
      id: "collect_step"
      inputs:
        spladder_bam_files: File[]
      outputs:
        spladder_dir: Directory
      expression: |
       ${
        return {

          "spladder_dir": {
             "class": "Directory",
             "basename": "Splicing/spladder",
             "listing": [].concat.apply([], inputs.spladder_bam_files)
          }
        };
        }
