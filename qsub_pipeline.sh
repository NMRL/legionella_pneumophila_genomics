#!/bin/bash
#PBS -N lpgenomics
#PBS -l walltime=01:00:00
#PBS -l procs=16
#PBS -l pmem=1.5g
#PBS -q batch
#PBS -j oe
#PBS -A rakus

# module load singularity
COMPRESS=false
if (file $1 | grep -q compressed ) ; then
    singularity run image_files/pigz_latest.sif -d $1 $2
    COMPRESS=true
fi

bash pipeline.sh --reference=supportFiles/Phila_NC_002942.fna --gff=supportFiles/NC_002942.gff --r1=${1::-3} --r2=${2::-3} --isolate=test --output=$3

if $COMPRESS; then
    singularity run image_files/pigz_latest.sif -5 ${1::-3} ${2::-3}
fi