# Virulence and Antibiotic Resistance Genes database in Region Östergötland

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Genomic-Medicine-Linkoping/var-genes-ro/HEAD)

This repository contains:

1. Raw (unprocessed) virulence and antibiotic resistance (VAR) sequence files

- `raw/Diagnostic_genes_v3.fa`: Antibiotic and resistance genes file
- `raw/Diagnostic_genes_v3_phenotypes.csv`: Csv file containing phenotypes related with genes
- `raw/non-coding.txt`: A list of sequence names estimated by [Ariba](https://github.com/sanger-pathogens/ariba) to be non-coding when running [ariba prepareref](https://github.com/sanger-pathogens/ariba/wiki/Task:-prepareref) command on them

2. Processed (intermediary) VAR sequence files 

- `proc/diagnostic_genes.fa`: Antibiotic and resistance genes file
- `proc/phenotypes.csv`: Csv file containing phenotypes related with genes
- `proc/*.{html,md}`: Html and markdown files of Jupyter notebooks. These are here just for archiving purposes.

The processed intermediary files were produced with jupyter notebooks in `bin`-directory inside conda environment defined by `bin/exp.yml`.

3. The final VAR sequence files

- `coding.fa`: According to Ariba estimated coding sequences augmented by phenotype information in the fasta headers 
- `non-coding.fa`: According to Ariba estimated non-coding sequences augmented by phenotype information in the fasta headers
- `coding_non-coding.fa`: A concatenation of the two above

The phenotype information is appended in the fasta headers after `|||` in order to make it more machine readable.

4. Jupyter notebooks used to create final VAR sequences from intermediary files

- `bin/add_phenos_to_fasta.ipynb`: This Jupyter notebook appends corresponding phenotype data to fasta headers. This makes the phenotype data more accessible in downstream analyses.
- `bin/gather_seqs.ipynb`: This Jupyter notebook reads a list of sequence identifiers from `proc/phenotypes.csv` and gathers those sequences into `non-coding.fa` fasta file as well as the ones left over to `coding.fa`.

5. Makefile

- `Makefile`: This runs everything that needs to be run. E.g. `make` command will create all final and intermediary files.

This database is used in [JASEN](https://github.com/Genomic-Medicine-Linkoping/JASEN/tree/ro-implementation) pipeline at the university hospital of Linköping (Region Östergötland), Sweden.

**Note: It is strongly recommended to perform verification of these sequences before taking them in to use in your own clinical setting.**
