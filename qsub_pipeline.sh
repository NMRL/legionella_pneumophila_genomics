#!/bin/bash
#PBS -N lpgenomics
#PBS -l walltime=01:00:00
#PBS -l procs=16
#PBS -l pmem=2g
#PBS -q batch
#PBS -j oe
#PBS -A rakus

module load singularity
cd /mnt/home/groups/nmrl/bact_analysis/legionella_pneumophila_genomics
mkdir -p lpgenomics_temp/
cp $1 lpgenomics_temp/
cp $2 lpgenomics_temp/
R1_FASTQ=lpgenomics_temp/$(basename $1)
R2_FASTQ=lpgenomics_temp/$(basename $2)
SAMPLE=$(python -c "print('$R1_FASTQ'.split('_')[0])")

if ( file $1 | grep -q compressed ) ; then
    singularity run image_files/pigz_latest.sif -d $R1_FASTQ $R2_FASTQ
fi
  
bash pipeline.sh --reference=supportFiles/Phila_NC_002942.fna --gff=supportFiles/NC_002942.gff --r1=${R1_FASTQ::-3} --r2=${R2_FASTQ::-3} --isolate=$SAMPLE --output=./output

rm -r ~/lpgenomics_temp