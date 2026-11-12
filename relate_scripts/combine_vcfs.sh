chr=1
sample_list="MY_PATH/relate_sample_names.txt"


THG_file=$(find "$THG_dir" -name "ALL.chr${chr}.*.vcf.gz" -type f)
SGDP_file=$(find "$SGDP_dir" -name "*pub.${chr}.bcf" -type f)

genetic_map=$(find "$file_dir" -name "genetic_map_GRCh37_chr${chr}.txt" -type f)
mask_bed=$(find "$file_dir/masks" -name "all_human_mask_${chr}.bed" -type f)

first_position=$(tail -n +2 $genetic_map | head -n 1 | awk '{print $2}')
last_position=$(tail -n 1 $genetic_map | awk '{print $2}')

bcftools merge $THG_file $SGDP_file --threads 10 -Ou | \
    bcftools view -S "$sample_list" | \
    bcftools view -m2 -M2 -v snps -e 'GT[*]="mis"' -t "${chr}:${first_position}-${last_position}" | \
    bcftools view -T $mask_bed | \
    bcftools norm -d snps -o "$OUTPATH/PELAI_${chr}.vcf.gz"
