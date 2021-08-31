# Virulence and Antibiotic Resistance Genes database in Region Östergötland

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Genomic-Medicine-Linkoping/var-genes-ro/HEAD)
[![DOI](https://zenodo.org/badge/372817270.svg)](https://zenodo.org/badge/latestdoi/372817270)

## Repository contents

1. Raw (unprocessed) virulence and antibiotic resistance (VAR) sequence files

- `raw/Diagnostic_genes.fa`: Antibiotic and resistance genes file
- `raw/Diagnostic_genes_phenotypes.tsv`: Tsv file containing phenotypes of the genes listed in `raw/Diagnostic_genes.fa`

2. Processed (intermediary) VAR sequence files

- `proc/diagnostic_genes.fa`: Antibiotic and resistance genes file
- `proc/phenotypes.tsv`: Tsv file containing phenotypes related with genes
- `proc/non-coding.txt`: A list of sequence names from `raw/Diagnostic_genes.fa` estimated by [Ariba](https://github.com/sanger-pathogens/ariba) to be non-coding when running [ariba prepareref](https://github.com/sanger-pathogens/ariba/wiki/Task:-prepareref) command on them
- `proc/*.{html,md}`: Html and markdown files of Jupyter notebooks. These are here just for archiving purposes.

The processed intermediary files were produced with jupyter notebooks in `bin`-directory inside conda environment defined by `environment.yml`.

3. The final VAR sequence files

- `final/coding.fa`: According to Ariba estimated coding sequences augmented by phenotype information in the fasta headers
- `final/non-coding.fa`: According to Ariba estimated non-coding sequences augmented by phenotype information in the fasta headers
- `final/coding_non-coding.fa`: A combination of the two above

The phenotype information is appended in the fasta headers preceded by `|||` in order to make it more machine readable.

4. Jupyter notebooks used to create final VAR sequences from the intermediary files (see 2. Processed (intermediary) VAR sequence files above)

- `bin/add_phenos_to_fasta.ipynb`: This Jupyter notebook appends corresponding phenotype data to fasta headers. This makes the phenotype data more accessible in downstream steps.
- `bin/gather_seqs.ipynb`: This Jupyter notebook reads a list of sequence identifiers from `proc/non-coding.txt` and collects those sequences from `final/coding_non-coding.fa` into `final/non-coding.fa` file as well as the ones left over to `final/coding.fa`.

5. Makefile

- `Makefile`: This runs most of what needs to be run.

6. Environment definition file

- `environment.yml` defines the environment inside which jupyter notebooks can be run and what the environment is for the binder instance that can be launched by clicking the badge in the main README.md file.

## How to add new genes?

1. Clone the repository in the path of your choosing:
  ```bash
  git clone https://github.com/Genomic-Medicine-Linkoping/var-genes-ro.git
  ```
2. Create conda environment required for running the jupyter notebooks
Navigate first to the cloned `var-genes-ro` directory and then run the following command:
  ```bash
  conda env create -f environment.yml
  ```
3. Add the newest fasta and phenotypes files to `raw` directory
It is important that the fasta file is named `Diagnostic_genes.fa` and the phenotypes file `Diagnostic_genes_phenotypes.tsv`. The phenotypes file should be in tsv format.

4. Create final files using `make`
Run the following make command. This command prepares gene and phenotypes files and creates the final fasta database files for use with e.g. [JASEN](https://github.com/Genomic-Medicine-Linkoping/JASEN/tree/ro-implementation) pipeline.
  ```bash
  make
  ```

**Note 1: This database is used at the university hospital of Linköping (Region Östergötland), Sweden.**

**Note 2: It is strongly recommended to perform verification of these sequences before taking them in to use in your own clinical setting.**
