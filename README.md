# Virulence and Antibiotic Resistance Genes database in Region Östergötland

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Genomic-Medicine-Linkoping/var-genes-ro/HEAD)
[![DOI](https://zenodo.org/badge/372817270.svg)](https://zenodo.org/badge/latestdoi/372817270)

## Repository contents

1. Raw (unprocessed) virulence and antibiotic resistance (VAR) sequence files

- `raw/Diagnostic_genes.fa`: Antibiotic and resistance genes file
- `raw/Diagnostic_genes_phenotypes.tsv`: Csv file containing phenotypes related with genes
- `proc/non-coding.txt`: A list of sequence names estimated by [Ariba](https://github.com/sanger-pathogens/ariba) to be non-coding when running [ariba prepareref](https://github.com/sanger-pathogens/ariba/wiki/Task:-prepareref) command on them

2. Processed (intermediary) VAR sequence files 

- `proc/diagnostic_genes.fa`: Antibiotic and resistance genes file
- `proc/phenotypes.csv`: Csv file containing phenotypes related with genes
- `proc/*.{html,md}`: Html and markdown files of Jupyter notebooks. These are here just for archiving purposes.

The processed intermediary files were produced with jupyter notebooks in `bin`-directory inside conda environment defined by `bin/exp.yml`.

3. The final VAR sequence files

- `final/coding.fa`: According to Ariba estimated coding sequences augmented by phenotype information in the fasta headers 
- `final/non-coding.fa`: According to Ariba estimated non-coding sequences augmented by phenotype information in the fasta headers
- `final/coding_non-coding.fa`: A concatenation of the two above

The phenotype information is appended in the fasta headers after `|||` in order to make it more machine readable.

4. Jupyter notebooks used to create final VAR sequences from the intermediary files (see 2. Processed (intermediary) VAR sequence files above)

- `bin/add_phenos_to_fasta.ipynb`: This Jupyter notebook appends corresponding phenotype data to fasta headers. This makes the phenotype data more accessible in downstream analyses.
- `bin/gather_seqs.ipynb`: This Jupyter notebook reads a list of sequence identifiers from `proc/phenotypes.csv` and gathers those sequences into `non-coding.fa` fasta file as well as the ones left over to `coding.fa`.

5. Makefile

- `Makefile`: This runs most of what needs to be run.

6. Environment definition file

- `environment.yml` defines the environment for the binder instance that can be launched by clicking the badge in the main README.md file.

## How to add new genes?

1. Append the sequences in fasta format to `raw/Diagnostic_genes.fa` file.
2. Append new phenotypes in csv format to `raw/Diagnostic_genes_phenotypes.tsv` file.
3. Launch binder instance by clicking the badge in the main `README.md` file.

**NOTE: The following steps should be performed in the launched binder instance:**
4. Process the raw sequence file by homogenising, removing duplicate sequences, adding unique ID:s to same fasta headers: 
  ```bash
  make prepare_genes
  ```
5. Remove identical duplicate rows: 
  ```bash
  make prepare_phenos
  ```
6. Start a new terminal session.
7. Run the following in order to examine if there are any sequences that are deemed to be non-coding according to [Ariba](https://github.com/sanger-pathogens/ariba):
  ```bash
  ariba prepareref --all_coding yes -f proc/diagnostic_genes.fa out_dir
  ```
8. Update `proc/non-coding.txt`: 
  ```bash
  NONC=proc/non-coding.txt
  awk '/REMOVE/{print $1}' out_dir/01.filter.check_genes.log > "$NONC"
  ```
9. Add phenotype information in `proc/phenotypes.csv` to fasta headers in `proc/diagenostic_genes.fa` by running `bin/add_phenos_to_fasta.ipynb` jupyter notebook. This updates the file `coding_non-coding.fa`.
10. Separate files `final/non-coding.fa` and `final/coding.fa` based on `proc/non-coding.txt` file contents using `bin/gather_seqs.ipynb` jupyter notebook.

**Note: Both of these notebooks can also be run using the following make command: `make exec_ipynbs`**
11. Download (and upload to this repository (on the Github web site or otherwise)) the updated `non-coding.fa` and `coding.fa` files if need be.

This database is used in [JASEN](https://github.com/Genomic-Medicine-Linkoping/JASEN/tree/ro-implementation) pipeline at the university hospital of Linköping (Region Östergötland), Sweden.

**Note: It is strongly recommended to perform verification of these sequences before taking them in to use in your own clinical setting.**
