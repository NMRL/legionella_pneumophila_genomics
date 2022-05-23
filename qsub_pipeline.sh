#!/bin/bash
#PBS -N lpgenomics
#PBS -l walltime=03:00:00
#PBS -l procs=16
#PBS -l pmem=2g
#PBS -q batch
#PBS -j oe
#PBS -A rakus

###LOADING MODULES AND FORMATTING INPUT
module load singularity
R1_FASTQ=lpgenomics_temp/$(basename $1)
R2_FASTQ=lpgenomics_temp/$(basename $2)
SAMPLE=$(python -c "print('$(basename $1)'.split('_')[0])")

###CREATING WORKING DIRECTORY AND COPYING FILES
cd /mnt/home/groups/nmrl/bact_analysis/legionella_pneumophila_genomics
mkdir -p lpgenomics_temp/
cp $1 lpgenomics_temp/
cp $2 lpgenomics_temp/

###DECOMPRESSING GZIPPED FILES
if ( file $1 | grep -q compressed ) ; then
    singularity run image_files/pigz_latest.sif -d $R1_FASTQ $R2_FASTQ
    R1_FASTQ=${R1_FASTQ::-3}
    R2_FASTQ=${R2_FASTQ::-3}
fi

###CREATING LOCK FILE TO DEAL RACE CONDITION ON WORKING DIRECTORY BETWEEN JOBS (WHILE LOCK FILES EXIST IN WORKING DIRECTORY, IT SHOULD NOT BE DELETED) & RUNNING THE PIPELINE 
touch lpgenomics_temp/${SAMPLE}.lock
bash pipeline.sh --reference=supportFiles/Phila_NC_002942.fna --gff=supportFiles/NC_002942.gff --r1=$R1_FASTQ --r2=$R2_FASTQ --isolate=$SAMPLE --output=./${SAMPLE}_output

###CHECKING RACE CONDITION AND PERFORMING CLEANUP
if ( ! ls lpgenomics_temp/ | grep -q .lock ); then
    rm -r lpgenomics_temp/*
else
    rm lpgenomics_temp/$SAMPLE.lock
    rm $R1_FASTQ
    rm $R2_FASTQ
fi