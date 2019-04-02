# SOCIBP_2019 workflow (CWL tools) 

The README contains CWL tools and the workflows for SOCIBP-2019 project. The main language used for this setup is, Common Workflow Language (CWL) is a workflow management system which allows describing the analysis workflows and the command-line tools. This workflow is part of testing the scatter function of CWLtool, and eventually use it to run under toil. Therefore, we used only two samples in each parts. 


In SOCIBP-2019 we are taking advantage of the CWLtool's internal paralleling or scattering property. In addition to that, the 2019 version provides with an expression tool which generates output for each stage. We made use of Java Expression tools, for generating output directories for each stage.
 
The prerequisites and necessary steps are explained in the following.

### Prerequisites ###

You need the following tools available in the PATH of your environment:

* **cwltool (v1.0.20181012180214 or higher)**

    * Please refer to the [CWL documentation](https://github.com/common-workflow-language/cwltool) if you are interested in further details.
    
 * **Python 2.7**
 
    * The following packages are needed: pip nodejs pickle h5py 
  
  
As a preparatory step, please follow the additional steps. The tools used within the cwltools need certain python libraries. Details of installation procedure are defined below. 
  
First start with cloning the repository and checking out the right branch.
  
  
  ```
git clone git@github.com:ratschlab/tools-cwl.git
cd tools-cwl/
git checkout SOCIBP_2019
```

Then adding additional changes and installing appropriate libraries.

```
cd CWLtools_2019/running_examples/
conda create -n SOCIBP_2019 -c default python=2.7
source activate SOCIBP_2019
pip install pysam
pip install scipy
pip install pickle
pip install h5py
pip install nodeenv
nodeenv -p
```

If you are interested in trying the whole CWLTOOLs in toil, please follow the following intsructions.

```
pip install https://github.com/ratschlab/toil/archive/leomedLsfFixes.zip#egg=toil[cwl]
sh run_v1.sh

```
Additionally, please make sure that you change the current paths to your local directories, where required. Mostly, this is important for the shell scripts in `running_example` folder. For example in `run_v1.sh`, change BASE_DIR, add ../cwltools/ and ../yml/ paths to toil runner command. 


## CWL workflow ##

The workflows are divided into six parts: 

1) Quality control, alignment, and quantification
2) Compute the splice graphs
3) Merging the splice graphs
4) Quantifying the splice graphs
5) Merge the quantified splice graphs
6) Peptide translation

The input for each part are:
 
 i) a `.cwl` file that contains the logical steps of the pipeline the name of all necessary parameters; and ii) a `.yml` file that provides the actual values for each parameter.

 Currently, all individual steps can be used on multiple samples as `CWLtools`. 
 
The following session takes you through how to run each step for the outputs.

## Part 1. Quality control, alignment, and quantification ##

 The first part consists of following CWL tools, two main workflows, and the supporting YML file.
 
 The CWL tools are:
 
 ```
   a) star.cwl
   
   b) fastqc.cwl
   
   e) count_expression.cwl
```
  
 The two main workflows:
 
 ```
   a) pipeline_main_parallel.cwl
   b) expression_count_pipeline.cwl 
 ```
   
Each workflow is defined with steps, which invokes the previously defined CWLtools. In addition to that, workflow generates individual output directories for each step.

The YML file: 

    `pipeline_main_example.yml`
 
 In order to submit the first part to the cluster, please run the following one-liner: We believe you are now in PHRT environment
 
  `sh running_examples/runing_example_part1.sh`
 
 The above first part of the pipeline generates three directories with output files from each step defined in the workflow. Please note the CWLtool generate all its outputs at the directory where you run it. So make sure you run `runing_example_part*.sh`, at your desired designated output directory. The following are the output directories with the output files.
 
   1. fastqc_results [contains results after quality assements (.html and .zip files) ]
   2. alignment [contains all aligned files (.bam files)]
   3. read_quantification [contains all gene expression files (.tsv files)]
   
### Part 2. Compute the splice graphs ###


The second part consists of two CWL tool, a workflow, and one YML file. The second part is exclusively using one tool, called `spladder.py` and the `bam_index.cwl` tool in order to index previously generated `.bam` files. 

The CWL tool:

```
    index_bam.cwl
    spladder_part1.cwl
```
   
The CWL workflow:

  `spladder_main_parallel_part1.cwl`
   
The YML file:

   `pipeline_main_part2.yml`

Runing example:

  `sh running_examples/spladder_part1.sh`
 
The above line generates an individual `.pickle` file for each input sample (.bam files).
 
 ### Part 3. Merge the computed splice graphs ####
 
 This is the third part of the pipeline and second part of `spladder.py` tool, where it merges the previously generated `.pickle` files together. The third part consists of one CWL tool and one YML file.
 
 CWL tool:
 
  `spladder_part2.cwl`
 
 YML file:
 
 `spladder_part2.yml`
 
 Runing example:
  `sh running_examples/running_example_part2.sh`
 
 Please make sure you are running the above one-liner, at one level higher to the parent directory (../splicing/spladder). 
 
 
 ## Part 4-5. Quantify and merge the splice graphs ###

The third and fourth is using same CWL tolls but different YML file, as the differences are only in terms of a single parameter
   
   a) `spladder_part3_4.cwl`
 
The YML files:

  a) `spladder_part3.yml`
  b) `spladder_part4.yml`
 
In order to execute this third part, the user needs to wait until the computations for part 1-2 are completed.
 
 The running examples for part3 is defined in the following running example:
 
  `sh running_examples/running_example_part3.sh`
  
Similarly, for part4 user needs to wait until the part3 is finished.

The running example for part4:

   `sh running_examples/running_example_part4.sh`
   
Similarly, make sure to run both one-liners at one level higher to the parent directory  (../splicing/spladder).
   
## Part 6. Peptide translation ##

The sixth part takes the input file from part2 for its `spliceFile` parameter. In order to execute the cwltool, the user should provide the `genes_graph_conf3.merge_graphs.pickle` file from `Splicing/spladder` in the `peptide.yml` with its absolute path.

The peptide translation workflow consists of two CWL files and one YML file.

CWL workflow:

 ` peptide_main_parallel.cwl `

CWL commandline Tool: 
 
 ` peptide_package.cwl`
 
 The YML file:
 
 `peptide.yml`

To run the final part of the pipeline, you again can call the `running_example_part5.sh` script directly from the top-level directory as:

`sh running_examples/running_example_part5.sh`

The above step generates a directory:

a. peptide 


If the `immunopepper` tool is throwing error while invoking it under CWLtool please follow the following instructions:

```
git clone git@github.com:ratschlab/projects2018-immuno_peptide.git
conda install pip
```

And within the immunopepper directory:

```
pip install -r requirements.txt -r requirements_dev.txt
make install 
````
