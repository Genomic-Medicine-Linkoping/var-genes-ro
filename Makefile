SHELL = /bin/bash

CURRENT_CONDA_ENV_NAME = var-genes-ro
# Note that the extra activate is needed to ensure that the activate floats env to the front of PATH
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate $(CURRENT_CONDA_ENV_NAME)

FASTACLEAN = ~/miniconda3/envs/var-genes-ro/bin/fastaclean
FASTADIFF = ~/miniconda3/envs/var-genes-ro/bin/fastadiff
SEQKIT = ~/miniconda3/envs/var-genes-ro/bin/seqkit
DIAG_GENES = proc/diagnostic_genes.fa
TEMP_DIAG_GENES = temp_diagnostic_genes.fa
RAW_PHENOS = raw/Diagnostic_genes_v3_phenotypes.csv
RAW_SEQS = raw/Diagnostic_genes_v3.fa
CODING = coding.fa
NONC = non-coding.fa
BOTH = coding_non-coding.fa
PHENOS = proc/phenotypes.csv

prepare_genes:
	@($(CONDA_ACTIVATE) ; $(FASTACLEAN) -f raw/Diagnostic_genes_v3.fa | \
	$(SEQKIT) replace -p ":filter.+" | \
	$(SEQKIT) rmdup --by-seq | \
	$(SEQKIT) rename -n | \
	$(SEQKIT) replace -p '(^.+)\s\S+' -r '$$1 dupID' > $(DIAG_GENES))

check_files:
	file $(BOTH) $(RAW_SEQS) $(RAW_PHENOS)

find_dups:
	@($(CONDA_ACTIVATE) ; $(FASTACLEAN) -f raw/Diagnostic_genes_v3.fa | \
	$(SEQKIT) replace -p ":filter.+" | \
	$(SEQKIT) rename -n > $(TEMP_DIAG_GENES) ; \
	$(FASTADIFF) -1 $(TEMP_DIAG_GENES) -2 $(DIAG_GENES) ; \
	rm -f $(TEMP_DIAG_GENES))

remove_dup_phenos:
	# Remove duplicate entries
	tail -n +2 $(RAW_PHENOS) | sort | uniq > $(PHENOS)
	# Insert csv header
	sed -i '1 i\
	name,phenotype' $(PHENOS)

clean:
	rm -f proc/*
