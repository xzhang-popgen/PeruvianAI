module load gcc/13.2.0
module load R/4.3.2-mkl
module load perl-modules/1.0

MY_PATH="PATH/TO/DATA"
ANC_GENOME="PATH/TO/ANCESTRAL/GENOME"

for chr in $(cat relate_chr.txt); do

    haps_outname="$MY_PATH/input/PELAI_${chr}"
    annot_name="$MY_PATH/input/PELAI_${chr}"

    $PATH_TO_RELATE/bin/RelateFileFormats \
        --mode ConvertFromVcf \
        --haps $haps_outname.haps \
        --sample $haps_outname.sample \
        --chr $chr \
        -i $infile

#	Prepares input files for Relate. The script will remove non-biallelic SNPs, flip haplotypes 
#	according to the ancestral genome such that the ancestral allele is always denoted by 0, 
#	remove samples if specified, filter SNPs and adjust distances between SNPs using a genomic
#	mask if specified, and generate SNP annotations needed for some add-on modules

    $PATH_TO_RELATE/scripts/PrepareInputFiles/PrepareInputFiles.sh \
        --haps $haps_outname.haps \
        --sample $haps_outname.sample \
        --ancestor $ANC_GENOME/human_ancestor_$chr.fa \
        --poplabels  $MY_PATH/input/PELAI.poplabels \
        -o $annot_name
    


done
