cwlVersion: v1.0
class: CommandLineTool
doc: Spladder

baseCommand: [python, -m, spladder.spladder]

requirements:
 - class: InlineJavascriptRequirement
 - class: InitialWorkDirRequirement
   listing:
    - entry: "$({class: 'Directory', listing: []})"
      entryname: $(inputs.spladder_outDir)
      writable: true
 - class: EnvVarRequirement
   envDef:
    - envName: PYTHONPATH
      envValue: $(inputs.spladder_pythonpath)

inputs:
 spladder_gtf:
  type: File
  inputBinding:
   position: 3
   prefix: -a
 spladder_bam:
  type: File
  inputBinding:
   position: 1
   prefix: -b
  secondaryFiles: .bai
 spladder_outDir:
  type: string
  inputBinding:
   position: 2
   prefix: -o
 spladder_phase2:
  type: string
  inputBinding:
   position: 6
   prefix: -T
 spladder_merge_graphs:
  type: string
  inputBinding:
    position: 5
    prefix: -M
 spladder_primary_alignment:
  type: string
  inputBinding:
    position: 10
    prefix: -P
 spladder_confidence:
  type: int
  inputBinding:
    position: 4
    prefix: -c
 spladder_alt:
  type: string
  inputBinding:
    position: 7
    prefix: -t
 spladder_validate:
  type: string
  inputBinding:
    position: 8
    prefix: -V
 spladder_RL:
  type: int
  inputBinding:
    position: 9
    prefix: -n
 spladder_pythonpath:
   type: string

outputs:
 spladder_out:
  type: File
  outputBinding:
   glob: $(inputs.spladder_outDir)/spladder/*.pickle

$namespaces:
  cwltool: http://commonwl.org/cwltool#
