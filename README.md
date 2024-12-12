# An Automated Snakemake Pipeline for Detecting Antimicrobial Resistance (AMR) Genes
This project provides an automated Snakemake-based pipeline designed to streamline the detection and analysis of antimicrobial resistance (AMR) genes from genomic sequencing data. It facilitates the integration of bioinformatics tools and resources to efficiently process large datasets, particularly those derived from public repositories, such as NCBI. The pipeline supports researchers working on AMR-related studies by automating tasks and ensuring reproducibility across different computing environments.

## Features
- **Automated Workflow**: Implements Snakemake to manage complex workflows and dependencies with minimal manual intervention.
- **Comprehensive AMR Analysis**: Utilizes established AMR databases to accurately identify resistance genes across bacterial isolates.
- **Scalability**: Capable of handling large datasets, including thousands of genomic sequences, with built-in parallelization support.
- **Reproducibility**: Each step in the analysis is reproducible and well-documented, making the pipeline suitable for long-term studies and collaboration.

## Requirements
- **Perl** (version 5.26.2)
- **Python** (version 3.7.12)
- **Roary** (version 3.13.0)
- **Prokka** (version 1.14.6)
- **Snakemake** (version 5.5.4)
- **MLST**
- **AMRFinderPlus**
- Additional bioinformatics tools: perl-bioperl, ncbi-datasets-cli, ncbi-amrfinderplus, seaborn, biopython

## Getting Started
To use this pipeline, install required dependencies, and configure the Snakemake workflow file to suit your dataset and computational environment.

### Set up the Environments
To streamline the pipeline’s requirements, you can set up a single Conda environment containing all necessary packages.

1. **Create the Conda environment**
   Run the following command to create an environment named `amr_pipeline_env`:

   ```bash
   $ conda create -n amr_pipeline_env perl=5.26.2 python=3.7.12 roary=3.13.0 -c bioconda -c conda-forge
   $ conda install perl-bioperl prokka=1.14.6 snakemake=5.5.4 -c bioconda -c conda-forge
   ```

2. **Activate the environment**
  After creating the environment, activate it with:

   ```bash
   $ conda activate amr_pipeline_env
   ```

3. **Install additional dependencies**
   Once the environment is active, install the remaining tools with the following commands:

   ```bash
   $ conda install -c conda-forge ncbi-datasets-cli
   $ conda install -y -c conda-forge -c bioconda --strict-channel-priority ncbi-amrfinderplus
   $ conda install -c conda-forge seaborn
   $ conda install -c conda-forge biopython
   ```

4. **Download and Update AMRFinderPlus Database**
   Once all packages are installed, update the AMRFinderPlus database to ensure it has the latest AMR gene information. Run the following command:

   ```bash
   $ amrfinder -u
   ```

### Configure the pipeline
Open the config.yaml file and update the following parameters as needed:

- **input_name**: Path to your input data (List of Gene ID .txt file).
- **output_path**: Desired output directory.

### Run the pipeline
Execute the Snakemake workflow by specifying the number of cores.

```bash
$ snakemake -s <snakefile> --cores <number_of_cores>
```

### Output
The pipeline generates detailed reports and visualizations of detected AMR genes, including:

- AMR gene presence/absence matrices.
- Summary tables and figures for further analysis.

### Phylogenetic analysis
- meta data (locations)

| Assembly               | Province   |
| -------------------- | :--------: |
| GCA_001195065.2_tha    | Thailand   |
| GCA_001209045.2_ma     | Malaysia   |
| GCA_963561015.1        | Udonthani  |

- AMR data
  
| Assembly               |	aac6-III |	blaPEN-I	| blaOXA-57	| blaOXA-59	| blaOXA |
| -------------------- | :--------: | :--------: | :--------: | :--------: | :--------: |
| GCA_001195065.2_tha |	Y	| Y |	Y |	N |	N |
| GCA_001209045.2_ma	| Y |	Y	| N	| Y	| N |
| GCA_963561015.1 | Y	| Y	| N	| Y	| N |

