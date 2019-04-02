#!/usr/bin/env bash

BASE_DIR="/cluster/work/grlab/projects/alva_temp/Toil_poc/Toil_ARJ/PHRT5"
DATE=`date '+%Y-%m-%d-%H:%M:%S'`

JOB_STORE=${BASE_DIR}/jobstore/
WORK_DIR=${BASE_DIR}/wdir/
OUT_DIR=${BASE_DIR}/out_dir/
TMP_OUT_DIR=${BASE_DIR}/tmp_outdir/
TMP_DIR=${BASE_DIR}/tmpdir/
LOG_FILE=toil.log
mkdir -p ${WORK_DIR} ${OUT_DIR} ${TMP_OUT_DIR} ${TMP_DIR}
#rm -r ${JOB_STORE}
#rm ${LOG_FILE}
module load fastqc star
source activate toil
(toil-cwl-runner --stats --clusterStats --retryCount=0 --batchSystem=lsf --disableCaching --tmpdir-prefix ${TMP_DIR} --tmp-outdir-prefix ${TMP_OUT_DIR} --workDir ${WORK_DIR} --realTimeLogging --cleanWorkDir=never --clean=never --outdir ${OUT_DIR} --logDebug  --logFile ${OUT_DIR}/CWL.log --jobStore ${JOB_STORE} pipeline_main_parallel.cwl pipeline_main_example.yml)>& CWL.${DATE}.log &
#cp toil.log ${OUT_DIR}/toil.${DATE}.log
