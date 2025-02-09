#Automating the  Fastqc Quality check
set -e
cd ~/Prefetch_Data/sra/untrimmed_fastq/

echo "Running FastQC ..."
fastqc *.fastq*

mkdir -p ~/Prefetch_Data/sra/fastqc_untrimmed_reads

echo "Saving FastQC results..."
mv *.zip ~/Prefetch_Data/sra/fastqc_untrimmed_reads/
mv *.html ~/Prefetch_Data/sra/fastqc_untrimmed_reads/

cd ~/Prefetch_Data/sra/fastqc_untrimmed_reads/

echo "Unzipping..."
for filename in *.zip
    do
    unzip $filename
    done

echo "Saving summary..."
cat */summary.txt > ~/Prefetch_Data/sra/fastqc_summaries.txt

