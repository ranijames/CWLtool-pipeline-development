cwlVersion: v1.0
class: CommandLineTool
doc: Immuno Peptide Package

baseCommand: [immunopepper]

requirements:
 - class: InlineJavascriptRequirement
 - class: InitialWorkDirRequirement
   listing:
    - entry: "$({class: 'Directory', listing: []})"
      entryname: $(inputs.peptide_outDir)
      writable: true

inputs:
 samples:
  type: string[]
  inputBinding:
   prefix: --samples
 peptide_outDir:
  type: string?
  inputBinding:
   prefix: --output_dir
 spliceFile:
  type: File
  inputBinding:
   prefix: --splice_path
 annotation:
  type: File
  inputBinding:
   prefix: --ann_path
 reference:
  type: File
  inputBinding:
   prefix: --ref_path
 gtexJunction:
  type: File
  inputBinding:
   prefix: --gtex_junction_path

outputs:
 peptideOutDir:
  type: Directory
  outputBinding:
   glob: $(inputs.peptide_outDir)
