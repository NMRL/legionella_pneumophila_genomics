#!/bin/bash


###############################################################################
#### The script allows to configure the pipeline to be run in the RTU-HPC environment ####
###############################################################################

module load singularity
cd image_files
for i in $(cat ../tools.txt) ; do singularity pull $i ; done
cd ../
chmod -R 775 ./