# Trimming our Sequence Data to remove adapters and outliers
# Using Trimmomatic version 0.39

trimmomatic PE SRR10881857_1.fastq.gz SRR10881857_2.fastq.gz \ SRR10881857_1.trim.fastq.gz SRR10881857_1un.trim.fastq.gz \ SRR10881857_2.trim.fastq.gz SRR10881857_2un.trim.fastq.gz \ SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15

trimmomatic PE SRR12807846_1.fastq.gz SRR12807846_2.fastq.gz \ SRR12807846_1.trim.fastq.gz SRR12807846_1un.trim.fastq.gz \ SRR12807846_2.trim.fastq.gz SRR12807846_2un.trim.fastq.gz \ SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15

#Gives me feedback on input read pairs, both surviving sequences, reverse sequence surviving, reverse sequece surviving, and dropped reads.

#Alignment to a reference genome.
# First, i indexed the reference genome.

bwa index ~/Prefetch_Data/sra/untrimmed.fastq/fastq.file/SRR12807846_1.fasta

#This indexes my genome as the reference genome to be aligned and compared with my case genome.

#Aligning reads of the target genome to my reference genome
bwa mem SRR12807846_1.fasta SRR10881857_1.trim.fastq SRR10881857_2.trim.fastq > SRR10881857.aligned.sam

#Now I used samtoolkit to convert the .sam file to .bam.
samtools view -S -b SRR10881857.aligned.sam > SRR10881857.aligned.bam

#Now I sort the output
samtools sort -o SRR10881857.aligned.sorted.bam SRR10881857.aligned.bam

#To sort it, using samtoolkit
samtools index SRR10881857.aligned.sorted.bam

#Now we do a Variant call using BCFtools calling.First we calculate the read coverage in the genome.
bcftools mpileup -O b -o SRR10881857_raw.bcf \ -f SRR12807846_1.fasta SRR10881857.aligned.sorted.bam

# Detect SNV
bcftools call --ploidy 1 -m -v -o SRR10881857_variants.vcf SRR10881857_raw.bcf

#Filterint the SNV and reporting in in VCF
vcfutils.pl varFilter SRR10881857_variants.vcf > SRR10881857_final_variants.vcf

# Now we can explore the VCF format using the command less that gives us information about a predicted variation. 

# I assessed the alignement with samtools
samtools index SRR10881857_aligned.sorted.bam
#I used tview to align the genome with the reference genome.
samtools tview SRR10881857_aligned.sorted.bam SRR12807846_1.fasta
