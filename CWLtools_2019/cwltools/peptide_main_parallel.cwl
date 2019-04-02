#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
 - class: ScatterFeatureRequirement
 - class: SubworkflowFeatureRequirement
 - class: InlineJavascriptRequirement
 - class: MultipleInputFeatureRequirement

inputs:
 samples:
  type: string[]
 peptide_outDir:
  type: string
 spliceFile:
  type: File
 annotation:
  type: File
 reference:
  type: File
 gtexJunction:
  type: File

outputs:
 peptide_dir:
   type: Directory
   outputSource: collect/peptide_dir

steps:
  peptide:
    run: peptide_package.cwl
    scatter: [sample]
    scatterMethod: dotproduct
    in:
     sample: samples
     peptide_outDir: peptide_outDir
     spliceFile: spliceFile
     annotation: annotation
     gtexJunction: gtexJunction
     reference: reference

    out: [peptideOutDir]
  collect:
    in:
      peptide_files:
        source: [peptide/peptideOutDir]
        linkMerge: merge_flattened
    out: [peptide_dir]
    run:
      class: ExpressionTool
      id: "collect_step"
      inputs:
        peptide_files:
          type:
            type: array
            items: Directory
      outputs:
        peptide_dir: Directory
      expression: |
       ${
        return {

          "peptide_dir": {
             "class": "Directory",
             "basename": "Peptide/peptide_output",
             "listing":  inputs.peptide_files
          }
        };
        }
