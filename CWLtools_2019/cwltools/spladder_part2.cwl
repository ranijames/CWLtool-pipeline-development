cwlVersion: v1.0
class: CommandLineTool
doc: Spladder for merging the graphs generated in the previous step

baseCommand: [python, -m, spladder.spladder]

hints:
  cwltool:InplaceUpdateRequirement:
    inplaceUpdate: true

requirements:
  EnvVarRequirement:
     envDef:
       PYTHONPATH: $(inputs.spladder_pythonpath)
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
     - entry: $(inputs.spladder_dir)
       writable: true

#arguments:
  #-  valueFrom: $(runtime.outdir+"/spladder_dir")
     #prefix: -o
     #position: 2

inputs:
 spladder_gtf:
  type: File
  inputBinding:
   position: 3
   prefix: -a
 spladder_bams:
  type: File[]
  inputBinding:
   position: 1
   prefix: -b
  secondaryFiles: .bai
 spladder_dir:
  type: Directory
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
  type: Directory
  outputBinding:
    glob: $(inputs.spladder_dir.basename)/spladder/
 spladderFile:
  type: File
  outputBinding:
    glob: $(inputs.spladder_dir.basename)/spladder/genes_graph_conf2.merge_graphs.pickle


$namespaces:
  cwltool: http://commonwl.org/cwltool
