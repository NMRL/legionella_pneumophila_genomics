# Legionella pneumophila in silico Serogroup Prediction

Version: 0.2.0.1

This project contains a bioinformatics workflow and related configuration scripts     </br> to analyze Legionella pneumophila whole genome sequencing data to predict serogroup from short read sequences.

## Requirements

In order to execute this workflow please ensure that your computing environment meents the following requirements:

1. HPC cluster with Linux OS and PBS job scheduler
2. singularity available via ```module load singularity```
3. At least 18Gb of RAM per process/job
    
## Installation
```
git clone https://github.com/NMRL/legionella_pneumophila_genomics
cd legionella_pneumophila_genomics
bash download_tools.sh
```
- Change full path to legionella_pneumophila_genomics folder in line 11 of qsub_pipeline.sh

## Running the Pipeline
### Interactive mode 
 - Read files should be in fastq format (fastq.gz must be decompressed first)
```
./pipeline.sh --reference=./supportFiles/Phila_NC_002942.fna --gff=./supportFiles/NC_002942.gff --r1=PATH_TO_READ1 --r2=PATH_TO_READ1 --isolate=SAMPLE_NAME --output=./OUTPUT_DIRECTORY_NAME
```
### As a job on the computing node of the HPC cluster
 - Both compressed (fastq.gz) and uncompressed (fastq) files are accepted
```
qsub -F "PATH_TO_READ1 PATH_TO_READ2" qsub_pipeline.sh
```

## Developed by

[Shatavia Morrison](https://github.com/SMorrison42)


[John Phan](https://github.com/jhphan)


[NMRL](https://github.com/NMRL)


## License

The repository utilizes code licensed under the terms of the Apache Software License and therefore is licensed under ASL v2 or later.

This source code in this repository is free: you can redistribute it and/or modify it under the terms of the Apache Software License version 2, or (at your option) any later version.

This source code in this repository is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Apache Software License for more details.

You should have received a copy of the Apache Software License along with this program. If not, see http://www.apache.org/licenses/LICENSE-2.0.html

The source code forked from other open source projects will inherit its license.

## Privacy

This repository contains only non-sensitive, publicly available data and information. All material and community participation is covered by the Surveillance Platform Disclaimer and Code of Conduct. For more information about CDC's privacy policy, please visit http://www.cdc.gov/privacy.html.

## Contributing

Anyone is encouraged to contribute to the repository by forking and submitting a pull request. (If you are new to GitHub, you might start with a basic tutorial.) By contributing to this project, you grant a world-wide, royalty-free, perpetual, irrevocable, non-exclusive, transferable license to all users under the terms of the Apache Software License v2 or later.

All comments, messages, pull requests, and other submissions received through CDC including this GitHub page are subject to the Presidential Records Act and may be archived. Learn more at http://www.cdc.gov/other/privacy.html.

## Records

This repository is not a source of government records, but is a copy to increase collaboration and collaborative potential. All government records will be published through the CDC web site.

## Notices

Please refer to CDC's Template Repository for more information about contributing to this repository, public domain notices and disclaimers, and code of conduct.
