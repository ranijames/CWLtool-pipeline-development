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
 spladder_qmode:
  type: string
 spladder_merge_graphs:
  type: string
 spladder_quantify_graph:
  type: string
 spladder_phase2:
  type: string
 spladder_dir:
  type: string
 bams:
   type: File[]


outputs:
 spladder_dir:
   type: Directory
   outputSource: collect/spladder_dir

steps:
  spladder:
    run: spladder_part3_4.cwl
    scatter: [spladder_bam]
    scatterMethod: dotproduct
    in:
     spladder_bam: bams
     spladder_gtf: spladder_gtf
     spladder_quantify_graph: spladder_quantify_graph
     spladder_merge_graphs: spladder_merge_graphs
     spladder_phase2: spladder_phase2
     spladder_qmode: spladder_qmode
     spladder_dir: spladder_dir

    out: [spladder_out]
# This session is for the expression tool for creating the Directory for each session
  collect:
    in:
      spladder_bam_files:
        source: [spladder/spladder_out]
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
             "listing": inputs.spladder_bam_files
          }
        };
        }

