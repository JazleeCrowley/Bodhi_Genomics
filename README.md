# Bodhi Genomics

## Barcode Analysis
My first study is a genetic, barcode analysis of Ficus religiosa spread across the globe. This was done primarily through Sanger sequencing.

After sequencing the DNA I inspected the sequences and ran quality control in MEGA. After analyzing 137 sequences of 273 basepairs in length in DNAsp, I generated [this](./figures/HaplotypeDiversity.png) table that reports the genetic diversity statistics.

[Here](./figures/Haplotype_ChordDiagram.png) you will find a diagram visualizing where the different population haplotype frequencies are occurring across the globe, according to my current findings. [This](./figures/barcode_analysis.r) is the code that generated the diagram.

## Genomic Analysis
To expand my barcode analysis, I have also run at least 8 samples used in the barcode analysis through a Oxford Nanopore Native Kit using Adaptive Sampling methodology. Results from one run yielded low coverage, and variable read quality across samples when aligned against a reference.

Bases were called in Dorado and analyzed using Samtools. Alignments were made using minimap2, and were subsequently aligned using software Geneious Prime. This analysis was done in the OSU HPC cluster, with SLURM files found in our lab Github cluster folder. 
[This table](./figures/ONT_N50_QC.png) shows the output quality of 8 samples that represent variety across location and three haplotypes, while [this table](./figures/ONT_read_length_distribution.png) shows the % read length distribution across those same samples. After mapping to a reference chloroplast genome, we generated [this table](./figures/ONT_Mapping_QC.png) that shows quality of mapping to the reference.
