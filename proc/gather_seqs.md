# Gather sequences into fasta files based on an seq ID list


```python
from Bio import SeqIO as si
import csv
from collections import namedtuple
import re
```

## Read in a list of ids of non-coding sequences


```python
ids = []
with open("../raw/non-coding.txt", newline="") as infile:
    reader = csv.reader(infile)
    for row in reader:
        ids.append(row[0])
```


```python
ids[0]
```




    'PVL_EU368820'



## Read in all sequences


```python
seqs = si.to_dict(si.parse("../coding_non-coding.fa", "fasta"))
```


```python
len(seqs)
```




    578




```python
print(ids)
```

    ['PVL_EU368820', 'PVL_FJ821791', 'PVL_FJ895584', 'PVL_HM584701', 'PVL_HM584703', 'PVL_HM584704', 'PVL_HM584706', 'PVL_HM584708', 'PVL_JN635504', 'PVL_JN635506', 'PVL_JN635507', 'PVL_JN635508', 'PVL_JN635510', 'VanB_5_NG_048333_1', 'VanB_9_NG_048339_1', 'VanC_10_NG_048343_1', 'VanC_11_NG_048345_1', 'VanC_12_NG_048354_1', 'VanC_13_NG_048355_1', 'VanC_14_NG_048356_1', 'VanC_15_NG_048357_1', 'VanC_16', 'VanC_17', 'VanC_1_NG_048344_1', 'VanC_2_NG_048346_1', 'VanC_3_NG_048347_1', 'VanC_4_NG_048348_1', 'VanC_5_NG_048349_1', 'VanC_6_NG_048350_1', 'VanC_7_NG_048351_1', 'VanC_8_NG_048352_1', 'VanC_9_NG_048353_1', 'blaCMY_12', 'blaCMY_3', 'blaCTX_M_106', 'blaCTX_M_107_JF274244.1', 'blaCTX_M_108_JF274245.1', 'blaCTX_M_109_JF274248', 'blaCTX_M_110', 'blaKPC_9', 'blaPER_5', 'blaSHV_123_GQ390805', 'blaSHV_126_GQ390808', 'blaSHV_152', 'blaSHV_153', 'blaSHV_163', 'blaSHV_165', 'blaTEM_118_AY130285.1', 'blaTEM_199', 'blaTEM_205', 'blaTEM_21', 'blaTEM_22', 'blaTEM_42_X98047.1', 'blaTEM_89_AY039040']


## Form a list of non-coding sequences

... while removing them from the dictionary containing all sequences.


```python
non_coding = []
for id in ids:
    popped = seqs.pop(id)
    non_coding.append(popped)
```

## Write coding sequences


```python
coding = list(seqs.values())
si.write(coding, "../coding.fa", "fasta")
```




    524



## Write non-coding sequences


```python
si.write(non_coding, "../non-coding.fa", "fasta")
```




    54



## Do some sanity checks


```python
len(ids), len(non_coding)
```




    (54, 54)




```python
ids[0], ids[-1]
```




    ('PVL_EU368820', 'blaTEM_89_AY039040')




```python
non_coding[0], non_coding[-1]
```




    (SeqRecord(seq=Seq('ATGGTCAAAAAAAGACTATTAGCTGCAACATTGTCGTTAGGAATAATCACTCCT...TAA'), id='PVL_EU368820', name='PVL_EU368820', description='PVL_EU368820 |||PVL', dbxrefs=[]),
     SeqRecord(seq=Seq('ATGAGTATTCAACATTTCCGTGTCGCCCTTATTCCCTTTTTTGCGGCATTTTGC...ATA'), id='blaTEM_89_AY039040', name='blaTEM_89_AY039040', description='blaTEM_89_AY039040 |||ESBL_A', dbxrefs=[]))


