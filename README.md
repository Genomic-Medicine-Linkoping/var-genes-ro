# Virulence and Antibiotic Resistance Genes used in Region Östergötland

This repository contains:

1. Raw (unprocessed) virulence and antibiotic resistance (VAR) sequence files

- Antibiotic and resistance genes file: `raw/Diagnostic_genes_v3.fa`
- Csv file containing phenotypes related with genes: `raw/Diagnostic_genes_v3_phenotypes.csv`
- A list of sequence names estimated by [Ariba](https://github.com/sanger-pathogens/ariba `Ariba Github page`) to be non-coding when running [ariba prepareref](https://github.com/sanger-pathogens/ariba/wiki/Task:-prepareref) command on them: `raw/non-coding.txt`  

2. Processed (intermediary) VAR sequence files 

- Antibiotic and resistance genes file: `proc/diagnostic_genes.fa`
- Csv file containing phenotypes related with genes: `proc/phenotypes.csv`

The processed intermediary files were produced with jupyter notebooks in `bin`-directory inside conda environment defined by `bin/exp.yml`.

3. The final VAR sequence files

- According to Ariba estimated coding sequences augmented by phenotype information in the fasta headers: `coding.fa` 
- According to Ariba estimated non-coding sequences augmented by phenotype information in the fasta headers: `non-coding.fa`
- A concatenation of the two above: `coding_non-coding.fa`

The phenotype information is appended in the fasta headers after `|||`.

**Note that it is strongly recommended to perform verification of these sequences before taking them in to use in your own clinical setting.**

These genes are used in [gms-JASEN pipeline](https://github.com/Genomic-Medicine-Linkoping/gms-JASEN/tree/ro-implementation) (`ro-implementation` branch).