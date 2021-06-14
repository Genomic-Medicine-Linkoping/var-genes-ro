# Virulence and Antibiotic Resistance Genes database in Region Östergötland

This repository contains:

1. Raw (unprocessed) virulence and antibiotic resistance (VAR) sequence files

- `raw/Diagnostic_genes_v3.fa`: Antibiotic and resistance genes file
- `raw/Diagnostic_genes_v3_phenotypes.csv`: Csv file containing phenotypes related with genes
- `raw/non-coding.txt`: A list of sequence names estimated by [Ariba](https://github.com/sanger-pathogens/ariba) to be non-coding when running [ariba prepareref](https://github.com/sanger-pathogens/ariba/wiki/Task:-prepareref) command on them

2. Processed (intermediary) VAR sequence files 

- `proc/diagnostic_genes.fa`: Antibiotic and resistance genes file
- `proc/phenotypes.csv`: Csv file containing phenotypes related with genes

The processed intermediary files were produced with jupyter notebooks in `bin`-directory inside conda environment defined by `bin/exp.yml`.

3. The final VAR sequence files

- `coding.fa`: According to Ariba estimated coding sequences augmented by phenotype information in the fasta headers 
- `non-coding.fa`: According to Ariba estimated non-coding sequences augmented by phenotype information in the fasta headers
- `coding_non-coding.fa`: A concatenation of the two above

The phenotype information is appended in the fasta headers after `|||`.

This database is used in [JASEN](https://github.com/Genomic-Medicine-Linkoping/gms-JASEN/tree/ro-implementation) pipeline at the university hospital of Linköping, Sweden.

**Note: It is strongly recommended to perform verification of these sequences before taking them in to use in your own clinical setting.**
