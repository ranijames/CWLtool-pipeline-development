cwlVersion: v1.0
class: CommandLineTool
doc: Spladder

baseCommand: [python,-m,spladder.spladder]

hints:
  cwltool:InplaceUpdateRequirement:
    inplaceUpdate: true

requirements:
  EnvVarRequirement:
     envDef:
       PYTHONPATH: /cluster/work/grlab/projects/PHRT_tools/spladder_tools/python
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
     - entry: $(inputs.spladder_dir)
       writable: true

inputs:
 spladder_gtf:
  type: File
  inputBinding:
   position: 3
   prefix: -a
 spladder_bam:
  type: File[]
  inputBinding:
   position: 1
   prefix: -b
   itemSeparator: ","
  secondaryFiles: .bai
 spladder_dir:
  type: Directory
  inputBinding:
   position: 2
   prefix: -o
 spladder_phase2:
  type: string
  inputBinding:
   position: 4
   prefix: -T
 spladder_merge_graphs:
  type: string
  inputBinding:
    position: 5
    prefix: -M
 spladder_qmode:
  type: string
  inputBinding:
    position: 7
    prefix: --qmode
 spladder_quantify_graph:
  type: string
  inputBinding:
    position: 6
    prefix: --quantify_graph

#arguments:
 #- $(inputs.spladder_dir.basename)/new_file

outputs:
 spladder_out:
  type: Directory
  outputBinding:
   glob: $(inputs.spladder_dir.basename)

$namespaces:
  cwltool: http://commonwl.org/cwltool#
