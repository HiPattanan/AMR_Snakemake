# An Automated Snakemake Pipeline for Detecting Antimicrobial Resistance (AMR) Genes
This project provides an automated Snakemake-based pipeline designed to streamline the detection and analysis of antimicrobial resistance (AMR) genes from genomic sequencing data. It facilitates the integration of bioinformatics tools and resources to efficiently process large datasets, particularly those derived from public repositories, such as NCBI. The pipeline supports researchers working on AMR-related studies by automating tasks and ensuring reproducibility across different computing environments.

## Features
- **Automated Workflow**: Implements Snakemake to manage complex workflows and dependencies with minimal manual intervention.
- **Comprehensive AMR Analysis**: Utilizes established AMR databases to accurately identify resistance genes across bacterial isolates.
- **Scalability**: Capable of handling large datasets, including thousands of genomic sequences, with built-in parallelization support.
- **Reproducibility**: Each step in the analysis is reproducible and well-documented, making the pipeline suitable for long-term studies and collaboration.

## Requirements
- **Snakemake** (version X.X.X)
- **Python** (version 3.X or higher)
- Additional dependencies (e.g., bioinformatics tools and libraries) will be specified in the environment file (e.g., `environment.yml`).

## Getting Started
To use this pipeline, install required dependencies, and configure the Snakemake workflow file to suit your dataset and computational environment.

```bash
git clone https://github.com/yourusername/amr-detection-pipeline.git
cd amr-detection-pipeline
```
### Set up the environments
#### For Roary
```bash
conda create -n roary_env perl=5.26.2 python=3.9 roary=3.13.0 -c bioconda -c conda-forge
conda activate roary_env
conda install bioconda::snakemake=5.5.4
```

#### For Prokka
```bash
conda create -n prokka_env perl-bioperl prokka=1.14.6 python=3.9.15 snakemake=5.5.4 -c bioconda -c conda-forge
conda activate prokka_env
conda install conda-forge::ncbi-datasets-cli
conda install -y -c conda-forge -c bioconda --strict-channel-priority ncbi-amrfinderplus
```

#### Download
amrfinder -u

#### Configure the pipeline
Open the config.yaml file and update the following parameters as needed:

- **input_path**: Path to your input data (e.g., genomic FASTA files).
- **output_path**: Desired output directory.

#### Run the pipeline
Execute the Snakemake workflow by specifying the number of cores.

```bash
snakemake -s <snakefile> --cores <number_of_cores>
```

#### Output
The pipeline generates detailed reports and visualizations of detected AMR genes, including:

AMR gene presence/absence matrices.
Summary tables and figures for further analysis.
