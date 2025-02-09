#Downloaded File from the Project PRJNA943550.
#Picking just 2 files run a mock test.
prefetch SRR108857 and prefetch SRR12807846

#To unzip the zipped file containing the sequence reads.
gunzip *.fastq.gz 

#Running Quality Control.
#Checking for Details of one of the file.
head -n 4 SRR108857_1.fastq

#Running a FastQC
fastqc *.fastq*

# Listing all the documents in the file. Transfering the .html files to their own folder.
# Decompressing the .zip files to view output on Terminal.
# Using a loop
for filename in *.zip
do
unzip $filename
done

#To check summary for one of the decompressed file.
less SRR108857_1_fastqc/summary.txt
#This gives us a summary of the quality score for each of the items.

#Concatenating all the summary.txt files together to a common file
cat */summary.txt > ~/Prefetch_Data/sra/untrimmed.fastq/fastqc_summaries.txt


